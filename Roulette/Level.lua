local RouletteGame = require "Roulette.Game"
local RouletteJudge = require "Roulette.Judge"
local RouletteLevel = {}
local RouletteRogue = require "Roulette.Rogue"
local RouletteRogueJudge = require "Roulette.RogueJudge"

local Collision = require "necro.game.tile.Collision"
local CurrentLevel = require "necro.game.level.CurrentLevel"
local ECS = require "system.game.Entities"
local EntityGeneration = require "necro.game.level.EntityGeneration"
local EnumSelector = require "system.events.EnumSelector"
local GameSession = require "necro.client.GameSession"
local LevelGenerator = require "necro.game.level.LevelGenerator"
local LevelSequence = require "necro.game.level.LevelSequence"
local Marker = require "necro.game.tile.Marker"
local ModEvent = require "necro.event.ModEvent"
local Netplay = require "necro.network.Netplay"
local Object = require "necro.game.object.Object"
local ObjectMap = require "necro.game.object.Map"
local TextPool = require "necro.config.i18n.TextPool"
local Tile = require "necro.game.tile.Tile"
local Player = require "necro.game.character.Player"
local ProceduralLevel = require "necro.game.data.level.ProceduralLevel"
local RNG = require "necro.game.system.RNG"
local Room = require "necro.client.Room"
local RunState = require "necro.game.system.RunState"
local Snapshot = require "necro.game.system.Snapshot"
local Utilities = require "system.utils.Utilities"

local checkCollision = Collision.check

event.lobbyGenerate.add("generateRouletteLobbyTrigger", "modes", function(ev)
	local x, y = -2, -1
	if not ObjectMap.firstWithComponent(x, y, "trapStartRun") then
		Tile.setType(x, y, "LobbyStairs")
		--- @diagnostic disable-next-line: missing-fields
		Object.spawn("TriggerStartRun", x, y, {
			--- @diagnostic disable-next-line: missing-fields
			trapStartRun = {
				mode = RouletteGame.FreeMode,
				fileName = "mods/Roulette/data/lobby.necrolevel",
			},
		})
		--- @diagnostic disable-next-line: missing-fields
		Object.spawn("LabelLobby", x, y, { worldLabel = { text = TextPool.get "mod.Roulette.rouletteLobby" } })
	end
end)

ModEvent.addUnloadHandler(function()
	Tile.setType(-2, -1, "Floor")
	Object.delete(ObjectMap.firstWithComponent(-2, -1, "trapStartRun"))
	Object.delete(ObjectMap.firstWithComponent(-2, -1, "worldLabel"))
end)

local function expectedPlayerCount()
	return math.max(1, Player.getCount())
end

function RouletteLevel.rogueSequences(rng)
	local sequences = {}

	if type(rng) ~= "table" then
		local seed = RNG.getDungeonSeed()
		rng = RNG.makeChannel(seed, seed, seed)
	end

	for i = 1, 4 do
		sequences[i] = {
			depth = i,
			floor = 1 + RNG.int(3, rng),
			zone = i,
			extraSize = 2,
		}
	end

	-- NO BOSS LEVEL
	-- sequences[#sequences + 1] = {
	-- 	depth = #sequences,
	-- 	floor = 4,
	-- 	zone = 0,
	-- 	type = "Boss",
	-- 	boss = RNG.choice(RouletteRogue.Bosses, rng),
	-- }

	return sequences
end

event.levelGenerate.add("rogueModeOverrideProceduralLevelOptions", {
	key = ProceduralLevel.GENERATOR_TYPE,
	sequence = -1,
}, function(ev)
	if ev.options and RouletteRogue.checkMode(ev.options.modeID) then
		ev.options.extraRoomCount = math.min(math.floor(expectedPlayerCount() / 2 - 2.5), 0)
	end
end)

event.levelSequenceUpdate.add("rogueMode", "ensemble", function(ev)
	if RouletteRogue.checkMode(ev.options.modeID) then
		ev.Roulette_sequence = ev.Roulette_sequence or ev.sequence
		ev.sequence = RouletteLevel.rogueSequences(ev.rng)
	end
end)

--- @deprecated
function RouletteLevel.updateLevelSequence()
	local currentSequence = Utilities.fastCopy(Room.getAttribute(Netplay.RoomAttribute.LEVEL_SEQUENCE))
	if type(currentSequence) ~= "table" then
		return
	end

	--- @diagnostic disable: missing-fields
	local ls = LevelSequence.generate {
		sequence = RouletteLevel.rogueSequences(),
		options = {
			initialCharacters = Player.getInitialCharacterMap(),
			modeID = CurrentLevel.getMode().id,
			seed = RNG.getDungeonSeed(),
			--- @diagnostic disable-next-line: assign-type-mismatch
			type = LevelGenerator.Type.Necro,
		},
	}
	--- @diagnostic enable: missing-fields
	for i, entry in ipairs(ls.sequence) do
		currentSequence[i] = Utilities.mergeDefaults(ls.options, entry)
	end
	for i = #ls.sequence + 1, #currentSequence do
		currentSequence[i] = nil
	end
	Room.setAttribute(Netplay.RoomAttribute.LEVEL_SEQUENCE, currentSequence)
