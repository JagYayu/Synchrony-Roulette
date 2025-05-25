local RouletteCursor = require "Roulette.Cursor"
local RouletteGambler = {}
local RouletteJudge = require "Roulette.Judge"
local RouletteRogueItem = require "Roulette.RogueItem"
local RouletteUtility = require "Roulette.Utility"
local RouletteVisuals = require "Roulette.render.Visuals"

local Ability = require "necro.game.system.Ability"
local Action = require "necro.game.system.Action"
local Character = require "necro.game.character.Character"
local Collision = require "necro.game.tile.Collision"
local Color = require "system.utils.Color"
local Currency = require "necro.game.item.Currency"
local Damage = require "necro.game.system.Damage"
local Dig = require "necro.game.tile.Dig"
local ECS = require "system.game.Entities"
local EntitySelector = require "system.events.EntitySelector"
local Facing = require "necro.game.character.Facing"
local Focus = require "necro.game.character.Focus"
local Inventory = require "necro.game.item.Inventory"
local Kill = require "necro.game.character.Kill"
local Object = require "necro.game.object.Object"
local ObjectSelector = require "necro.game.object.ObjectSelector"
local Settings = require "necro.config.Settings"
local Sound = require "necro.audio.Sound"
local Spell = require "necro.game.spell.Spell"
local Team = require "necro.game.character.Team"
local TextPool = require "necro.config.i18n.TextPool"
local Utilities = require "system.utils.Utilities"
local Voice = require "necro.audio.Voice"

local entityExists = ECS.entityExists
local getEntityByID = ECS.getEntityByID
local max = math.max

SettingSpectateSuicide = Settings.shared.bool {
	id = "spectateSuicide",
	name = "Suicide on spectate",
	default = true,
}

--- @param gambler Component.Roulette_gambler
function RouletteGambler.isGambling(gambler)
	return entityExists(gambler.cursor)
end

