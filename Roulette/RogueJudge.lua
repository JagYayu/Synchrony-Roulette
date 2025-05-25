local RouletteGambler = require "Roulette.Gambler"
local RouletteGamblerSpecialAbilities = require "Roulette.GamblerSpecialAbilities"
local RouletteJudge = require "Roulette.Judge"
local RouletteRogue = require "Roulette.Rogue"
local RouletteRogueJudge = {}
local RouletteUIPanel = require "Roulette.render.UIPanel"
local RouletteUtility = require "Roulette.Utility"

local Action = require "necro.game.system.Action"
local AffectorItem = require "necro.game.item.AffectorItem"
local CurrentLevel = require "necro.game.level.CurrentLevel"
local Delay = require "necro.game.system.Delay"
local Dig = require "necro.game.tile.Dig"
local ECS = require "system.game.Entities"
local EntityGeneration = require "necro.game.level.EntityGeneration"
local EntitySelector = require "system.events.EntitySelector"
local Flyaway = require "necro.game.system.Flyaway"
local LevelSequence = require "necro.game.level.LevelSequence"
local LineOfSight = require "necro.game.system.LineOfSight"
local Move = require "necro.game.system.Move"
local Object = require "necro.game.object.Object"
local ObjectMap = require "necro.game.object.Map"
local Player = require "necro.game.character.Player"
local RNG = require "necro.game.system.RNG"
local Settings = require "necro.config.Settings"
local Snapshot = require "necro.game.system.Snapshot"
local Sound = require "necro.audio.Sound"
local TextPool = require "necro.config.i18n.TextPool"
local Utilities = require "system.utils.Utilities"

local GamblerMoveFlag = RouletteGamblerSpecialAbilities.GamblerMoveFlag

SettingActiveRogueMatchesLimit = Settings.shared.number {
	id = "rogue.matchesLimit",
	name = "Maximum matches number limit",
	default = 3,
	minimum = 1,
	sliderMaximum = 4,
}

--- @return integer?
function RouletteRogueJudge.isMaximumActiveMatchNumberExceed()
	local count = 0
	for entity in ECS.entitiesWithComponents { "Roulette_judge" } do
		if RouletteJudge.hasStarted(entity.Roulette_judge) then
			count = count + 1
		end
	end

	if count >= SettingActiveRogueMatchesLimit then
		return SettingActiveRogueMatchesLimit
	end
end

function RouletteRogueJudge.tryStartRogueGame(judgeEntity)
	if judgeEntity.Roulette_judgeRogue
		and judgeEntity.Roulette_judge
		and not RouletteJudge.hasStarted(judgeEntity.Roulette_judge)
		and RouletteUtility.entitiesHasMultipleTeam(judgeEntity.Roulette_judge.gamblers)
		and not RouletteRogueJudge.isMaximumActiveMatchNumberExceed()
	then
		RouletteJudge.startGame(judgeEntity)
	end
end

event.turn.add("gamblerStartRogueGame", "lobbyLevel", function(ev)
	if ev.globalActivation and RouletteRogue.isModeActive() then
		for entity in ECS.entitiesWithComponents { "Roulette_judge", "Roulette_judgeRogue" } do
			RouletteRogueJudge.tryStartRogueGame(entity)
		end
	end
end)

--- @type table<Entity.ID, "join" | "joinFail" | "midJoin" | "midJoinFail">
local turnGamblerJoinStates = {}

function RouletteRogueJudge.getTurnGamblerJoinStates()
	return turnGamblerJoinStates
end

event.turn.add("resetTurnGamblerJoinStates", "turnID", function()
	turnGamblerJoinStates = {}
end)