end

--- @type integer?
ParticipatedPlayerCount = Snapshot.variable(1)

function RouletteLevel.getParticipatedPlayerCount()
	return ParticipatedPlayerCount or 1
end

event.gameStateLevel.add("initParticipatedPlayerCount", "participation", function(ev)
	ParticipatedPlayerCount = tonumber(ev.Roulette_participatedPlayerCount) or Player.getCount()
end)

-- do
-- 	local function tryUpdateLevelSequence()
-- 		if nil and expectedPlayerCount() > ParticipatedPlayerCount then
-- 			ParticipatedPlayerCount = expectedPlayerCount()
-- 			RouletteLevel.updateLevelSequence()
-- 		end
-- 	end

-- 	event.objectSpectate.add("rogueModeUpdateLevelSequence", "intangible", tryUpdateLevelSequence)
-- 	event.objectUnspectate.add("rogueModeUpdateLevelSequence", "tangible", tryUpdateLevelSequence)
-- end

local isLevelLoading = false

function RouletteLevel.isLevelLoading()
	return isLevelLoading
end

event.levelLoad.add("setLevelLoadingFlag", {
	order = "compatibility",
	sequence = -1e7,
}, function()
	isLevelLoading = true
end)

event.levelLoad.add("resetLevelLoadingFlag", {
	order = "lobbyLevel",
	sequence = 1e7,
}, function()
	isLevelLoading = false
end)

event.objectSpawn.add("rogueModeConvert", {
	filter = "Roulette_rogueModeEntityReplaceOnLevelLoad",
	order = "delete",
}, function(ev)
	if isLevelLoading and RouletteRogue.isModeActive() and not (ev.attributes and ev.attributes._Roulette_noConversion) then
		Object.delete(ev.entity)

		if ev.entity.Roulette_rogueModeEntityReplaceOnLevelLoad.type ~= "" then
			Object.spawn(ev.entity.Roulette_rogueModeEntityReplaceOnLevelLoad.type, ev.entity.position.x, ev.entity.position.y)
		end
	end
end)

event.levelLoad.add("convertOnLevelLoad", "lobbyLevel", function()
	local modeID = GameSession.getCurrentMode().id
	for entity in ECS.entitiesWithComponents { "Roulette_convertOnLevelLoad" } do
		local targetModes = entity.Roulette_convertOnLevelLoad.targetGameModes
		if not next(targetModes) or targetModes[modeID] then
			Object.convert(entity, entity.Roulette_convertOnLevelLoad.entityType)
		end
	end
end)

event.levelLoad.add("overrideEntities", "entities", function(ev)
	if RouletteRogue.isModeActive() then
		Utilities.removeIf(ev.entities, function(entry)
			local convert = ECS.getEntityPrototype(entry.type).Roulette_rogueModeEntityReplaceOnLevelLoad
			if convert then
				if convert.type == "" then
					return true
				end

				entry.type = convert.type
			end
		end)
	end
end)

LevelRooms = {}

event.levelLoad.add("readRoomData", "currentLevel", function(ev)
	if ev.rooms and RouletteGame.isAnyModeActive() then
		local seed = RNG.getDungeonSeed()
		LevelRooms = RNG.shuffle(Utilities.fastCopy(ev.rooms), RNG.makeChannel(seed, seed, seed))

		for i, room in ipairs(LevelRooms) do
			room[room] = i
		end
		local lowPriority = #LevelRooms
		table.sort(LevelRooms, function(l, r)
			local lp = l.type == ProceduralLevel.RoomType.SHOP and lowPriority or l[l]
			local rp = r.type == ProceduralLevel.RoomType.SHOP and lowPriority or r[r]
			if lp ~= rp then
				return lp < rp
			else
				return l[l] < r[r]
			end
		end)
	else
		ev.rooms = {}
	end
end)

RoomEntitySeenCounts = Snapshot.runVariable {}

function RouletteLevel.getRoomEntitySeenCounts()
	return RoomEntitySeenCounts
end

RoomJudge2RoomIndices = Snapshot.levelVariable {}

--- @param judgeEntity Entity
function RouletteLevel.getRoomByJudgeEntity(judgeEntity)
	local index = RoomJudge2RoomIndices[judgeEntity.id]
	return index and LevelRooms[index] or nil
end

