local RouletteDelayEvents = require "Roulette.DelayEvents"
local RouletteGambler = require "Roulette.Gambler"
local RouletteGamblerSpecialAbilities = {}
local RouletteGun = require "Roulette.Gun"
local RouletteItem = require "Roulette.Item"
local RouletteJudge = require "Roulette.Judge"
local RouletteRogueItem = require "Roulette.RogueItem"
local RouletteRogueJudge = require "Roulette.RogueJudge"
local RouletteUtility = require "Roulette.Utility"
local RouletteVisuals = require "Roulette.render.Visuals"

local Action = require "necro.game.system.Action"
local Character = require "necro.game.character.Character"
local Damage = require "necro.game.system.Damage"
local Delay = require "necro.game.system.Delay"
local ECS = require "system.game.Entities"
local EntityGeneration = require "necro.game.level.EntityGeneration"
local EnumSelector = require "system.events.EnumSelector"
local Flyaway = require "necro.game.system.Flyaway"
local Health = require "necro.game.character.Health"
local Inventory = require "necro.game.item.Inventory"
local Move = require "necro.game.system.Move"
local MoveAnimations = require "necro.render.level.MoveAnimations"
local Object = require "necro.game.object.Object"
local ObjectEvents = require "necro.game.object.ObjectEvents"
local ObjectSelector = require "necro.game.object.ObjectSelector"
local Particle = require "necro.game.system.Particle"
local Provokable = require "necro.game.character.Provokable"
local RNG = require "necro.game.system.RNG"
local Sound = require "necro.audio.Sound"
local Spawn = require "necro.game.character.Spawn"
local Stasis = require "necro.game.character.Stasis"
local TextPool = require "necro.config.i18n.TextPool"
local Tile = require "necro.game.tile.Tile"
local Utilities = require "system.utils.Utilities"
local Voice = require "necro.audio.Voice"

RouletteGamblerSpecialAbilities.GamblerMoveFlag = Move.Flag.mask(Move.Flag.CONTINUOUS, Move.Flag.PLAY_SOUND, Move.Flag.TWEEN)
local GamblerMoveFlag = RouletteGamblerSpecialAbilities.GamblerMoveFlag

MoveToPositionLater = Delay.new(function(entity, parameter)
	Move.absolute(entity, parameter.x, parameter.y, parameter.moveType)
end)

do
	local name = "Roulette.GamblerSpecialAbilities:MoveToPositionLater"

	local function condition(delay)
		if delay.name == name then
			delay.immediate = true
		end
	end

	event.Roulette_gamblerEndTurn.add("processPendingDelayMoveToPositionLaterImmediately", {
		filter = "Roulette_enemy",
		order = "gambler",
		sequence = -100,
	}, function()
		Delay.processPreemptively(condition)
	end)
end

event.objectSpawn.add("enemySaveInitialPosition", {
	filter = { "Roulette_enemy", "position" },
	order = "turnStartPosition",
	sequence = 2,
}, function(ev)
	ev.entity.Roulette_enemy.initialX = ev.entity.position.x
	ev.entity.Roulette_enemy.initialY = ev.entity.position.y
end)

event.Roulette_gamblerEndGame.add("enemyResetStates", {
	filter = "Roulette_enemy",
	order = "move",
}, function(ev)
	MoveToPositionLater(ev.entity, {
		x = ev.entity.Roulette_enemy.initialX,
		y = ev.entity.Roulette_enemy.initialY,
		moveType = GamblerMoveFlag,
	}, ev.entity.Roulette_enemy.moveToInitialPositionDelay)

	if ev.entity.beatDelay then
		ev.entity.beatDelay.counter = ECS.getEntityPrototype(ev.entity.name).beatDelay.counter
	end
end)

event.objectKnockback.add("gamblerBackToPreviousTileLater", {
	filter = { "Roulette_gambler", "Roulette_gamblerBackToPreviousTileLaterOnKnockback", "position" },
	order = "defer",
}, function(ev)
	if not ev.suppressed and RouletteGambler.isGambling(ev.entity.Roulette_gambler) then
		MoveToPositionLater(ev.entity, {
			x = ev.entity.position.x,
			y = ev.entity.position.y,
			moveType = ev.moveType,
		}, ev.entity.Roulette_gamblerBackToPreviousTileLaterOnKnockback.delay)
	end
end)

event.Roulette_gamblerEndGame.add("resetBeatDelayCounter", {
	filter = "beatDelay",
	order = "reset",
}, function(ev)
	ev.entity.beatDelay.counter = ECS.getEntityPrototype(ev.entity.name).beatDelay.counter
end)

event.Roulette_gamblerEndGame.add("deleteGambler", {
	filter = "Roulette_gamblerEndGameDelete",
	order = "delete",
}, function(ev)
	Object.delete(ev.entity)
end)

--#region Gambler Death Drop

RouletteGamblerSpecialAbilities.RNG_Channel_DeathDrop = RNG.Channel.extend "DeathDrop"

event.objectDeath.add("gamblerDeathDrop", {
	filter = { "Roulette_gamblerDeathDrop", "position" },
	order = "itemDrop",
}, function(ev)
	if ev.attacker and ev.attacker.Roulette_gun then
		local deathDrop = ev.entity.Roulette_gamblerDeathDrop
		local success = RNG.roll(deathDrop.chance, RouletteGamblerSpecialAbilities.RNG_Channel_DeathDrop)
		if not success then
			local gambler = ECS.getEntityByID(ev.attacker.Roulette_gun.gambler)
			if gambler and gambler.Roulette_gamblerLuck
				and RNG.roll(gambler.Roulette_gamblerLuck.chance, RouletteGamblerSpecialAbilities.RNG_Channel_Luck)
				and RNG.roll(deathDrop.chance, RouletteGamblerSpecialAbilities.RNG_Channel_DeathDrop)
			then
				success = true
			end
		end

		if success then
			local entityType = RNG.choice(deathDrop.entityTypes, RouletteGamblerSpecialAbilities.RNG_Channel_DeathDrop)
			if type(entityType) == "string" and ECS.isValidEntityType(entityType) then
				--- @diagnostic disable-next-line: missing-fields
				Object.spawn(entityType, ev.entity.position.x, ev.entity.position.y, {
					Roulette_selectable = { belonging = ev.attacker.id, suppressed = false },
					Roulette_visibilityHideItemHintLabel = { hide = true },
					Roulette_visibilityHideItemStackQuantityLabel = { hide = true },
				})
			end
		end
	end
end)