event.objectMove.add("gamblerJoinToRogueJudgeRoom", {
	filter = { "Roulette_gambler", "position" },
	order = "hasMoved",
	sequence = 1,
}, function(ev)
	if ECS.entityExists(ev.entity.Roulette_gambler.judge) or RouletteGambler.isGambling(ev.entity.Roulette_gambler) then
		return
	end

	ev.Roulette_gamblerJoin = false
	for judgeEntity in ECS.entitiesWithComponents { "Roulette_judge", "Roulette_judgeRogue", "position", "visibility" } do
		if judgeEntity.visibility.revealed and not RouletteJudge.hasStarted(judgeEntity.Roulette_judge) then
			local joinOrNot = false
			for _, id in ipairs(judgeEntity.Roulette_judge.gamblers) do
				local entity = ECS.getEntityByID(id)
				if entity and entity.position and entity.Roulette_enemy
					and Utilities.squareDistance(ev.entity.position.x - entity.position.x, ev.entity.position.y - entity.position.y) <= entity.Roulette_enemy.skirmishSquareDistance
					and LineOfSight.canSee(entity, ev.entity)
				then
					joinOrNot = true
					break
				end
			end

			if joinOrNot then
				if not Utilities.arrayFind(judgeEntity.Roulette_judge.gamblers, ev.entity.id) then
					if RouletteRogueJudge.isMaximumActiveMatchNumberExceed() then
						if not turnGamblerJoinStates[ev.entity.id] then
							turnGamblerJoinStates[ev.entity.id] = "joinFail"
							Move.absolute(ev.entity, ev.prevX, ev.prevY, ev.moveType)
							Flyaway.create {
								text = TextPool.get "mod.Roulette.matchNumberExceed",
								entity = ev.entity,
							}
							Sound.playIfFocused("error", ev.entity)
						end
					else
						table.insert(judgeEntity.Roulette_judge.gamblers, ev.entity.id)
						ev.entity.Roulette_gambler.judge = judgeEntity

						ev.Roulette_gamblerJoin = true
						turnGamblerJoinStates[ev.entity.id] = "join"

						break
					end
				end
			else
				Utilities.arrayRemove(judgeEntity.Roulette_judge.gamblers, ev.entity.id)
				if ev.entity.Roulette_gambler.judge == judgeEntity.id then
					ev.entity.Roulette_gambler.judge = 0
				end
			end
		end
	end
end)