--- Im not gonna optimize this algorithm xd
--- @param index integer
--- @param room table
--- @param miniboss integer?
function RouletteLevel.initializeRogueRoom(index, room, miniboss)
	local requiredComponents = LevelSequence.Zone.data[CurrentLevel.getZone()]
	requiredComponents = {
		"!Roulette_apparition",
		"Roulette_gambler",
		"Roulette_enemyPoolNormal",
		requiredComponents and tostring(requiredComponents.Roulette_rogueEnemyComponent) or "Roulette_enemyPool",
	}

	local choiceArgs = {
		requiredComponents = requiredComponents,
		chanceFunction = function(e)
			return e.Roulette_enemyPool.weight
		end,
		filter = function()
			return true
		end,
		seenCounts = RoomEntitySeenCounts,
		markSeen = true,
		seed = CurrentLevel.getSeed(),
	}
	local enemies = {}

	do
		local countList = {}
		local minimum = math.min((CurrentLevel.getDepth() > 2 and 2 or 1) + expectedPlayerCount(), 6)
		local maximum = math.min(2 + expectedPlayerCount(), 7)
		-- p  z1    z2    z3    z4
		-- =1 [2,3] [2,3] [3,3] [3,3]
		-- =2 [3,4] [3,4] [4,4] [4,4]
		-- =3 [4,5] [4,5] [5,5] [5,5]
		-- =4 [5,6] [5,6] [6,6] [6,6]
		-- >4 [6,7] [6,7] [6,7] [6,7]
		for i = minimum, maximum do
			countList[#countList + 1] = i
		end

		for _ = ((miniboss or 0) + 1), countList[(index + CurrentLevel.getSeed() - 1) % #countList + 1] do
			local entityType = EntityGeneration.choice(choiceArgs)
			local position = RouletteLevel.randomTileInRoom(room, Collision.Group.ENEMY_PLACEMENT)
			if not (entityType and position) then
				break
			end

			enemies[#enemies + 1] = Object.spawn(entityType, position[1], position[2])
		end
	end

	Utilities.arrayRemove(requiredComponents, "Roulette_enemyPoolNormal")
	requiredComponents[#requiredComponents + 1] = "Roulette_enemyPoolMiniboss"
	for i = 1, miniboss do
		local entityType = miniboss and EntityGeneration.choice(choiceArgs)
		if not entityType then
			break
		end

		local x, y
		if i == 1 then
			x, y = Marker.lookUpFirst(Marker.Type.STAIRS, 0, 0)
		else
			x, y = unpack(RouletteLevel.randomTileInRoom(room, Collision.Group.ENEMY_PLACEMENT), 1, 2)
		end

		local entity = ObjectMap.firstWithComponent(x, y, "enemy")
		if entity then
			Object.moveToNearbyVacantTile(entity)
		end
		enemies[#enemies + 1] = Object.spawn(entityType, x, y)
	end

	if enemies[1] then
		local idList = Utilities.newTable(#enemies, 0)
		for i, entity in ipairs(enemies) do
			idList[i] = entity.id
		end

		--- @diagnostic disable-next-line: missing-fields
		local judgeEntity = Object.spawn("Roulette_RogueRoomJudge", math.floor(room.x + room.width / 2), math.floor(room.y + room.height / 2), {
			--- @diagnostic disable-next-line: missing-fields
			Roulette_judge = { gamblers = idList },
		})
		for _, entity in ipairs(enemies) do
			entity.Roulette_gambler.judge = judgeEntity.id
		end

		RoomJudge2RoomIndices[judgeEntity.id] = index
	end
end

local rogueLoadRoomSelectorFire = EnumSelector.new(event.Roulette_rogueLoadRoom, ProceduralLevel.RoomType).fire

event.Roulette_rogueLoadRoom.add("standard", ProceduralLevel.RoomType.STANDARD, function(ev)
	RouletteLevel.initializeRogueRoom(ev.index, ev.room, 0)
end)

event.Roulette_rogueLoadRoom.add("exit", ProceduralLevel.RoomType.EXIT, function(ev)
	local count = 1 + (CurrentLevel.isLoopFinal() and 1 or 0) + (RunState.get(RunState.Attribute.SHRINE_BOSS) and 1 or 0)
	RouletteLevel.initializeRogueRoom(ev.index, ev.room, count)
end)

--- @type { count: integer, seenSlots: table<string, true> }?
local chestGeneration = nil

--- @return Entity.Type?
--- @return string
local function generateChestItem()
	assert(chestGeneration)

	local itemType = EntityGeneration.choice {
		requiredComponents = { "Roulette_rogueItemPoolChest" },
		chanceFunction = function(e)
			return e.Roulette_rogueItemPoolChest.weight
		end,
		filter = function(e)
			return not (e.itemSlot and chestGeneration.seenSlots[e.itemSlot.name])
		end,
		seenCounts = RouletteRogue.getItemSeenCount(),
		seed = CurrentLevel.getSeed(),
	}
	if itemType then
		local prototype = ECS.getEntityPrototype(itemType)
		if prototype.itemSlot then
			chestGeneration.seenSlots[prototype.itemSlot.name] = true
		end

		return itemType, prototype.Roulette_rogueItemPoolChest.chestType
	end

	return nil, ""
end

--- @param ev Event.Roulette_rogueLoadRoom
local function handlerPlaceChests(ev)
	if not chestGeneration then
		return
	end

	while chestGeneration.count > 0 do
		local position = RouletteLevel.randomTileInRoom(ev.room, Collision.Group.ITEM_PLACEMENT)
		if position then
			local entityType, chestType = generateChestItem()
			if entityType then
				--- @diagnostic disable-next-line: missing-fields
				Object.spawn(chestType, position[1], position[2], { storage = { items = { entityType } } })
			end
		end

		chestGeneration.count = chestGeneration.count - 1

		if ev.index ~= ev.lastChestRoomIndex then
			break
		end
	end
end

event.Roulette_rogueLoadRoom.add("secret", ProceduralLevel.RoomType.SECRET, handlerPlaceChests)
event.Roulette_rogueLoadRoom.add("shop", ProceduralLevel.RoomType.SHOP, handlerPlaceChests)

event.gameStateLevel.add("rogueLevelLoad", {
	order = "level",
	sequence = 1,
}, function()
	if RouletteRogue.isModeActive() then
		chestGeneration = {
			count = (((CurrentLevel.getSeed() + CurrentLevel.getNumber()) % 4 == 0) and 2 or 1) + ((CurrentLevel.getZone() == 4) and 1 or 0),
			seenSlots = {},
		}

		local lastChestRoomIndex = 0
		for i, room in ipairs(LevelRooms) do
			if room.type == ProceduralLevel.RoomType.SECRET or room.type == ProceduralLevel.RoomType.SHOP then
				lastChestRoomIndex = i
			end
		end

		for i, room in ipairs(LevelRooms) do
			--- @class Event.Roulette_rogueLoadRoom
			--- @field index integer
			--- @field room table
			--- @field rooms table[]
			--- @field lastChestRoomIndex integer
			local ev = {
				index = i,
				room = room,
				rooms = LevelRooms,
				lastChestRoomIndex = lastChestRoomIndex,
			}
			rogueLoadRoomSelectorFire(ev, room.type)
		end

		chestGeneration = nil
	end
end)

event.objectSpawn.add("rogueShopkeeperSpawnGamblingJudge", {
	filter = { "Roulette_gambler", "Roulette_rogueShopkeeper" },
	order = "spawnExtras",
}, function(ev)
	local entityType = RouletteRogue.isModeActive() and ev.entity.Roulette_rogueShopkeeper.spawnJudge
	if entityType and ECS.isValidEntityType(entityType) then
		local position = ev.entity.position or { x = 0, y = 0 }
		--- @diagnostic disable-next-line: missing-fields
		ev.entity.Roulette_gambler.judge = Object.spawn(entityType, position.x, position.y, { Roulette_judge = { gamblers = { ev.entity.id } } }).id
	end
end)

event.objectSpawn.add("enemyGamblerLateSpawnAutoJoinRogueJudge", {
	filter = { "Roulette_enemy", "Roulette_gambler", "position" },
	order = "turnStartPosition",
	sequence = 1,
}, function(ev)
	if CurrentLevel.isLoading() then
		return
	end

	local x, y = ev.entity.position.x, ev.entity.position.y
	for judgeEntity in ECS.entitiesWithComponents { "Roulette_judge", "Roulette_judgeRogue" } do
		local room = RouletteLevel.getRoomByJudgeEntity(judgeEntity)
		if room and x >= room.x and x < room.x + room.width and y >= room.y and y < room.y + room.height then
			if RouletteJudge.hasStarted(judgeEntity.Roulette_judge) then
				RouletteRogueJudge.midJoin(judgeEntity, ev.entity)

				break
			elseif not Utilities.arrayFind(judgeEntity.Roulette_judge.gamblers, ev.entity.id) then
				table.insert(judgeEntity.Roulette_judge.gamblers, ev.entity.id)
				ev.entity.Roulette_gambler.judge = judgeEntity.id

				break
			end
		end
	end
end)

--- Similar to `PlacementUtils.randomTileInRoom`, but does not check if tile was in other room.
function RouletteLevel.randomTileInRoom(room, mask)
	local validTiles = {}

	for x = room.x, room.x + room.width - 1 do
		for y = room.y, room.y + room.height - 1 do
			if not checkCollision(x, y, mask) then
				validTiles[#validTiles + 1] = { x, y }
			end
		end
	end

	return RNG.choice(validTiles, RNG.Channel.LEVEL_INIT_PLACEMENT)
end