--- Find an item placement.
--- @param gamblerEntity Entity
function RouletteGambler.findAvailablePlacements(gamblerEntity)
	if not gamblerEntity.Roulette_gambler or not gamblerEntity.position then
		return RouletteUtility.emptyTable
	end

	local availableTiles = {}

	for offsetX, offsetY in RouletteUtility.iterateOffsetsInRange(gamblerEntity.Roulette_gambler.placementRange) do
		local x, y = gamblerEntity.position.x + offsetX, gamblerEntity.position.y + offsetY
		if not Collision.check(x, y, Collision.Group.ITEM_PLACEMENT) then
			availableTiles[#availableTiles + 1] = { x, y }
		end
	end

	return availableTiles
end

-- Gambler shrine specific event selectors
local gamblerJoinShrineMatchSelectorFire
local gamblerQuitShrineMatchSelectorFire
do
	local orders = {
		"judge",
		"team",
		"color",
	}
	gamblerJoinShrineMatchSelectorFire = EntitySelector.new(event.Roulette_gamblerJoin, orders).fire
	gamblerQuitShrineMatchSelectorFire = EntitySelector.new(event.Roulette_gamblerQuit, orders).fire
end

function RouletteGambler.addShrineHandler(shrineName)
	event.shrine.add("gamblerShrine" .. shrineName, shrineName, function(ev)
		local judge = ev.entity.Roulette_judge
		local gambler = ev.interactor.Roulette_gambler
		if judge and gambler and not RouletteJudge.hasStarted(judge) then
			local index = Utilities.arrayFind(judge.gamblers, ev.interactor.id)
			if index then
				table.remove(judge.gamblers, index)

				--- @class Event.Roulette_gamblerQuit : Event.Roulette_gamblerJoin
				local ev1 = {
					entity = ev.interactor,
					component = gambler,
					judgeEntity = ev.entity,
					judgeComponent = judge,
				}
				gamblerQuitShrineMatchSelectorFire(ev1, ev.interactor.name)
			elseif #judge.gamblers < #judge.locations then
				judge.gamblers[#judge.gamblers + 1] = ev.interactor.id

				--- @class Event.Roulette_gamblerJoin
				--- @field entity Entity
				--- @field component Component.Roulette_gambler
				--- @field judgeEntity Entity
				--- @field judgeComponent Component.Roulette_judge
				local ev1 = {
					entity = ev.interactor,
					component = gambler,
					judgeEntity = ev.entity,
					judgeComponent = judge,
				}
				gamblerJoinShrineMatchSelectorFire({
					entity = ev.interactor,
					component = gambler,
					judgeEntity = ev.entity,
					judgeComponent = judge,
				}, ev.interactor.name)
			end
		end

		if ev.entity.shrine then
			ev.entity.shrine.active = false
		end
	end)
end

--- @param ev Event.Roulette_gamblerJoin
event.Roulette_gamblerJoin.add("gamblerSetJudge", "judge", function(ev)
	ev.component.judge = ev.judgeEntity.id
end)

event.Roulette_gamblerJoin.add("gamblerSetTeam", {
	filter = { "Roulette_gamblerTeamVanilla", "team" },
	order = "team",
}, function(ev) --- @param ev Event.Roulette_gamblerJoin
	ev.component.team = ev.entity.team.id
end)

--- @param ev Event.Roulette_gamblerQuit
event.Roulette_gamblerQuit.add("gamblerRemoveJudge", "judge", function(ev)
	ev.component.judge = 0
end)

--- @param ev Event.Roulette_gamblerQuit
event.Roulette_gamblerQuit.add("gamblerResetTeam", "team", function(ev)
	ev.component.team = 0
end)

event.Roulette_gamblerQuit.add("gamblerColor", {
	filter = "Roulette_gamblerColor",
	order = "color",
}, function(ev) --- @param ev Event.Roulette_gamblerQuit
	ev.entity.Roulette_gamblerColor.color = Color.TRANSPARENT
end)

local gamblerBeginTurnSelectorFire = EntitySelector.new(event.Roulette_gamblerBeginTurn, {
	"reset",
	"status",
	"stasis",
	"delay",
	"rigid",
	"hop",
	"gambler",
	"cursor",
	"gun",
	"item",
	"ai",
	"spawn",
	"hud",
	"nextTurn",
}).fire

event.Roulette_gamblerBeginTurn.add("reset", "reset", function(ev)
	RouletteUtility.resetField(ev.entity, "Roulette_gambler", "extraActions")
end)

event.Roulette_gamblerBeginTurn.add("statusFreezeSuppress", {
	filter = "Roulette_gamblerStatusFreeze",
	order = "status",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_gamblerBeginTurn
	if not ev.suppressed and ev.entity.Roulette_gamblerStatusFreeze.turns > 0 then
		ev.suppressed = true
	end
end)

--- @param ev Event.Roulette_gamblerBeginTurn
event.Roulette_gamblerBeginTurn.add("turnDelay", "delay", function(ev)
	if not ev.suppressed and ev.component.turnDelay > 0 then
		ev.component.turnDelay = ev.component.turnDelay - 1
		ev.suppressed = true
	end
end)

event.Roulette_gamblerBeginTurn.add("beatDelaySkipTurn", {
	filter = { "Roulette_gamblerBeatDelay", "beatDelay" },
	order = "delay",
}, function(ev) ---@param ev Event.Roulette_gamblerBeginTurn
	if not ev.suppressed then
		if ev.entity.beatDelay.counter > 0 then
			if ev.entity.Roulette_gamblerBeatDelay.autoCountdown then
				ev.entity.beatDelay.counter = math.max(0, ev.entity.beatDelay.counter - 1)
			end

			ev.suppressed = true
		elseif ev.entity.Roulette_gamblerBeatDelay.autoReset then
			ev.entity.beatDelay.counter = ev.entity.beatDelay.interval - 1
		end
	end
end)

event.Roulette_gamblerBeginTurn.add("stunSkipTurn", {
	filter = "stun",
	order = "delay",
}, function(ev) ---@param ev Event.Roulette_gamblerBeginTurn
	if ev.entity.stun.counter > 0 then
		ev.entity.stun.counter = max(0, ev.entity.stun.counter - 1)
		ev.suppressed = true
	end
end)

event.Roulette_gamblerBeginTurn.add("rigidSuppress", {
	filter = "Roulette_gamblerRigid",
	order = "rigid",
}, function(ev) --- @param ev Event.Roulette_gamblerBeginTurn
	ev.suppressed = true
end)

event.Roulette_gamblerBeginTurn.add("hopInPlace", {
	filter = "Roulette_gamblerBeginTurnHop",
	order = "hop",
}, function(ev) --- @param ev Event.Roulette_gamblerBeginTurn
	if not ev.suppressed then
		Character.hopInPlace(ev.entity)
	end
end)

--- @param ev Event.Roulette_gamblerBeginTurn
event.Roulette_gamblerBeginTurn.add("gamblerEnableTurn", "gambler", function(ev)
	if not ev.suppressed then
		ev.component.turn = true
	end
end)

function RouletteGambler.beginTurn(entity)
	if entity.Roulette_gambler then
		--- @class Event.Roulette_gamblerBeginTurn
		--- @field entity Entity
		--- @field component Component.Roulette_gambler
		--- @field suppressed boolean
		local ev = {
			entity = entity,
			component = entity.Roulette_gambler,
			suppressed = false,
		}
		gamblerBeginTurnSelectorFire(ev, entity.name)
		return ev
	end
end

--- @param ev Event.Roulette_sequenceJudgeNextTurn
event.Roulette_judgeNextTurn.add("gamblerBeginTurn", "beginTurn", function(ev)
	local entity = getEntityByID(ev.component.gamblers[ev.component.gamblerIndex] or 0)
	if entity then
		RouletteGambler.beginTurn(entity)
	end
end)

local gamblerEndTurnSelectorFire = EntitySelector.new(event.Roulette_gamblerEndTurn, {
	"reset",
	"gambler",
	"status",
	"disengage",
	"cursor",
	"gun",
	"item",
	"text",
}).fire

event.Roulette_gamblerEndTurn.add("gamblerDisableTurn", "gambler", function(ev)
	ev.component.turn = false
end)

--- @param entity Entity
--- @param parameter DelayEvent.SequenceJudgeNextTurnParameter?
--- @return Event.Roulette_gamblerEndTurn?
function RouletteGambler.endTurn(entity, parameter)
	if entity.Roulette_gambler and entity.Roulette_gambler.turn then
		--- @class Event.Roulette_gamblerEndTurn
		--- @field entity Entity
		--- @field component Component.Roulette_gambler
		--- @field judgeEntity Entity?
		--- @field parameter DelayEvent.SequenceJudgeNextTurnParameter?
		local ev = {
			entity = entity,
			component = entity.Roulette_gambler,
			judgeEntity = getEntityByID(entity.Roulette_gambler.judge),
			parameter = parameter,
		}
		gamblerEndTurnSelectorFire(ev, entity.name)
		return ev
	end
end

--- @param ev Event.Roulette_sequenceJudgeNextTurn
event.Roulette_sequenceJudgeNextTurn.add("gamblerEndTurn", "endTurn", function(ev)
	for _, id in ipairs(ev.component.gamblers) do
		local entity = getEntityByID(id)
		if entity then
			RouletteGambler.endTurn(entity, ev.parameter)
		end
	end
end)

local gamblerStartGameSelectorFire = EntitySelector.new(event.Roulette_gamblerStartGame, {
	"reset",
	"team",
	"facing",
	"color",
	"ai",
	"cursor",
	"selectable",
	"tiles",
	"items",
	"abilities",
}).fire

--- @param ev Event.Roulette_gamblerStartGame
event.Roulette_gamblerStartGame.add("removeIDFromOtherRogueJudges", "reset", function(ev)
	for judgeEntity in ECS.entitiesWithComponents { "Roulette_judgeRogue" } do
		if judgeEntity.id ~= ev.judgeEntity.id then
			Utilities.arrayRemove(judgeEntity.Roulette_judge.gamblers, ev.entity.id)
		end
	end
end)

event.Roulette_gamblerStartGame.add("setTeamFromVanillaComponent", {
	filter = { "Roulette_gamblerTeamVanilla", "team" },
	order = "team",
}, function(ev) --- @param ev Event.Roulette_gamblerStartGame
	ev.component.team = ev.entity.team.id
end)

event.Roulette_gamblerStartGame.add("setFacing", {
	filter = { "facingDirection", "position" },
	order = "facing",
}, function(ev) --- @param ev Event.Roulette_gamblerStartGame
	local dx = (ev.judgeEntity.position and ev.judgeEntity.position.x or 0) + ev.judgeComponent.x - ev.entity.position.x
	local dy = (ev.judgeEntity.position and ev.judgeEntity.position.y or 0) + ev.judgeComponent.y - ev.entity.position.y
	Facing.setDirection(ev.entity, Action.getDirection(dx, dy))
end)

event.Roulette_gamblerStartGame.add("setColor", {
	filter = "Roulette_gamblerColor",
	order = "color",
}, function(ev) --- @param ev Event.Roulette_gamblerStartGame
	local location = ev.index and ev.judgeComponent.locations[ev.index]
	if location and type(location[3]) == "number" then
		ev.entity.Roulette_gamblerColor.color = location[3]
	elseif ev.entity.controllable and ev.entity.team and ev.entity.team.id == Team.Id.PLAYER then
		ev.entity.Roulette_gamblerColor.color = RouletteVisuals.getPlayerGamblerColor(ev.entity.controllable.playerID)
	end
end)

event.Roulette_gamblerStartGame.add("aggro", {
	filter = "aggro",
	order = "ai",
}, function(ev)
	local entity = ev.entity
	if not entity.aggro.active then
		entity.aggro.active = true

		if entity.voiceAggro and not entity.voiceAggro.done then
			Voice.play(entity, entity.voiceAggro, { attenuation = 4 })
			entity.voiceAggro.done = true
		end

		if entity.aggroSetBeatDelay and (not entity.spawnInvincibility or not entity.spawnInvincibility.active) then
			entity.beatDelay.counter = math.max(entity.beatDelay.counter - 1, 0)
		end
	end
end)

event.Roulette_gamblerStartGame.add("beatDelayReset", {
	filter = { "!Roulette_gamblerStartGameNoBeatDelayReset", "beatDelay" },
	order = "ai",
}, function(ev)
	ev.entity.beatDelay.counter = 0
end)

event.Roulette_gamblerStartGame.add("breakTiles", {
	filter = "position",
	order = "tiles",
}, function(ev)
	for _, direction in ipairs(Action.Direction.valueList) do
		local dx, dy = Action.getMovementOffset(direction)
		Dig.breakTile(ev.entity.position.x + dx, ev.entity.position.y + dy, Dig.Strength.UNBREAKABLE, nil, direction)
	end
end)

local holderGamblerStartGameSelectorFire = EntitySelector.new(event.Roulette_holderGamblerStartGame, {
	"armor",
	"charge",
}).fire

event.Roulette_gamblerStartGame.add("items", {
	filter = "inventory",
	order = "items",
}, function(ev) --- @param ev Event.Roulette_gamblerEndGame
	--- Selector is based on `ev.item`
	--- @class Event.Roulette_holderGamblerStartGame : Event.Roulette_gamblerEndGame
	--- @field item Entity

	--- @cast ev Event.Roulette_holderGamblerStartGame

	local item_ = ev.item

	for _, item in ipairs(Inventory.getItems(ev.entity)) do
		ev.item = item
		holderGamblerStartGameSelectorFire(ev, item.name)
	end

	ev.item = item_
end)

function RouletteGambler.startGame(gamblerEntity, judgeEntity, index)
	if gamblerEntity.Roulette_gambler and judgeEntity.Roulette_judge then
		--- @class Event.Roulette_gamblerStartGame
		--- @field entity Entity
		--- @field component Component.Roulette_gambler
		--- @field judgeEntity Entity
		--- @field judgeComponent Component.Roulette_judge
		--- @field index integer? @The entity index inside judge's gambler list.
		local gamblerStartGameEv = {
			entity = gamblerEntity,
			component = gamblerEntity.Roulette_gambler,
			judgeEntity = judgeEntity,
			judgeComponent = judgeEntity.Roulette_judge,
			index = index,
		}
		gamblerStartGameSelectorFire(gamblerStartGameEv, gamblerEntity.name)
	end
end

event.Roulette_judgeStartGame.add("gamblerStartGame", "gambler", function(ev)
	for index, gamblerEntity in ipairs(ev.gamblerEntities) do
		RouletteGambler.startGame(gamblerEntity, ev.entity, index)
	end
end)

function RouletteGambler.deleteBelongingItems(entity)
	for itemEntity in ECS.entitiesWithComponents { "Roulette_item", "Roulette_selectable" } do
		if itemEntity.Roulette_selectable.belonging == entity.id then
			Object.delete(itemEntity)
		end
	end
end

--- Use `RouletteGambler.deleteBelongingItems` instead.
--- @deprecated typo
RouletteGambler.deleteBeloningItems = RouletteGambler.deleteBelongingItems

event.Roulette_gamblerEndGame.add("deleteItems", "delete", function(ev)
	RouletteGambler.deleteBelongingItems(ev.entity)
end)

local gamblerEndGameSelectorFire = EntitySelector.new(event.Roulette_gamblerEndGame, {
	"endTurn",
	"delete", -- forward `deletion` order to ensure entities can be removed from judge correctly.
	"reset",
	"ai",
	"items",
	"spell",
	"move",
	"statistic",
}).fire

--- @param ev Event.Roulette_gamblerEndGame
event.Roulette_gamblerEndGame.add("endTurn", "endTurn", function(ev)
	if ev.component.turn then
		RouletteGambler.endTurn(ev.entity, { delayTimeOverride = 0 })
	end
end)

--- @param ev Event.Roulette_gamblerEndGame
event.Roulette_gamblerEndGame.add("resetFields", "reset", function(ev)
	ev.component.cursor = 0
	ev.component.judge = 0
	ev.component.turn = false
	ev.component.turnDelay = 0
end)

event.Roulette_gamblerEndGame.add("deaggro", {
	filter = "aggro",
	order = "ai",
}, function(ev) --- @param ev Event.Roulette_gamblerEndGame
	local entity = ev.entity
	if entity.aggro.active then
		entity.aggro.active = false

		if entity.voiceAggro and not entity.voiceAggro.done then
			Voice.play(entity, entity.voiceAggro, { attenuation = 4 })
			entity.voiceAggro.done = false
		end
	end
end)

local holderGamblerEndGameSelectorFire = EntitySelector.new(event.Roulette_holderGamblerEndGame, {
	"discharge",
}).fire

event.Roulette_gamblerEndGame.add("items", {
	filter = "inventory",
	order = "items",
}, function(ev) --- @param ev Event.Roulette_gamblerEndGame
	local item_ = ev.item

	for _, item in ipairs(Inventory.getItems(ev.entity)) do
		ev.item = item
		holderGamblerEndGameSelectorFire(ev, item.name)
	end

	ev.item = item_
end)

event.Roulette_gamblerEndGame.add("spellcast", {
	filter = "Roulette_gamblerEndGameCast",
	order = "spell",
}, function(ev) --- @param ev Event.Roulette_gamblerEndGame
	Spell.cast(ev.entity, ev.entity.Roulette_gamblerEndGameCast.spell)
end)

--- @param gamblerEntity Entity
--- @param judgeEntity Entity?
function RouletteGambler.endGame(gamblerEntity, judgeEntity)
	if not judgeEntity then
		judgeEntity = gamblerEntity.Roulette_gambler and getEntityByID(gamblerEntity.Roulette_gambler.judge)
		if not judgeEntity then
			return
		end
	end

	if gamblerEntity.Roulette_gambler and judgeEntity.Roulette_judge then
		if Utilities.arrayFind(judgeEntity.Roulette_judge.gamblers, gamblerEntity.id) then
			RouletteJudge.removeGambler(judgeEntity, gamblerEntity)
		end

		--- @class Event.Roulette_gamblerEndGame
		--- @field entity Entity
		--- @field component Component.Roulette_gambler
		--- @field judgeEntity Entity
		--- @field judgeComponent Component.Roulette_judge
		--- @field item? Entity
		local ev = {
			entity = gamblerEntity,
			component = gamblerEntity.Roulette_gambler,
			judgeEntity = judgeEntity,
			judgeComponent = judgeEntity.Roulette_judge,
		}
		gamblerEndGameSelectorFire(ev, gamblerEntity.name)
	end
end

event.Roulette_judgeEndGame.add("gamblersEndGame", {
	order = "gambler",
	sequence = -1,
}, function(ev) --- @param ev Event.Roulette_judgeEndGame
	for _, gamblerEntity in ipairs(ev.gamblerEntities) do
		RouletteGambler.endGame(gamblerEntity, ev.entity)
	end
end)
event.objectSpectate.add("gamblerSuicide", {
	filter = "Roulette_gambler",
	order = "checkDescent",
}, function(ev) --- @param ev Event.ObjectSpectate
	if not ev.suppressed then
		local judgeEntity = getEntityByID(ev.entity.Roulette_gambler.judge)
		if SettingSpectateSuicide then
			if judgeEntity and judgeEntity.Roulette_judge and RouletteJudge.hasStarted(judgeEntity.Roulette_judge) then
				Object.kill(ev.entity, judgeEntity, TextPool.get "mod.Roulette.spectatorKiller")
			end
		else
			RouletteGambler.endGame(ev.entity, judgeEntity)
		end
	end
end)

local Action_Special_Bomb = Action.Special.BOMB

event.objectGetActionItem.add("gamblerCursor", {
	filter = "Roulette_gambler",
	order = "virtualItems",
}, function(ev)
	if not ev.item and ev.action == Action_Special_Bomb then
		ev.item = getEntityByID(ev.entity.Roulette_gambler.cursor)
	end
end)

event.objectSpecialAction.add("useActiveItem", {
	filter = "Roulette_gambler",
	order = "item",
}, function(ev)
	if ev.result == nil and ev.action == Action_Special_Bomb then
		local cursorEntity = getEntityByID(ev.entity.Roulette_gambler.cursor)
		if cursorEntity then
			ev.result = RouletteCursor.interact(cursorEntity)
		end
	end
end)

event.objectCheckAbility.add("gamblerAbility", {
	filter = "Roulette_gambler",
	order = "actionRemap",
}, function(ev)
	if ev.entity.Roulette_gambler.judge ~= 0 and ev.entity.Roulette_gambler.cursor ~= 0 then
		ev.flags = Ability.Type.SUB_BEAT
		ev.Roulette_override = true
	end
end)

do
	local function checkAction(act)
		return act == RouletteCursor.ActionCursorInteractAt or Action.isDirection(act)
	end

	event.objectCheckAbility.add("increaseBeatCounter", {
		filter = "beatCounter",
		order = "hasActed",
	}, function(ev)
		if ev.Roulette_override and checkAction(ev.action) and not ev.client then
			ev.entity.beatCounter.counter = ev.entity.beatCounter.counter + 1
		end
	end)
end

local gamblersTurnData
function RouletteGambler.getGamblersTurnData()
	return gamblersTurnData
end

event.turn.add("gamblerActivation", {
	order = "playerActions",
	sequence = 1,
}, function(ev)
	gamblersTurnData = nil

	for _, action in ipairs(ev.actionQueue) do
		if action.ev and action.ev.action ~= Action.System.DELAY and action.abilityFlags == Ability.Type.SUB_BEAT
			and action.entity.Roulette_gambler and RouletteGambler.isGambling(action.entity.Roulette_gambler)
		then
			local judgeEntity = RouletteJudge.getFromGamblerEntity(action.entity)
			if judgeEntity then
				gamblersTurnData = gamblersTurnData or {}
				gamblersTurnData[judgeEntity] = gamblersTurnData[judgeEntity] or {}
				local list = gamblersTurnData[judgeEntity]
				list[#list + 1] = action.entity
				ev.Roulette_gamblersTurn = gamblersTurnData
			end
		end
	end
end)

event.objectDeath.add("gamblerCurrency", {
	filter = { "Roulette_gamblerCurrency", "Roulette_gambler", "position" },
	order = "currencyDrop",
}, function(ev) --- @param ev Event.ObjectDeath
	if RouletteGambler.isGambling(ev.entity.Roulette_gambler) then
		Kill.disableCredit(ev.entity, Kill.Credit.CURRENCY)

		local comp = ev.entity.Roulette_gamblerCurrency
		local userEntity = ev.killer and ev.killer.Roulette_gun and getEntityByID(ev.killer.Roulette_gun.gambler)

		local multiplier = 1
		if userEntity and userEntity.id ~= ev.entity.id then
			if userEntity.grooveChain then
				multiplier = max(multiplier, userEntity.grooveChain.multiplier)
			end

			if RouletteRogueItem.getEquippedItem(userEntity, "Roulette_itemMoreGolds") then
				multiplier = multiplier + 1
			end
		end

		Currency.create(comp.currencyType, ev.entity.position.x, ev.entity.position.y, comp.amount * multiplier)
	end
end)

do
	local function finalizeGambler(ev)
		local judgeEntity = RouletteJudge.getFromGamblerEntity(ev.entity)
		if not judgeEntity then
			return
		end

		RouletteJudge.removeGambler(judgeEntity, ev.entity)
		RouletteGambler.deleteBelongingItems(ev.entity)
		ev.entity.Roulette_gambler.cursor = 0
		ev.entity.Roulette_gambler.judge = 0
		ev.entity.Roulette_gambler.turn = false
	end

	event.objectDeath.add("finalizeGambler", {
		filter = "Roulette_gambler",
		order = "runSummary",
		sequence = 1,
	}, finalizeGambler)

	event.objectDelete.add("finalizeGambler", {
		filter = "Roulette_gambler",
		order = "effects",
	}, finalizeGambler)

	event.objectDescentEnd.add("finalizeGambler", {
		filter = "Roulette_gambler",
		order = "targetTurn",
	}, finalizeGambler)
end

event.objectTakeDamage.add("gamblerShield", {
	filter = "Roulette_gamblerStatusShield",
	order = "shield",
}, function(ev) --- @param ev Event.ObjectTakeDamage
	if ev.entity.Roulette_gamblerStatusShield.turns > 0 and not Damage.Flag.check(ev.type, Damage.Flag.SELF_DAMAGE) then
		ev.entity.Roulette_gamblerStatusShield.turns = ev.entity.Roulette_gamblerStatusShield.turns - 1
		ev.damage = 0
	end
end)

event.objectTakeDamage.add("gamblerShrink", {
	filter = "Roulette_gamblerStatusShrink",
	order = "dwarfism",
}, function(ev) --- @param ev Event.ObjectTakeDamage
	if ev.entity.Roulette_gamblerStatusShrink.turns > 0 and not Damage.Flag.check(ev.type, Damage.Flag.SELF_DAMAGE) then
		ev.damage = ev.damage * 2
	end
end)

event.objectVocalize.add("gamblerShrinkVoicePitch", {
	filter = "Roulette_gamblerStatusShrink",
	order = "dwarfism",
}, function(ev) --- @param ev Event.ObjectVocalize
	if ev.entity.Roulette_gamblerStatusShrink.turns > 0 then
		ev.pitch = (ev.pitch or 1) * ev.entity.Roulette_gamblerStatusShrink.voicePitchMultiplier
	end
end)

function RouletteGambler.isFreezing(gamblerEntity)
	return gamblerEntity.Roulette_gamblerStatusFreeze and gamblerEntity.Roulette_gamblerStatusFreeze.turns > 0 or false
end

local gamblerFreezeSelectorFire = ObjectSelector.new("Roulette_gamblerFreeze", {
	"enhance",
	"particle",
	"immunity",
	"skipTurn",
}).fire

event.objectRoulette_gamblerFreeze.add("freezerMageEnhance", "enhance", function(ev)
	if ev.freezer and RouletteRogueItem.getEquippedItem(ev.freezer, "Roulette_itemMana") then
		ev.turns = ev.turns + 1
	end
end)

event.objectRoulette_gamblerFreeze.add("shieldImmunity", {
	filter = "Roulette_gamblerStatusShield",
	order = "immunity",
}, function(ev)
	if ev.turns > 0 and ev.victim.Roulette_gamblerStatusShield.turns > 0 then
		ev.turns = 0
	end
end)

event.objectRoulette_gamblerFreeze.add("skipTurn", {
	filter = "Roulette_gambler",
	order = "skipTurn",
}, function(ev)
	if ev.turns > 0 then
		RouletteGambler.endTurn(ev.entity)
	end
end)

--- Freeze gambler and play particles, but does not play sounds.
--- @param gamblerEntity Entity
--- @param turns integer
--- @param userEntity Entity?
function RouletteGambler.freeze(gamblerEntity, turns, userEntity)
	if gamblerEntity.Roulette_gamblerStatusFreeze then
		--- @class Event.Roulette_gamblerFreeze
		--- @field victim Entity
		--- @field status Component.Roulette_gamblerStatusFreeze
		--- @field freezer Entity?
		--- @field turns integer
		local ev = {
			entity = gamblerEntity,
			victim = gamblerEntity,
			status = gamblerEntity.Roulette_gamblerStatusFreeze,
			freezer = userEntity,
			turns = turns,
		}
		gamblerFreezeSelectorFire(ev, gamblerEntity)
		ev.status.turns = max(ev.status.turns, ev.turns)
	end
end

function RouletteGambler.isShielding(gamblerEntity)
	return gamblerEntity.Roulette_gamblerStatusShield and gamblerEntity.Roulette_gamblerStatusShield.turns > 0 or false
end

--- @param gamblerEntity Entity
--- @param turns number
function RouletteGambler.shield(gamblerEntity, turns)
	if gamblerEntity.Roulette_gamblerStatusShield then
		if gamblerEntity and RouletteRogueItem.getEquippedItem(gamblerEntity, "Roulette_itemMana") then
			turns = turns + 1
		end

		gamblerEntity.Roulette_gamblerStatusShield.turns = max(gamblerEntity.Roulette_gamblerStatusShield.turns, turns)
	end
end

function RouletteGambler.isSilenced(gamblerEntity)
	return gamblerEntity.Roulette_gamblerStatusSilence and gamblerEntity.Roulette_gamblerStatusSilence.turns > 0 or false
end

--- @param gamblerEntity Entity
--- @param turns integer
function RouletteGambler.silence(gamblerEntity, turns)
	if gamblerEntity.Roulette_gamblerStatusSilence then
		gamblerEntity.Roulette_gamblerStatusSilence.turns = max(gamblerEntity.Roulette_gamblerStatusSilence.turns, turns)
		RouletteGambler.updateSilenceAudio()
	end
end

--- @type integer | false
SilenceAudioID = false
SilenceAudioPendingUpdate = true

function RouletteGambler.updateSilenceAudio()
	SilenceAudioPendingUpdate = true
end

event.focusedEntitiesChanged.add("updateSilenceAudio", "audioLoop", RouletteGambler.updateSilenceAudio)
event.turn.add("updateSilenceAudio", "musicLayers", RouletteGambler.updateSilenceAudio)
event.tick.add("silenceAudioPendingUpdate", "sound", function()
	if not SilenceAudioPendingUpdate then
		return
	end
	SilenceAudioPendingUpdate = false

	SilenceAudioID = (SilenceAudioID and Sound.isPlaying(SilenceAudioID) and SilenceAudioID) or Sound.play("bansheeLoop", nil, nil, {
		loop = true,
		volume = 1,
		useHighestVolume = true,
		port = Sound.Port.PERSONAL,
	})

	Sound.setVolume(SilenceAudioID, 0)
	for _, entity in ipairs(Focus.getAll(Focus.Type.SPECTATE_MULTIPLE)) do
		if entity.Roulette_gamblerStatusSilence and entity.Roulette_gamblerStatusSilence.turns > 0 then
			Sound.setVolume(SilenceAudioID, 1)

			return
		end
	end
end)

function RouletteGambler.charm(gamblerEntity, charmerEntity, turns)
	local charm = gamblerEntity.Roulette_gamblerCharmable
	if charm and charmerEntity.Roulette_gambler then
		charm.color = charmerEntity.Roulette_gamblerColor and charmerEntity.Roulette_gamblerColor.color or charm.color
		charm.team = charmerEntity.Roulette_gambler.team
		charm.turns = turns
	end
end

function RouletteGambler.uncharm(gamblerEntity)
	local charm = gamblerEntity.Roulette_gamblerCharmable
	if charm and gamblerEntity.Roulette_gambler then
		charm.color = Color.TRANSPARENT
		charm.team = 0
		charm.turns = 0
	end
end

event.Roulette_gamblerBeginTurn.add("uncharmIfNoOpponents", {
	filter = "Roulette_gamblerCharmable",
	order = "status",
}, function(ev) ---@param ev Event.Roulette_gamblerBeginTurn
	local judgeEntity = ECS.getEntityByID(ev.component.judge)
	if judgeEntity and judgeEntity.Roulette_judge and #RouletteGambler.getOpponents(ev.entity) == 0 then
		RouletteGambler.uncharm(ev.entity)
	end
end)

--- Unused
--- @param gamblerEntity Entity
--- @return boolean
function RouletteGambler.isFeared(gamblerEntity)
	return gamblerEntity.Roulette_gamblerStatusShield and gamblerEntity.Roulette_gamblerStatusShield.turns > 0 or false
end

--- Unused
--- @param gamblerEntity Entity
function RouletteGambler.fear(gamblerEntity)
	local status = gamblerEntity.Roulette_gamblerStatusFear
	if status then
		status.turns = Utilities.clamp(1, status.turns, status.maxTurns)
	end
end

for _, entry in ipairs {
	{ "charmable", "Roulette_gamblerCharmable", true, function(ev)
		RouletteGambler.uncharm(ev.entity)
	end },
	{ "statusFear",    "Roulette_gamblerStatusFear", },
	{ "statusFreeze",  "Roulette_gamblerStatusFreeze", },
	{ "statusShield",  "Roulette_gamblerStatusShield", },
	{ "statusShrink",  "Roulette_gamblerStatusShrink", },
	{ "statusSilence", "Roulette_gamblerStatusSilence", true },
} do
	(entry[3] and event.Roulette_gamblerEndTurn or event.Roulette_gamblerBeginTurn).add(entry[1] .. "Countdown", {
		filter = entry[2],
		order = "status",
	}, function(ev)
		local component = ev.entity[entry[2]]
		component.turns = max(component.turns - 1, 0)
	end)

	local onReset = entry[4] or RouletteUtility.emptyFunction

	event.Roulette_gamblerEndGame.add(entry[1] .. "Reset", {
		filter = entry[2],
		order = "reset",
	}, function(ev)
		ev.entity[entry[2]].turns = 0
		onReset(ev)
	end)

	event.objectDeath.add(entry[1] .. "Reset", {
		filter = entry[2],
		order = "dead",
	}, function(ev)
		ev.entity[entry[2]].turns = 0
		onReset(ev)
	end)
end

--- @param ev Event.Roulette_sequenceJudgeNextRound
event.Roulette_sequenceJudgeNextRound2.add("gamblerCharmableCountdown", "status", function(ev)
	for _, entity in ipairs(RouletteUtility.getEntitiesFromIDs(ev.component.gamblers)) do
		local charmable = entity.Roulette_gamblerCharmable
		if charmable and charmable.turns > 0 then
			charmable.turns = charmable.turns - 1
		end
	end
end)

local updateInitiativeSelectorFire = ObjectSelector.new("Roulette_updateInitiative", {
	"increase",
}).fire

function RouletteGambler.updateInitiative(gamblerEntity)
	if gamblerEntity.Roulette_gambler then
		--- @class Event.objectRoulette_updateInitiative
		--- @field entity Entity
		--- @field component Component.Roulette_gambler
		--- @field initiative integer
		local ev = {
			entity = gamblerEntity,
			component = gamblerEntity.Roulette_gambler,
			initiative = ECS.getEntityPrototype(gamblerEntity.name).Roulette_gambler.initiative,
		}
		updateInitiativeSelectorFire(ev, gamblerEntity)
		ev.component.initiative = ev.initiative
		return ev.initiative, ev
	end
end

event.holderRoulette_updateInitiative.add("increaseInitiative", {
	filter = "Roulette_itemAddGamblerInitiative",
	order = "increase",
}, function(ev)
	ev.initiative = ev.initiative + ev.entity.Roulette_itemAddGamblerInitiative.value
end)

function RouletteGambler.getItems(gamblerEntity)
	local id = gamblerEntity.id
	local items = {}
	for entity in ECS.entitiesWithComponents { "Roulette_item", "Roulette_selectable", "gameObject" } do
		if entity.Roulette_selectable.belonging == id and entity.gameObject.tangible then
			items[#items + 1] = entity
		end
	end
	return items
end

--- Real team: match ends while only one team remains.
--- @param gamblerEntity any
--- @return integer
function RouletteGambler.getRealTeam(gamblerEntity)
	return gamblerEntity.Roulette_gambler and gamblerEntity.Roulette_gambler.team or 0
end

--- Temporary team: similar to real teams, but when an entity is charmed, it temporarily joins to charmer's team.
--- @param gamblerEntity Entity
--- @return integer
function RouletteGambler.getTemporaryTeam(gamblerEntity)
	return (gamblerEntity.Roulette_gamblerCharmable and gamblerEntity.Roulette_gamblerCharmable.turns > 0 and gamblerEntity.Roulette_gamblerCharmable.team)
		or (gamblerEntity.Roulette_gambler and gamblerEntity.Roulette_gambler.team)
		or 0
end

--- @param entity1 Entity
--- @param entity2 Entity
--- @param realTeam? boolean
--- @return boolean
function RouletteGambler.isHostile(entity1, entity2, realTeam)
	local getTeam = realTeam and RouletteGambler.getRealTeam or RouletteGambler.getTemporaryTeam
	local team1 = getTeam(entity1)
	local team2 = getTeam(entity2)
	return team1 <= 0 or team2 <= 0 or team1 ~= team2
end

--- @param gamblerEntity Entity
--- @param realTeam boolean?
--- @return Entity[]
function RouletteGambler.getOpponents(gamblerEntity, realTeam)
	local judgeEntity = RouletteJudge.getFromGamblerEntity(gamblerEntity)
	if not judgeEntity then
		return RouletteUtility.emptyTable
	end

	local getTeam = realTeam and RouletteGambler.getRealTeam or RouletteGambler.getTemporaryTeam

	local gamblers = {}
	local team = getTeam(gamblerEntity)
	if team == 0 then
		for _, id in ipairs(judgeEntity.Roulette_judge.gamblers) do
			local entity = getEntityByID(id)
			if entity and entity.id ~= gamblerEntity.id then
				gamblers[#gamblers + 1] = entity
			end
		end
	else
		for _, id in ipairs(judgeEntity.Roulette_judge.gamblers) do
			local entity = getEntityByID(id)
			if entity and entity.id ~= gamblerEntity.id and getTeam(entity) ~= team then
				gamblers[#gamblers + 1] = entity
			end
		end
	end
	return gamblers
end

--- @param gamblerEntity Entity
--- @return Entity[]
function RouletteGambler.getAllies(gamblerEntity, realTeam)
	local judgeEntity = RouletteJudge.getFromGamblerEntity(gamblerEntity)
	if not judgeEntity then
		return RouletteUtility.emptyTable
	end

	local getTeam = realTeam and RouletteGambler.getRealTeam or RouletteGambler.getTemporaryTeam
	local team = getTeam(gamblerEntity)
	if team == 0 then
		return RouletteUtility.emptyTable
	end

	local gamblers = {}
	for _, id in ipairs(judgeEntity.Roulette_judge.gamblers) do
		local entity = getEntityByID(id)
		if entity and entity.id ~= gamblerEntity.id and getTeam(entity) == team then
			gamblers[#gamblers + 1] = entity
		end
	end
	return gamblers
end

return RouletteGambler