do
	local availablePositionOffsets = {
		{ 3,  0 },
		{ 3,  -3 },
		{ 0,  -3 },
		{ -3, -3 },
		{ -3, 0 },
		{ -3, 3 },
		{ 0,  3 },
		{ 3,  3 },
	}

	--- @param judgeEntity Entity
	--- @param gamblerEntity Entity?
	--- @param positions { [1]: integer, [2]: integer }[]?
	--- @return { [1]: integer, [2]: integer }?
	--- @return { [1]: integer, [2]: integer }[]
	function RouletteRogueJudge.getNearestAvailableGamblingPosition(judgeEntity, gamblerEntity, positions)
		if not positions then
			positions = Utilities.newTable(#availablePositionOffsets, 0)
			for _, offset in ipairs(availablePositionOffsets) do
				local x = judgeEntity.position.x + offset[1]
				local y = judgeEntity.position.y + offset[2]
				if not ObjectMap.firstWithComponent(x, y, "Roulette_gambler") then
					positions[#positions + 1] = { x, y }
				end
			end
		end

		if not gamblerEntity then
			gamblerEntity = judgeEntity
		end

		local nearestDistance = math.huge
		local nearestIndex

		for i, position in ipairs(positions) do
			local x, y = position[1], position[2]
			local sd = gamblerEntity.position and Utilities.squareDistance(gamblerEntity.position.x - x, gamblerEntity.position.y - y) or 0
			sd = sd + (gamblerEntity.previousPosition and Utilities.squareDistance(gamblerEntity.previousPosition.x - x, gamblerEntity.previousPosition.y - y) or sd)

			if sd < nearestDistance then
				nearestIndex = i
				nearestDistance = sd
			end
		end

		if nearestIndex then
			return table.remove(positions, nearestIndex), positions
		end
		return nil, RouletteUtility.emptyTable
	end
end

event.Roulette_judgeStartGame.add("moveGamblers", {
	filter = { "Roulette_judgeRogue", "position" },
	order = "move",
}, function(ev) --- @param ev Event.Roulette_judgeStartGame
	for _, direction in ipairs(Action.Direction.valueList) do
		local dx, dy = Action.getMovementOffset(direction)
		Dig.breakTile(ev.entity.position.x + dx, ev.entity.position.y + dy, Dig.Strength.UNBREAKABLE, nil, direction)
	end

	local availablePositions = {
		{ ev.entity.position.x + 3, ev.entity.position.y },
		{ ev.entity.position.x + 3, ev.entity.position.y - 3 },
		{ ev.entity.position.x,     ev.entity.position.y - 3 },
		{ ev.entity.position.x - 3, ev.entity.position.y - 3 },
		{ ev.entity.position.x - 3, ev.entity.position.y },
		{ ev.entity.position.x - 3, ev.entity.position.y + 3 },
		{ ev.entity.position.x,     ev.entity.position.y + 3 },
		{ ev.entity.position.x + 3, ev.entity.position.y + 3 },
	}

	for _, id in ipairs(ev.component.gamblers) do
		local entity = ECS.getEntityByID(id)
		local position = entity and RouletteRogueJudge.getNearestAvailableGamblingPosition(ev.entity, entity, availablePositions)
		if position then
			--- @cast entity Entity
			Move.absolute(entity, position[1], position[2], Move.Flag.mask(GamblerMoveFlag, Move.Flag.TWEEN_MULTI_HOP))
		end
	end
end)

event.Roulette_judgeStartGame.add("sound", {
	filter = "Roulette_judgeRogue",
	order = "sound",
}, function(ev)
	Sound.playFromEntity(ev.entity.Roulette_judgeRogue.soundStart, ev.entity)
end)

do
	local function compareGambler(l, r)
		if l.Roulette_gambler.initiative ~= r.Roulette_gambler.initiative then
			return l.Roulette_gambler.initiative > r.Roulette_gambler.initiative
		elseif RouletteUtility.priority(l) ~= RouletteUtility.priority(r) then
			return RouletteUtility.priority(l) > RouletteUtility.priority(r)
		else
			return l.id < r.id
		end
	end

	function RouletteRogueJudge.sortGamblers(entities)
		table.sort(entities, compareGambler)

		return entities
	end
end

event.Roulette_judgeStartGame.add("rogueSortOrder", {
	filter = { "Roulette_judgeRogueGamblerOrders", "random" },
	order = "gambler",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_judgeStartGame
	for _, entity in ipairs(ev.gamblerEntities) do
		RouletteGambler.updateInitiative(entity)
	end

	for i, entity in ipairs(RouletteRogueJudge.sortGamblers(ev.gamblerEntities)) do
		ev.component.gamblers[i] = entity.id
	end
end)

--- @param judgeEntity Entity
--- @param gambler Entity | Entity.Type
--- @return boolean
function RouletteRogueJudge.canMidJoin(judgeEntity, gambler)
	if not judgeEntity.Roulette_judgeRogue
		or not judgeEntity.Roulette_judge
		or not RouletteJudge.hasStarted(judgeEntity.Roulette_judge)
		or #judgeEntity.Roulette_judge.gamblers >= 8
	then
		return false
	end

	if type(gambler) == "table" then
		return gambler.Roulette_gambler
			and gambler.Roulette_gambler.judge == 0
			and not Utilities.arrayFind(judgeEntity.Roulette_judge.gamblers, gambler.id)
	elseif type(gambler) == "string" then
		local prototype = ECS.getEntityPrototype(gambler)
		return not not (prototype and prototype.Roulette_gambler)
	end

	return false
end

local gamblerMidJoinedSelectorFire = EntitySelector.new(event.Roulette_gamblerMidJoined, {
	"sound"
}).fire

event.Roulette_gamblerMidJoined.add("playMidJoinSound", {
	filter = "Roulette_gamblerMidJoinSound",
	order = "sound",
}, function(ev)
	Sound.playFromEntity(ev.gamblerEntity.Roulette_gamblerMidJoinSound.sound, ev.gamblerEntity)
end)

--- @param judgeEntity Entity
--- @param gamblerEntity Entity
function RouletteRogueJudge.midJoin(judgeEntity, gamblerEntity)
	if not RouletteRogueJudge.canMidJoin(judgeEntity, gamblerEntity) then
		return
	end

	gamblerEntity.Roulette_gambler.judge = judgeEntity.id
	RouletteGambler.updateInitiative(gamblerEntity)

	do
		local entities = RouletteUtility.getEntitiesFromIDs(judgeEntity.Roulette_judge.gamblers)
		entities[#entities + 1] = gamblerEntity
		for i, entity in ipairs(RouletteRogueJudge.sortGamblers(entities)) do
			judgeEntity.Roulette_judge.gamblers[i] = entity.id
		end
	end

	local position = RouletteRogueJudge.getNearestAvailableGamblingPosition(judgeEntity, gamblerEntity)
	if position then
		Move.absolute(gamblerEntity, position[1], position[2], GamblerMoveFlag)
	end
	RouletteGambler.startGame(gamblerEntity, judgeEntity)
	RouletteUIPanel.markEntityMidJoined(gamblerEntity)

	local gamblerIndex = Utilities.arrayFind(judgeEntity.Roulette_judge.gamblers, gamblerEntity.id)
	if gamblerIndex <= judgeEntity.Roulette_judge.gamblerIndex then
		judgeEntity.Roulette_judge.gamblerIndex = judgeEntity.Roulette_judge.gamblerIndex + 1
	end

	local ev = {
		gamblerEntity = gamblerEntity,
		judgeEntity = judgeEntity,
	}
	gamblerMidJoinedSelectorFire(ev, gamblerEntity.name)
	return ev
end

event.objectMove.add("gamblerMidJoin", {
	filter = { "Roulette_gambler", "position" },
	order = "hasMoved",
	sequence = 2,
}, function(ev)
	if ev.Roulette_gamblerJoin or turnGamblerJoinStates[ev.entity.id]
		or ECS.entityExists(ev.entity.Roulette_gambler.judge) or RouletteGambler.isGambling(ev.entity.Roulette_gambler)
	then
		return
	end

	local x1 = ev.entity.position.x
	local y1 = ev.entity.position.y
	for judgeEntity in ECS.entitiesWithComponents { "Roulette_judge", "Roulette_judgeRogue", "position", "visibility" } do
		if judgeEntity.visibility.revealed and RouletteJudge.hasStarted(judgeEntity.Roulette_judge) then
			local x2 = judgeEntity.position.x
			local y2 = judgeEntity.position.y

			if x1 >= x2 - 4 and x1 <= x2 + 4 and y1 >= y2 - 4 and y1 <= y2 + 4 then
				ev.Roulette_gamblerMidJoin = RouletteRogueJudge.midJoin(judgeEntity, ev.entity) or false
				if ev.Roulette_gamblerMidJoin then
					turnGamblerJoinStates[ev.entity.id] = "midJoin"
					break
				end
			end
		end
	end
end)

event.objectMove.add("playerGamblerMidJoinFailMove", {
	filter = { "Roulette_gambler", "controllable" },
	order = "hasMoved",
	sequence = 3,
}, function(ev)
	if ev.Roulette_gamblerMidJoin == false and not turnGamblerJoinStates[ev.entity.id] then
		turnGamblerJoinStates[ev.entity.id] = "midJoinFail"
		Move.absolute(ev.entity, ev.prevX, ev.prevY, ev.moveType)
		Flyaway.create {
			text = TextPool.get "mod.Roulette.matchFull",
			entity = ev.entity,
		}
		Sound.playIfFocused("error", ev.entity)
	end
end)

local Key_SpawnMidJoinGamblerLater = "Roulette.RogueJudge:SpawnMidJoinGamblerLater"
SpawnMidJoinGamblerLater = Delay.new(function(entity, parameter)
	if ECS.isValidEntityType(parameter.entityType) and entity.Roulette_judge and RouletteJudge.hasStarted(entity.Roulette_judge) then
		--- @diagnostic disable-next-line: missing-fields
		local gamblerEntity = Object.spawn(parameter.entityType, tonumber(parameter.x) or 0, tonumber(parameter.y) or 0, {
			--- @diagnostic disable-next-line: missing-fields
			Roulette_gambler = { turnDelay = entity.Roulette_gamblerMidJoinTurnDelay and entity.Roulette_gamblerMidJoinTurnDelay.value or 1 },
		})

		RouletteRogueJudge.midJoin(entity, gamblerEntity)
	end
end)

RouletteRogueJudge.ApparitionChannel = RNG.Channel.extend "Roulette_Apparition"
ApparitionCount = Snapshot.levelVariable(0)
ApparitionSeenPool = Snapshot.levelVariable {}

function RouletteRogueJudge.getApparitionCount()
	return ApparitionCount
end

local getApparitionLevelMaximumSelectorFire = EntitySelector.new(event.Roulette_getApparitionLevelMaximum, {
	"default",
	"overrides",
}).fire

event.Roulette_getApparitionLevelMaximum.add("default", "default", function(ev)
	ev.max = ev.max + (CurrentLevel.getDepth() == 1 and 2 or 3) + math.min(Player.getCount(), 8)
end)

function RouletteRogueJudge.getApparitionLevelMaximum(entity)
	--- @class Event.Roulette_getApparitionLevelMaximum
	--- @field entity Entity
	--- @field max integer
	local ev = {
		entity = entity,
		max = 0,
	}
	getApparitionLevelMaximumSelectorFire(ev, entity.name)
	return ev.max, ev
end

local function processSpawnMidJoinGamblerLaterDelay(pendingDelay)
	if pendingDelay.name == Key_SpawnMidJoinGamblerLater then
		pendingDelay.immediate = true
	end
end

event.Roulette_sequenceJudgeNextRound.add("apparitionMidJoinImmediately", {
	filter = "Roulette_haunted",
	order = "apparition",
}, function()
	Delay.processPreemptively(processSpawnMidJoinGamblerLaterDelay)
end)

local function wereApparitionsMoreThanOrEqualToHalf(gamblerIDs)
	local a = 0

	for _, id in ipairs(gamblerIDs) do
		local entity = ECS.getEntityByID(id)
		if entity and entity.Roulette_apparition then
			a = a + 1
		end
	end

	return a >= #gamblerIDs / 2
end

local apparitionSpawnFilterSelectorFire = EntitySelector.new(event.Roulette_apparitionSpawnFilter, {
	"ghoul",
}).fire

function RouletteRogueJudge.apparitionSpawnFilter(judgeEntity, prototype)
	if judgeEntity.Roulette_judge then
		--- @class Event.Roulette_apparitionSpawnFilter
		--- @field filtered boolean
		local ev = {
			filtered = false,
			judgeEntity = judgeEntity,
			judgeComponent = judgeEntity.Roulette_judge,
			prototype = prototype,
		}
		apparitionSpawnFilterSelectorFire(ev, prototype.name)
		return not ev.filtered
	end
end

event.Roulette_sequenceJudgeNextRound2.add("apparitionMidJoinLater", {
	filter = "Roulette_haunted",
	order = "apparition",
}, function(ev) --- @param ev Event.Roulette_sequenceJudgeNextRound
	if ev.component.round < 2 or AffectorItem.isItemActive "itemDeleteApparitions" then
		return
	end

	local max = RouletteRogueJudge.getApparitionLevelMaximum(ev.entity)
	if ApparitionCount > max
		or not RNG.roll(ev.entity.Roulette_haunted.chance, RouletteRogueJudge.ApparitionChannel)
		or wereApparitionsMoreThanOrEqualToHalf(ev.component.gamblers)
	then
		return
	end

	ApparitionCount = ApparitionCount + 1

	local apparitionType
	do
		local zoneComponent = LevelSequence.Zone.data[CurrentLevel.getZone()]
		zoneComponent = zoneComponent and tostring(zoneComponent.Roulette_rogueEnemyComponent) or "Roulette_enemyPool"

		apparitionType = EntityGeneration.choice {
			requiredComponents = { "Roulette_apparition", zoneComponent },
			chanceFunction = function()
				return 1
			end,
			filter = function(e)
				return RouletteRogueJudge.apparitionSpawnFilter(ev.entity, e)
			end,
			seenCounts = ApparitionSeenPool,
			seed = RNG.getDungeonSeed(),
		}
	end

	local position = apparitionType and RouletteRogueJudge.getNearestAvailableGamblingPosition(ev.entity)
	if position then
		SpawnMidJoinGamblerLater(ev.entity, {
			entityType = apparitionType,
			x = position[1],
			y = position[2],
		}, RNG.range(ev.entity.Roulette_haunted.delayMin, ev.entity.Roulette_haunted.delayMax, RouletteRogueJudge.ApparitionChannel))
	end
end)

event.Roulette_apparitionSpawnFilter.add("ghoul", {
	filter = "Roulette_gamblerGhoul",
	order = "ghoul",
}, function(ev) ---@param ev Event.Roulette_apparitionSpawnFilter
	if not ev.filtered then
		local _, positions = RouletteRogueJudge.getNearestAvailableGamblingPosition(ev.judgeEntity)
		ev.filtered = #positions <= 1
	end
end)

event.Roulette_judgeEndGame.add("rogueKeepEnemyGamblers", {
	filter = "Roulette_judgeRogue",
	order = "reset",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_judgeEndGame
	for _, entity in ipairs(ev.gamblerEntities) do
		if entity.Roulette_enemy then
			ev.component.gamblers[#ev.component.gamblers + 1] = entity.id

			if entity.Roulette_gambler then
				entity.Roulette_gambler.judge = ev.entity.id
			end
		end
	end
end)

return RouletteRogueJudge