--#endregion

--#region Armadillo Shield On Take Damage & Stun

event.objectTakeDamage.add("rogueModeShieldOnTakeDamage", {
	filter = { "Roulette_gambler", "Roulette_gamblerShieldOnTakeDamage", "Roulette_gamblerStatusShield" },
	order = "armor",
}, function(ev) --- @param ev Event.ObjectTakeDamage
	if not ev.suppressed and ev.damage > 0
		and ECS.entityExists(ev.entity.Roulette_gambler.cursor)
		and Damage.Flag.check(ev.type, ev.entity.Roulette_gamblerShieldOnTakeDamage.requiredDamageFlag)
		and not Damage.Flag.check(ev.type, ev.entity.Roulette_gamblerShieldOnTakeDamage.excludedDamageFlag)
	then
		ev.entity.Roulette_gamblerStatusShield.turns = math.max(ev.entity.Roulette_gamblerStatusShield.turns, ev.entity.Roulette_gamblerShieldOnTakeDamage.turns)
	end
end)

event.objectTakeDamage.add("rogueModeStunOnTakeDamage", {
	filter = { "Roulette_gambler", "Roulette_gamblerStunOnTakeDamage", "stun" },
	order = "armor",
}, function(ev) --- @param ev Event.ObjectTakeDamage
	if not ev.suppressed and ev.damage > 0 and RouletteGambler.isGambling(ev.entity.Roulette_gambler) then
		ev.entity.stun.counter = math.min(ev.entity.stun.counter + ev.entity.Roulette_gamblerStunOnTakeDamage.value, ev.entity.Roulette_gamblerStunOnTakeDamage.max)
	end
end)

--#endregion

--#region Banshee Provoke Silence

event.objectProvoke.add("gamblerSilenceAll", {
	filter = { "Roulette_gambler", "Roulette_gamblerSilencer" },
	order = "spell",
}, function(ev)
	local affecters = {}
	for _, gamblerEntity in ipairs(RouletteGambler.getOpponents(ev.entity)) do
		if gamblerEntity.Roulette_gamblerStatusSilence then
			RouletteGambler.silence(gamblerEntity, 999)
			affecters[#affecters + 1] = gamblerEntity.id
		end
	end
	ev.entity.Roulette_gamblerSilencer.affecters = affecters
end)

event.objectDespawn.add("gamblerSilencerCure", {
	filter = "Roulette_gamblerSilencer",
	order = "soulLink",
}, function(ev)
	for _, entityID in ipairs(ev.entity.Roulette_gamblerSilencer.affecters) do
		local entity = ECS.getEntityByID(entityID)
		if entity and entity.Roulette_gamblerStatusSilence then
			entity.Roulette_gamblerStatusSilence.turns = 0
		end
	end
end)

--#endregion

--#region BatMiniboss Gain Innate Heal Item

event.Roulette_gamblerStartGame.add("bonusItem", {
	filter = "Roulette_gamblerStartGameBonusItem",
	order = "items",
	sequence = -100,
}, function(ev) --- @param ev Event.Roulette_gamblerStartGame
	local bonus = ev.entity.Roulette_gamblerStartGameBonusItem
	if not RouletteRogueItem.getEquippedItem(ev.entity, unpack(bonus.components)) then
		Inventory.grantInnate(bonus.itemType, ev.entity)
	end
end)

--#endregion

--#region Beetle Shells

do
	local function gamblerShell(ev)
		if not ev.suppressed
			and ev.attacker and ev.attacker.Roulette_gun
			and not ev.entity.provokable.active
			and RouletteGambler.isGambling(ev.entity.Roulette_gambler)
			and Damage.Flag.check(ev.type, ev.entity.Roulette_gamblerShell.requiredDamageFlag)
			and not Damage.Flag.check(ev.type, ev.entity.Roulette_gamblerShell.excludedDamageFlag)
		then
			Provokable.provoke(ev.entity)

			ev.knockback = math.max(1, ev.knockback or 0)
			ev.damage = math.max(0, ev.damage - 1)

			return ev
		end
	end

	event.objectTakeDamage.add("gamblerShellBurnGun", {
		filter = { "Roulette_gamblerShell", "Roulette_gamblerShellBurnGun", "provokable" },
		order = "parry",
	}, function(ev)
		if gamblerShell(ev) and ev.attacker then
			RouletteGun.burn(ev.attacker, ev.entity.Roulette_gamblerShellBurnGun.multiplier)
		end
	end)

	event.objectTakeDamage.add("gamblerShellFreezeAttacker", {
		filter = { "Roulette_gamblerShell", "Roulette_gamblerShellFreezeAttacker", "provokable" },
		order = "parry",
	}, function(ev)
		if gamblerShell(ev) then
			local attacker = ECS.getEntityByID(ev.attacker.Roulette_gun.gambler)
			if attacker and attacker.id ~= ev.entity.id then
				RouletteGambler.freeze(attacker, ev.entity.Roulette_gamblerShellFreezeAttacker.turns, ev.victim)
			end
		end
	end)
end

--#endregion

--#region Blademaster Parry

RouletteGun.damageEventRegister("parry", {
	filter = "Roulette_gun",
	order = "userParry",
}, {
	filter = "Roulette_gun",
	order = "baseIncrease",
	sequence = 1,
}, function(ev)
	local entity = ECS.getEntityByID(ev.entity.Roulette_gun.gambler)
	if entity and entity.Roulette_gamblerParry and entity.Roulette_gamblerParry.active then
		ev.damage = ev.damage + entity.Roulette_gamblerParry.damageUp
	end
end)

event.Roulette_gamblerEndTurn.add("resetParry", {
	filter = { "Roulette_gamblerParry", "parryCounterAttack" },
	order = "gambler",
}, function(ev)
	ev.entity.Roulette_gamblerParry.active = false
	ev.entity.parryCounterAttack.active = false
end)

event.objectTakeDamage.add("gamblerParry", {
	filter = { "Roulette_gamblerParry", "parryCounterAttack" },
	order = "parry",
}, function(ev)
	if ev.suppressed or ev.damage <= 0 or not (ev.attacker and ev.attacker.Roulette_gun) then
		return
	end

	if ev.entity.Roulette_gamblerParry.active then
		-- idk why but it seems there was something wrong with vanilla handler which might cause error and softlock the game so `pcall` is necessary.
		pcall(ObjectEvents.fire, "parry", ev.entity, ev)
		ev.entity.Roulette_gamblerParry.active = false
		ev.entity.parryCounterAttack.active = false
	else
		ev.entity.Roulette_gamblerParry.active = true
		ev.entity.parryCounterAttack.active = true
		ev.entity.parryCounterAttack.direction = Action.Direction.NONE
		ev.knockback = math.max(1, ev.knockback or 0)

		ev.Roulette_gamblerParry = true

		Flyaway.create {
			text = ev.entity.Roulette_gamblerParry.flyawayCounterAttack,
			entity = ev.entity,
		}
	end
end)

event.objectTakeDamage.add("gamblerParrySetBeatDelay", {
	filter = { "Roulette_gamblerParry", "beatDelay" },
	order = "spellLate",
}, function(ev)
	if ev.Roulette_gamblerParry then
		ev.entity.beatDelay.counter = 0
	end
end)

--#endregion

--#region Dragon

--- @param ev Event.Roulette_sequenceJudgeNextRound
event.Roulette_sequenceJudgeNextRound.add("dragonRageReactivate", "ai", function(ev)
	for _, gamblerEntity in ipairs(RouletteUtility.getEntitiesFromIDs(ev.component.gamblers)) do
		if gamblerEntity.Roulette_dragon then
			gamblerEntity.Roulette_dragon.rage = true
		end
	end
end)

local sequenceDragonRageSend = RouletteDelayEvents.register("Roulette_sequenceDragonRage", {
	"state",
	"spellcast",
}, {
	.3,
	.3,
	.2,
}, {
	eventBuilder = function(entity, parameter)
		local gunEntity = ECS.getEntityByID(parameter.gunID)
		assert(gunEntity)

		--- @class Event.Roulette_sequenceDragonRage
		--- @field entity Entity
		--- @field component Component.Roulette_dragon
		--- @field gunEntity Entity
		--- @field gunComponent Component.Roulette_gun
		--- @field attacker Entity?
		local ev = {
			entity = entity,
			component = entity.Roulette_dragon,
			gunEntity = gunEntity,
			gunComponent = gunEntity.Roulette_gun,
			attacker = ECS.getEntityByID(gunEntity.Roulette_gun.gambler) or entity,
			parameter = parameter,
		}
		return ev
	end,
	flags = { unique = true },
})

--- @param ev Event.Roulette_sequenceDragonRage
event.Roulette_sequenceDragonRage1.add("state1", "state", function(ev)
	ev.component.state = 1
	Sound.playFromEntity("dragonPrefire", ev.entity)
end)

--- @param ev Event.Roulette_sequenceDragonRage
event.Roulette_sequenceDragonRage2.add("state2", "state", function(ev)
	ev.component.state = 2
end)

local dragonRageSpellcastSelectorFire = EnumSelector.new(event.Roulette_dragonRageSpellcast).fire

--- @param ev Event.Roulette_dragonRageSpellcast
event.Roulette_dragonRageSpellcast.add("burnGun", "red", function(ev)
	Sound.playFromEntity("spellFireball", ev.gunEntity)
	RouletteGun.burn(ev.gunEntity, 2)
end)

--- @param ev Event.Roulette_dragonRageSpellcast
event.Roulette_dragonRageSpellcast.add("freezeAttacker", "blue", function(ev)
	RouletteGambler.freeze(ev.attacker, 2, ev.entity)
end)

--- @param ev Event.Roulette_sequenceDragonRage
event.Roulette_sequenceDragonRage2.add("castSpell", "spellcast", function(ev)
	if ev.attacker and ev.attacker.id ~= ev.entity.id then
		Sound.playFromEntity("dragonFire", ev.entity)
		--- @class Event.Roulette_dragonRageSpellcast : Event.Roulette_sequenceDragonRage
		dragonRageSpellcastSelectorFire(ev, ev.component.key)
	end
end)

--- @param ev Event.Roulette_sequenceDragonRage
event.Roulette_sequenceDragonRage3.add("state0", "state", function(ev)
	ev.component.state = 0
end)

--- @param dragonEntity Entity
--- @param gunEntity Entity
function RouletteGamblerSpecialAbilities.dragonRage(dragonEntity, gunEntity)
	if dragonEntity.Roulette_dragon and dragonEntity.Roulette_dragon.rage then
		dragonEntity.Roulette_dragon.rage = false
		sequenceDragonRageSend(dragonEntity, { gunID = gunEntity.id })
	end
end

event.objectTakeDamage.add("gamblerDragonRage", {
	filter = { "Roulette_dragon", "Roulette_gambler" },
	order = "spellLate",
}, function(ev)
	if ev.attacker and ev.attacker.Roulette_gun and not RouletteGambler.isFreezing(ev.entity) then
		RouletteGamblerSpecialAbilities.dragonRage(ev.entity, ev.attacker)
	end
end)

--#endregion

--#region Gambler Convert On Take Damage

event.objectTakeDamage.add("gamblerPreConvertShielding", {
	filter = { "Roulette_gambler", "Roulette_gamblerConvertOnTakeDamage" },
	order = "shield",
}, function(ev) --- @param ev Event.ObjectTakeDamage
	--- @class Event.ObjectTakeDamage
	--- @field Roulette_gamblerConvert string?
	ev = ev

	ev.Roulette_gamblerConvert = not ev.suppressed and RouletteGambler.isGambling(ev.entity.Roulette_gambler)
		and Damage.Flag.check(ev.type, ev.entity.Roulette_gamblerConvertOnTakeDamage.requiredDamageFlag)
		and not Damage.Flag.check(ev.type, ev.entity.Roulette_gamblerConvertOnTakeDamage.excludedDamageFlag)
		and ev.entity.Roulette_gamblerConvertOnTakeDamage.targetType
		or nil

	if ev.Roulette_gamblerConvert and ev.entity.Roulette_gamblerConvertOnTakeDamage.shielding then
		ev.damage = 0
	end
end)

event.objectTakeDamage.add("gamblerConvert", {
	filter = "Roulette_gambler",
	order = "spellLate",
}, function(ev) --- @param ev Event.ObjectTakeDamage
	if ev.Roulette_gamblerConvert and ECS.isValidEntityType(ev.Roulette_gamblerConvert) then
		Object.convert(ev.entity, ev.Roulette_gamblerConvert)
	end
end)

--#endregion

--#region Gambler Innate Armor

event.objectTakeDamage.add("gamblerInnateArmor", {
	filter = { "Roulette_gambler", "Roulette_gamblerInnateArmor" },
	order = "armor",
}, function(ev)                                           --- @param ev Event.ObjectTakeDamage
	if not ev.suppressed and not ev.shielded and ev.damage > 0
		and ECS.entityExists(ev.entity.Roulette_gambler.cursor) -- is gambling
		and Damage.Flag.checkAll(ev.type, ev.entity.Roulette_gamblerInnateArmor.requiredDamageFlag)
		and not Damage.Flag.check(ev.type, ev.entity.Roulette_gamblerInnateArmor.excludedDamageFlag)
	then
		ev.damage = math.max(1, ev.damage - ev.entity.Roulette_gamblerInnateArmor.defense)
	end
end)

--#endregion

--#region Ghost Stasis

--- @param ev Event.Roulette_sequenceJudgeNextRound
event.Roulette_sequenceJudgeNextRound.add("activateGhostStasis", "stasis", function(ev)
	for _, id in ipairs(ev.component.gamblers) do
		local entity = ECS.getEntityByID(id)
		if entity and entity.Roulette_gamblerGhostStasis and entity.stasis
			and not RouletteGambler.isFreezing(entity)
			and not RouletteGambler.isSilenced(entity)
		then
			Stasis.setStasis(entity, true)
		end
	end
end)

event.objectSpawn.add("gamblerGhostSetDefaultStasis", {
	filter = { "Roulette_gamblerGhostStasis", "stasis" },
	order = "stasis",
	sequence = 1,
}, function(ev)
	ev.entity.stasis.active = false
end)

event.objectStasis.add("gamblerStasisUpdateSelectivity", {
	filter = { "Roulette_gamblerGhostStasis", "Roulette_selectable", "stasis" },
	order = "attackability",
}, function(ev)
	ev.entity.Roulette_selectable.suppressed = ev.active
end)

event.Roulette_gamblerBeginTurn.add("deactivateGhostStasis", {
	filter = { "Roulette_gamblerGhostStasis", "stasis" },
	order = "stasis",
}, function(ev)
	if not RouletteGambler.isFreezing(ev.entity) then
		Stasis.setStasis(ev.entity, false)
	end
end)

--#endregion

--#region Ghoul

SpawnGhoulHallucination = Delay.new(function(entity, parameter)
	local judgeEntity = ECS.getEntityByID(parameter.judgeID)
	if judgeEntity and entity.Roulette_gambler and ECS.isValidEntityType(parameter.entityType)
		and type(parameter.position) == "table" and type(parameter.index) == "number"
	then
		local x, y = tonumber(parameter.position[1]) or 0, tonumber(parameter.position[2]) or 0
		--- @diagnostic disable
		local gamblerEntity = Object.spawn(parameter.entityType, x, y, {
			beatDelay = { counter = parameter.index + (entity.beatDelay and entity.beatDelay.counter or 0) },
			spawnable = { caster = entity.id },
			team = { id = entity.team and entity.team.id },
		})
		--- @diagnostic enable
		RouletteRogueJudge.midJoin(judgeEntity, gamblerEntity)
	end
end)

event.Roulette_gamblerStartGame.add("ghoulSpawnHallucinations", {
	filter = "Roulette_gamblerGhoul",
	order = "abilities",
}, function(ev) ---@param ev Event.Roulette_gamblerStartGame
	local position, positions = RouletteRogueJudge.getNearestAvailableGamblingPosition(ev.judgeEntity)
	for i = 1, #positions + (position and 1 or 0) do
		SpawnGhoulHallucination(ev.entity, {
			entityType = "Roulette_GhoulHallucination",
			judgeID = ev.judgeEntity.id,
			position = ev.entity.position and { ev.entity.position.x, ev.entity.position.y },
			index = i,
		}, i * .15)
	end
end)

--#endregion

--#region Goblin Damage Up & Stasis

RouletteGun.damageEventRegister("gamblerInnateDamageUp", {
	filter = "Roulette_gun",
	order = "innateDamage",
}, {
	filter = "Roulette_gun",
	order = "finalMultiplier",
	sequence = -1,
}, function(ev) --- @param ev Event.Roulette_gunCalculateDamage
	local gamblerEntity = ECS.getEntityByID(ev.entity.Roulette_gun.gambler)
	if gamblerEntity and gamblerEntity.Roulette_gamblerInnateDamageUp then
		ev.damage = ev.damage + gamblerEntity.Roulette_gamblerInnateDamageUp.damage
	end
end)

event.Roulette_gamblerBeginTurn.add("gamblerTurnBasedStasis", {
	filter = { "Roulette_gamblerTurnBasedStasis", "stasis" },
	order = "gambler",
}, function(ev)
	Stasis.setStasis(ev.entity, true)
end)

event.Roulette_gamblerEndTurn.add("gamblerTurnBasedStasis", {
	filter = { "Roulette_gamblerTurnBasedStasis", "stasis" },
	order = "gambler",
}, function(ev)
	Stasis.setStasis(ev.entity, false)
end)

--#endregion

--#region GoblinBomber Bonus Single Item

--- @param itemType Entity.Type
--- @param position { [1]: integer, [2]: integer }
--- @param owner Entity
function RouletteGamblerSpecialAbilities.newBonusItem(itemType, position, owner)
	--- @diagnostic disable-next-line: missing-fields
	local itemEntity = Object.spawn(itemType, position[1], position[2], {
		Roulette_visibilityHideItemHintLabel = { hide = true },
		Roulette_visibilityHideItemStackQuantityLabel = { hide = true },
	})

	if owner.position then
		MoveAnimations.play(itemEntity, MoveAnimations.Type.HOP, owner.position.x, owner.position.y)
	end

	if itemEntity.Roulette_selectable then
		itemEntity.Roulette_selectable.belonging = owner.id
	end
end

event.Roulette_sequenceJudgeNextRound2.add("gamblerNewRoundBonusItem", {
	filter = "Roulette_judgeAllocItems",
	order = "item",
	sequence = -1,
}, function(ev) --- @param ev Event.Roulette_sequenceJudgeNextRound
	for _, gamblerEntity in ipairs(RouletteUtility.getEntitiesFromIDs(ev.component.gamblers)) do
		local itemType = gamblerEntity.Roulette_gamblerNewRoundBonusItem and gamblerEntity.Roulette_gamblerNewRoundBonusItem.entityType
		if type(itemType) == "string" and ECS.isValidEntityType(itemType) then
			local positions = RouletteGambler.findAvailablePlacements(gamblerEntity)
			if positions[1] then
				RouletteGamblerSpecialAbilities.newBonusItem(itemType, positions[1], gamblerEntity)
			end
		end
	end
end)

--#endregion

--#region Golem3

function RouletteGamblerSpecialAbilities.applyShrink(victim, turns)
	if victim.Roulette_gamblerStatusShrink and turns > victim.Roulette_gamblerStatusShrink.turns then
		victim.Roulette_gamblerStatusShrink.turns = turns

		Flyaway.create {
			entity = victim,
			text = TextPool.get "mod.Roulette.shrink",
		}
		Voice.tryPlay(victim, "voiceShrink")

		return true
	end
end

event.objectTakeDamage.add("gamblerGolemOoze", {
	filter = { "Roulette_gambler", "Roulette_gamblerGolemOoze" },
	order = "spellLate",
}, function(ev)
	if ev.attacker and ev.attacker.Roulette_gun and RouletteGambler.isGambling(ev.entity.Roulette_gambler) then
		local gambler = ECS.getEntityByID(ev.attacker.Roulette_gun.gambler)
		if gambler and RouletteGambler.isHostile(gambler, ev.entity)
			and RouletteGamblerSpecialAbilities.applyShrink(gambler, ev.entity.Roulette_gamblerGolemOoze.shrinkTurns)
		then
			if gambler.position then
				Tile.setType(gambler.position.x, gambler.position.y, "Ooze")
			end
			Object.convert(ev.entity, "Golem3Gooless")
		end
	end
end)

--#endregion

--#region Lich Necromancy

--- @param entities Entity[]
function RouletteGamblerSpecialAbilities.findFirstActiveNecromancer(entities)
	for _, entity in ipairs(entities) do
		if entity.Roulette_gamblerNecromancyRevivable
			and (not entity.beatDelay or entity.beatDelay.counter <= 0)
			and not RouletteGambler.isFreezing(entity)
			and Character.isAlive(entity)
		then
			return entity
		end
	end
end

--- @param necromancerEntity Entity
--- @param deadEntity Entity
function RouletteGamblerSpecialAbilities.necromancerRevive(necromancerEntity, deadEntity)
	local necromancer = necromancerEntity.Roulette_gamblerNecromancer
	if necromancer then
		Object.convert(deadEntity, necromancer.targetType)

		local prototype = assert(ECS.getEntityPrototype(necromancer.targetType))
		for component, fields in pairs(necromancer.attributes) do
			if deadEntity:hasComponent(component) and type(fields) == "table" then
				local t = deadEntity[component]
				for field, value in pairs(fields) do
					t[field] = value
				end

				local resetFields = necromancer.resetFields[component]
				if type(resetFields) == "table" then
					for _, field in ipairs(resetFields) do
						t[field] = prototype[component][field]
					end
				end
			end
		end

		if deadEntity.Roulette_gambler and necromancerEntity.Roulette_gambler then
			deadEntity.Roulette_gambler.team = necromancerEntity.Roulette_gambler.team
		end

		Flyaway.create {
			entity = necromancerEntity,
			text = necromancer.flyaway,
		}
		Flyaway.create {
			entity = deadEntity,
			text = (tostring(TextPool.get("mod.Roulette.necromancyRevive")) or "%s"):format(RouletteVisuals.getEntityDisplayName(necromancerEntity)),
			duration = 2.5,
			delay = 1,
		}
		Particle.play(deadEntity, "particleTakeDamage")
		Sound.playFromEntity(necromancer.sound, necromancerEntity)

		return true
	end
end

event.objectTakeDamage.add("necromancyRevive", {
	filter = { "Roulette_gambler", "Roulette_gamblerNecromancyRevivable" },
	order = "revive",
}, function(ev)
	if not ev.survived and RouletteGambler.isGambling(ev.entity.Roulette_gambler) then
		local necromancer = RouletteGamblerSpecialAbilities.findFirstActiveNecromancer(RouletteGambler.getAllies(ev.entity))
		if necromancer and RouletteGamblerSpecialAbilities.necromancerRevive(necromancer, ev.entity) then
			ev.survived = true

			if necromancer.beatDelay then
				necromancer.beatDelay.counter = necromancer.beatDelay.counter + 1
			end
		end
	end
end)

--#endregion

--#region Mommy

event.Roulette_gamblerStartGame.add("mommySpawnPrep", {
	filter = { "Roulette_gamblerMommy", "spawnPrep" },
	order = "abilities",
}, function(ev)
	ev.entity.spawnPrep.active = true
end)

event.Roulette_gamblerBeginTurn.add("mommySpawn", {
	filter = { "Roulette_gamblerMommy", "position", "spawnCap", "spawnPrep" },
	order = "spawn",
}, function(ev) ---@param ev Event.Roulette_gamblerBeginTurn
	if ev.entity.spawnCap.counter <= 0 then
		return
	end

	local judgeEntity = RouletteJudge.getFromGamblerEntity(ev.entity)
	if judgeEntity and RouletteRogueJudge.canMidJoin(judgeEntity, "Mummy") then
		if not ev.suppressed and ev.entity.spawnPrep.active and (not ev.entity.beatDelay or ev.entity.beatDelay.counter == ev.entity.beatDelay.interval - 1) then
			ev.entity.spawnPrep.active = false

			local spawn = Object.spawn("Mummy", ev.entity.position.x, ev.entity.position.y + 1)
			Spawn.setSpawnCapParent(spawn, ev.entity)
			Sound.playFromEntity("mommySpawn", ev.entity)

			RouletteRogueJudge.midJoin(judgeEntity, spawn)
		elseif ev.entity.beatDelay and ev.entity.beatDelay.counter == 0 then
			ev.entity.spawnPrep.active = true

			Sound.playFromEntity(ev.entity.spawnPrep.sound, ev.entity)
		end
	end
end)

--#endregion

--#region Monkey Begin Turn Grab / End Turn Grab

function RouletteGamblerSpecialAbilities.monkeyGrabItems(entity, amount, sound)
	if not entity.Roulette_gambler then
		return
	end

	local judge = RouletteJudge.getJudgeFromGamblerEntity(entity)
	if not judge then
		return
	end

	local availableTiles = RouletteGambler.findAvailablePlacements(entity)
	if not availableTiles[1] then
		return
	end

	local entities = Utilities.removeIf(RouletteUtility.getEntitiesFromIDs(judge.gamblers), function(gamblerEntity)
		return not RouletteGambler.isHostile(gamblerEntity, entity)
	end)
	if not entities[1] then
		entities = Utilities.removeIf(RouletteUtility.getEntitiesFromIDs(judge.gamblers), function(gamblerEntity)
			return RouletteGambler.isHostile(gamblerEntity, entity)
		end)
	end
	if not entities[1] then
		return
	end

	local availableTileIndex = 1
	for item in ECS.entitiesWithComponents { "Roulette_item", "Roulette_selectable" } do
		if availableTileIndex > amount then
			break
		end

		for _, gamblerEntity in ipairs(entities) do
			if item.Roulette_selectable.belonging == gamblerEntity.id then
				local position = availableTiles[availableTileIndex]
				Move.absolute(item, position[1], position[2], Move.getMoveType(item))
				item.Roulette_selectable.belonging = entity.id
				availableTileIndex = availableTileIndex + 1

				break
			end
		end
	end

	if availableTileIndex ~= 1 then
		Sound.playFromEntity(sound, entity)
	end
end

event.Roulette_gamblerBeginTurn.add("stealItems", {
	filter = { "Roulette_gamblerBeginTurnStealItems", "position" },
	order = "item",
}, function(ev) --- @param ev Event.Roulette_gamblerBeginTurn
	if not RouletteGambler.isFreezing(ev.entity)
		and not (ev.entity.Roulette_gamblerStatusSilence and ev.entity.Roulette_gamblerStatusSilence.turns > 0)
	then
		local comp = ev.entity.Roulette_gamblerBeginTurnStealItems
		RouletteGamblerSpecialAbilities.monkeyGrabItems(ev.entity, comp.amount, comp.sound)
	end
end)

event.Roulette_gamblerEndTurn.add("stealItems", {
	filter = { "Roulette_gamblerEndTurnStealItems", "position" },
	order = "item",
}, function(ev) --- @param ev Event.Roulette_gamblerEndTurn
	if not (ev.parameter and ev.parameter.gamblerTurnSkipped)
		and not RouletteGambler.isFreezing(ev.entity)
		and not (ev.entity.Roulette_gamblerStatusSilence and ev.entity.Roulette_gamblerStatusSilence.turns > 0)
	then
		local comp = ev.entity.Roulette_gamblerEndTurnStealItems
		RouletteGamblerSpecialAbilities.monkeyGrabItems(ev.entity, comp.amount, comp.sound)
	end
end)

--#endregion

--#region Mushroom Heal On Next Round

--- @param ev Event.Roulette_sequenceJudgeNextRound
event.Roulette_sequenceJudgeNextRound.add("gamblerNewRoundHeal", "heal", function(ev)
	if ev.component.turn > 1 then
		for _, gamblerEntity in ipairs(RouletteUtility.getEntitiesFromIDs(ev.component.gamblers)) do
			if gamblerEntity.Roulette_gamblerNewRoundHeal then
				Health.heal {
					entity = gamblerEntity,
					health = gamblerEntity.Roulette_gamblerNewRoundHeal.health,
				}
			end
		end
	end
end)

--#endregion

--#region Nightmare Shadowing

event.Roulette_gamblerStartGame.add("nightmare", {
	filter = "Roulette_gamblerNightmare",
	order = "abilities",
}, function(ev) ---@param ev Event.Roulette_gamblerStartGame
	if ev.judgeEntity.position then
		local comp = ev.entity.Roulette_gamblerNightmare
		if not ECS.entityExists(comp.shadowSource) then
			comp.shadowSource = Object.spawn(comp.shadowSourceType, ev.judgeEntity.position.x, ev.judgeEntity.position.y).id
		end
	end
end)

event.objectDespawn.add("gamblerNightmareRemoveShadowSource", {
	filter = "Roulette_gamblerNightmare",
	order = "despawnExtras",
}, function(ev)
	local comp = ev.entity.Roulette_gamblerNightmare
	if ECS.entityExists(comp.shadowSource) then
		Object.delete(assert(ECS.getEntityByID(comp.shadowSource)))
	end
	comp.shadowSource = 0
end)

--#endregion

--#region Ogre

local sequenceOgreRevengeSend = RouletteDelayEvents.register("Roulette_sequenceOgreRevenge", {
	"all",
}, {
	.3, -- move front
	.4, -- play animation, prepare sound
	.7, -- inflict damage, clonk sound
	.6, -- move back, reset states
}, {
	eventBuilder = function(entity, parameter)
		local victim = ECS.getEntityByID(parameter.victimID)
		local direction = victim and victim.facingDirection and Action.orthogonalize(victim.facingDirection.direction) or Action.Direction.NONE
		local attackDirection = Action.rotateDirection(direction, Action.Rotation.MIRROR)

		--- @class Event.Roulette_sequenceOgreRevenge
		--- @field entity Entity
		--- @field component Component.Roulette_gamblerOgre
		--- @field initialPosition { x: integer, y: integer }
		--- @field parameter table
		--- @field direction Action.Direction
		--- @field attackDirection Action.Direction
		--- @field victim Entity?
		--- @field initialFacingDirection? Action.Direction
		local ev = {
			entity = entity,
			component = entity.Roulette_gamblerOgre,
			parameter = parameter,
			direction = direction,
			attackDirection = attackDirection,
			victim = victim,
		}
		return ev
	end,
	flags = { unique = true },
})

event.Roulette_sequenceOgreRevenge1.add("moveFront", "all", function(ev)
	if ev.entity.facingDirection then
		ev.initialFacingDirection = ev.entity.facingDirection.direction
		ev.entity.facingDirection.direction = ev.attackDirection
	end

	if ev.victim and ev.direction and ev.victim.position then
		local dx, dy = Action.getMovementOffset(ev.direction)
		Move.absolute(ev.entity, ev.victim.position.x + dx * 2, ev.victim.position.y + dy * 2, GamblerMoveFlag)
	end
end)

event.Roulette_sequenceOgreRevenge2.add("playAnimation", "all", function(ev)
	ev.component.state = true
	Sound.play("ogreUpswing", ev.entity.position.x, ev.entity.position.y)
end)

event.Roulette_sequenceOgreRevenge3.add("doClonk", "all", function(ev)
	Damage.inflict {
		damage = 2,
		victim = ev.victim,
		attacker = ev.entity,
		direction = ev.victim.facingDirection and Action.rotateDirection(ev.victim.facingDirection.direction, Action.Rotation.MIRROR),
		type = Damage.Flag.mask(Damage.Type.PHYSICAL, Damage.Flag.BYPASS_INVINCIBILITY),
	}
	Sound.play("ogreDownswing", ev.entity.position.x, ev.entity.position.y)
end)

event.Roulette_sequenceOgreRevenge4.add("moveBack", "all", function(ev)
	if ev.initialFacingDirection and ev.entity.facingDirection then
		ev.entity.facingDirection.direction = ev.initialFacingDirection
	end

	ev.component.state = false
	Move.absolute(ev.entity, ev.parameter.initialPosition.x, ev.parameter.initialPosition.y, GamblerMoveFlag)
end)

--- @param ogre Entity
--- @param victim Entity
function RouletteGamblerSpecialAbilities.ogreRevenge(ogre, victim)
	if ogre.Roulette_gamblerOgre then
		sequenceOgreRevengeSend(ogre, {
			victimID = victim.id,
			initialPosition = { x = ogre.position.x, y = ogre.position.y },
		})

		if ogre.beatDelay then
			ogre.beatDelay.counter = ogre.beatDelay.interval - 1
		end
	end
end

event.objectTakeDamage.add("gamblerOgreRevenge", {
	filter = "Roulette_gamblerOgre",
	order = "startCharge",
}, function(ev)
	if ev.attacker and ev.attacker.Roulette_gun and ev.damage > 0
		and (ev.entity.health and ev.entity.health.health ~= ev.entity.health.maxHealth)
		and (ev.entity.beatDelay and ev.entity.beatDelay.counter <= 0)
		and not RouletteGambler.isFreezing(ev.entity)
	then
		local attacker = ECS.getEntityByID(ev.attacker.Roulette_gun.gambler)
		if attacker then
			RouletteGamblerSpecialAbilities.ogreRevenge(ev.entity, attacker)
		end
	end
end)

--#endregion

--#region Rogue Player Disengage

local function resetGamblerDisengage(gamblerDisengage)
	gamblerDisengage.blank = false
	gamblerDisengage.live = false
	gamblerDisengage.success = false
end

event.Roulette_gamblerBeginTurn.add("resetDisengage", {
	filter = "Roulette_gamblerDisengage",
	order = "gambler",
}, function(ev)
	resetGamblerDisengage(ev.entity.Roulette_gamblerDisengage)
end)

--- @param entity Entity
local function gamblerDisengage(entity)
	if entity.Roulette_gamblerDisengage.success then
		entity.Roulette_gamblerDisengage.success = false
		RouletteGambler.endGame(entity)
		Move.absolute(entity, 0, 0, Move.Type.TELEPORT)
		Health.heal {
			entity = entity,
			health = 999,
		}
	end

	resetGamblerDisengage(entity.Roulette_gamblerDisengage)
end

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot5.add("applyGamblerDisengage", "disengage", function(ev)
	if ev.user and ev.user.Roulette_gamblerDisengage then
		gamblerDisengage(ev.user)
	end
end)

event.Roulette_gamblerEndTurn.add("applyDisengage", {
	filter = "Roulette_gamblerDisengage",
	order = "gambler",
}, function(ev)
	gamblerDisengage(ev.entity)
end)

--#endregion

--#region Rogue Player Luck

RouletteGamblerSpecialAbilities.RNG_Channel_Luck = RNG.Channel.extend "Roulette_Luck"

local gamblerUpdateLuckSelectorFire = ObjectSelector.new("Roulette_gamblerUpdateLuck", {
	"default",
	"innate",
	"item",
}).fire

--- @param entity Entity
--- @return number?
--- @return Event.Roulette_gamblerUpdateLuck
function RouletteGamblerSpecialAbilities.updateLuck(entity)
	if entity.Roulette_gamblerLuck then
		--- @class Event.Roulette_gamblerUpdateLuck
		local ev = {
			entity = entity,
			component = entity.Roulette_gamblerLuck,
			chance = ECS.getEntityPrototype(entity.name).Roulette_gamblerLuck.chance,
		}
		gamblerUpdateLuckSelectorFire(ev, entity)

		ev.component.chance = ev.chance
		return ev.chance, ev
	end

	return nil, RouletteUtility.emptyTable
end

do
	local arg = { filter = "Roulette_itemAddGamblerLuck", order = "collision" }
	local function handler(ev)
		RouletteGamblerSpecialAbilities.updateLuck(ev.holder)
	end
	event.inventoryEquipItem.add("updateLuck", arg, handler)
	event.inventoryUnequipItem.add("updateLuck", arg, handler)
end

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot.add("luck", "luck", function(ev)
	local bullets = ev.component.bullets
	if not RouletteGun.isUncertainBullet(bullets[#bullets])
		or not (ev.user and ev.target)
		or not (ev.user.Roulette_gamblerLuck or ev.target.Roulette_gamblerLuck)
	then
		return
	end

	local function luckySwap(check)
		for i = #bullets - 1, 1, -1 do
			if check(bullets[i]) and RouletteGun.isUncertainBullet(bullets[i]) then
				bullets[#bullets], bullets[i] = bullets[i], bullets[#bullets]

				return true
			end
		end
	end

	local function applyUserLuck()
		if not ev.user.Roulette_gamblerLuck
			or not RNG.roll(ev.user.Roulette_gamblerLuck.chance, RouletteGamblerSpecialAbilities.RNG_Channel_Luck)
		then
			return true
		end

		local check
		if ev.user.id == ev.target.id and RouletteGun.isLiveBullet(bullets[#bullets]) then
			check = RouletteGun.isBlankBullet
		elseif ev.user.id ~= ev.target.id and RouletteGun.isBlankBullet(bullets[#bullets]) then
			check = RouletteGun.isLiveBullet
		end

		return not (check and luckySwap(check))
	end

	local function applyTargetLuck()
		return not (ev.target.Roulette_gamblerLuck
			and RNG.roll(ev.target.Roulette_gamblerLuck.chance, RouletteGamblerSpecialAbilities.RNG_Channel_Luck)
			and RouletteGun.isLiveBullet(bullets[#bullets]) and luckySwap(RouletteGun.isBlankBullet))
	end

	local gamblers = RouletteJudge.getJudgeFromGamblerEntity(ev.user).gamblers
	local userIndex = Utilities.arrayFind(gamblers, ev.user.id)
	local targetIndex = Utilities.arrayFind(gamblers, ev.target.id)
	if userIndex <= targetIndex then
		if applyUserLuck() then
			applyTargetLuck()
		end
	else
		if applyTargetLuck() then
			applyUserLuck()
		end
	end
end)

event.Roulette_itemUse.add("luckApplyToCursedPotionConditionalDamage", {
	filter = "Roulette_itemUseConditionalDamageLater",
	order = "use",
	sequence = .5,
}, function(ev) --- @param ev Event.Roulette_itemUse
	if ev.item.Roulette_itemUseConditionalDamageLater.active
		and ev.user.Roulette_gamblerLuck
		and ev.user.Roulette_gamblerLuck.chance > 0
		and RNG.roll(ev.user.Roulette_gamblerLuck.chance - .01, RouletteGamblerSpecialAbilities.RNG_Channel_Luck)
	then
		ev.item.Roulette_itemUseConditionalDamageLater.active = false
	end
end)

--#endregion

--#region Sarcophagus Spawn

event.Roulette_gamblerBeginTurn.add("spawn", {
	filter = "Roulette_gamblerSpawner",
	order = "spawn",
}, function(ev) ---@param ev Event.Roulette_gamblerBeginTurn
	local spawner = ev.entity.Roulette_gamblerSpawner
	if not ECS.entityExists(spawner.entity) and (not ev.entity.beatDelay or ev.entity.beatDelay.counter <= 0) then
		if not spawner.active then
			spawner.active = true
			return
		end

		local judgeEntity = RouletteJudge.getFromGamblerEntity(ev.entity)
		if judgeEntity and RouletteRogueJudge.canMidJoin(judgeEntity, spawner.entityType) then
			local position = ev.entity.position or RouletteUtility.emptyTable

			local spawn = Object.spawn(spawner.entityType, position.x or 0, position.y or 0, spawner.attributes)
			RouletteRogueJudge.midJoin(judgeEntity, spawn)

			spawner.active = false
			spawner.entity = spawn.id
			Sound.play(spawner.sound, position.x or 0, position.y or 0)

			if spawner.beatDelayReset then
				ev.entity.beatDelay.counter = ev.entity.beatDelay.interval - 1
			end
		end
	end
end)

--#endregion

--#region Skeleton Mage New Round Bonus Items

RouletteGamblerSpecialAbilities.RNG_Channel_NewRoundBonusItem = RNG.Channel.extend "Roulette_NewRoundBonusItem"

event.Roulette_sequenceJudgeNextRound2.add("gamblerNewRoundBonusItems", {
	filter = "Roulette_judgeAllocItems",
	order = "item",
	sequence = -1,
}, function(ev) --- @param ev Event.Roulette_sequenceJudgeNextRound
	if ev.component.round < 2 then
		return
	end

	for _, gamblerEntity in ipairs(RouletteUtility.getEntitiesFromIDs(ev.component.gamblers)) do
		local amount = gamblerEntity.Roulette_gamblerNewRoundBonusItems and gamblerEntity.Roulette_gamblerNewRoundBonusItems.amount or 0

		for _, position in ipairs(RouletteGambler.findAvailablePlacements(gamblerEntity)) do
			local itemType = amount > 0 and EntityGeneration.choice {
				requiredComponents = { "Roulette_item", "!Roulette_itemExcludedFromAllocator" },
				filter = function() return true end,
				chanceFunction = function(e)
					--- @diagnostic disable-next-line: redundant-return-value
					return RouletteItem.itemGenerationWeight(e, ev.entity, gamblerEntity)
				end,
				markSeen = false,
				seed = RNG.int(2 ^ 53 - 1, RouletteGamblerSpecialAbilities.RNG_Channel_NewRoundBonusItem),
			}

			if itemType then
				amount = amount - 1
				RouletteGamblerSpecialAbilities.newBonusItem(itemType, position, gamblerEntity)
			end
		end
	end
end)

--#endregion

--#region Slime4 Death Freeze Killer

event.objectDeath.add("gamblerFreezeAttackerOnDeath", {
	filter = "Roulette_gamblerFreezeAttackerOnDeath",
	order = "spellcast",
}, function(ev)
	local attacker = ev.killer and ev.killer.Roulette_gun and ECS.getEntityByID(ev.killer.Roulette_gun.gambler)
	if attacker then
		RouletteGambler.freeze(attacker, ev.entity.Roulette_gamblerFreezeAttackerOnDeath.turns, ev.entity)
	end
end)

--#endregion

--#region Slime5 Death Burn Gun

event.objectDeath.add("gamblerBurnGunOnDeath", {
	filter = "Roulette_gamblerBurnGunOnDeath",
	order = "spellcast",
}, function(ev)
	local statusBurnt = ev.killer and ev.killer.Roulette_gunStatusBurnt
	if statusBurnt then
		RouletteGun.burn(ev.killer, ev.entity.Roulette_gamblerBurnGunOnDeath.multiplier)
	end
end)

--#endregion

--#region Warlock Healing

event.Roulette_sequenceGunShot2.add("gamblerHealOnShootHostile", {
	order = "shot",
	sequence = -1,
}, function(ev) --- @param ev Event.Roulette_sequenceGunShot
	if ev.target and ev.user and ev.user.Roulette_gamblerHealer and RouletteGun.isLiveBullet(ev.parameter.bullet) then
		Health.heal {
			entity = ev.target,
			health = RouletteGun.calculateDamage(ev.entity),
		}
		if ev.target.Roulette_gamblerStatusShield then
			ev.target.Roulette_gamblerStatusShield.turns = ev.target.Roulette_gamblerStatusShield.turns + 1
		end
		Sound.playFromEntity("spellHeal", ev.target)
	end
end)

--#endregion

return RouletteGamblerSpecialAbilities
