local RouletteGame = {}
local RouletteLocalization = require "Roulette.data.Localization"
local RouletteUtility = require "Roulette.Utility"

local Damage = require "necro.game.system.Damage"
local Delay = require "necro.game.system.Delay"
local DungeonFile = require "necro.client.custom.DungeonFile"
local DungeonLoader = require "necro.game.data.level.DungeonLoader"
local GameMod = require "necro.game.data.resource.GameMod"
local GameSession = require "necro.client.GameSession"
local GrooveChain = require "necro.game.character.GrooveChain"
local Move = require "necro.game.system.Move"
local Object = require "necro.game.object.Object"
local ProceduralLevel = require "necro.game.data.level.ProceduralLevel"
local Respawn = require "necro.game.character.Respawn"
local Settings = require "necro.config.Settings"
local SettingsStorage = require "necro.config.SettingsStorage"
local Utilities = require "system.utils.Utilities"
local WeeklyChallenge = require "necro.game.data.modifier.WeeklyChallenge"
local WorldLabel = require "necro.game.system.WorldLabel"

local getCurrentModeID = GameSession.getCurrentModeID

do
	local data = {
		id = "Roulette_Roulette",
		name = RouletteLocalization.Roulette,
		seedMode = GameSession.SeedMode.RANDOM,
		selectFile = {
			title = L("Select dungeon"),
			paths = {
				"ext/dungeons",
				"ext/downloaded_dungeons",
				DungeonFile.MOUNT_POINT,
			},
			filter = function(fileName)
				return fileName:match("([^/]+)%.[Xx][Mm][Ll]$") or fileName:match("([^/]+)%.necrolevel$")
			end,
		},
		--- @diagnostic disable-next-line: missing-fields
		generatorOptions = { type = DungeonLoader.GENERATOR_TYPE },
		applyCustomRules = true,
		depthPriceMultiplier = false,
		playerCollisions = true,
		levelCounterHUD = false,
		seedHUD = false,
	}
	RouletteGame.FreeMode = GameSession.registerMode(Utilities.deepCopy(data))

	data = Utilities.deepCopy(data)
	data.id = "Roulette_RouletteRogue"
	data.name = RouletteLocalization.RouletteRogue
	data.selectFile = nil
	data.generatorOptions = { type = ProceduralLevel.GENERATOR_TYPE }
	data.applyCustomRules = false
	data.levelCounterHUD = true
	data.seedHUD = true
	data.resetTimeScale = true
	data.timerHUD = true
	data.timerName = RouletteLocalization.SpeedrunTimer
	data.introText = false
	RouletteGame.RogueMode = GameSession.registerMode(data)

	data = Utilities.deepCopy(data)
	data.id = "Roulette_RouletteRogueSeeded"
	data.name = RouletteLocalization.RouletteRogueSeeded
	data.timerName = RouletteLocalization.SpeedrunTimerSeeded
	data.timerNameScale = .8
	data.seedMode = GameSession.SeedMode.MANUAL
	RouletteGame.RogueModeSeeded = GameSession.registerMode(data)
end

local set = {
	[RouletteGame.FreeMode] = RouletteGame.FreeMode,
	[RouletteGame.RogueMode] = RouletteGame.RogueMode,
	[RouletteGame.RogueModeSeeded] = RouletteGame.RogueModeSeeded,
}

--- @return GameSession.Mode?
local function isAnyModeActive()
	return set[getCurrentModeID()]
end
--- "AnyMode" means one of gamemode from this mod: `RouletteGame.FreeMode`, `RouletteGame.RogueMode`, `RouletteGame.RogueModeSeeded`
RouletteGame.isAnyModeActive = isAnyModeActive

local function isFreeModeActive()
	return getCurrentModeID() == RouletteGame.FreeMode
end
--- "StandardMode" is `RouletteGame.FreeMode`
RouletteGame.isStandardModeActive = isAnyModeActive

event.objectUpdateRhythm.add("gamblingModeNoBeat", {
	filter = "Roulette_gambler",
	order = "customMode",
}, function(ev)
	if not ev.ignoreRhythm and isAnyModeActive() then
		ev.ignoreRhythm = true
	end
end)

event.gameStateLevel.add("gamblingUpdateWorldLabels", "worldLabels", function()
	if isFreeModeActive() then
		WorldLabel.updateAll() -- Mainly for applying localized texts to world labels.
	end
end)

--#region Lobby Manager

-- LobbyManagerProcess = function(_, _, _) end --- @diagnostic disable-next-line: redefined-local
-- LobbyManagerProcess = Delay.new(function(entity, parameter)
-- 	ECS.defragmentEntityIDs()
--
-- 	local delay = parameter and tonumber(parameter.delay)
-- 	if delay then
-- 		LobbyManagerProcess(entity, parameter, delay)
-- 	end
-- end, { unique = true })

-- event.gameStateLevel.add("rouletteLobbyExtraEntity", "attachments", function()
-- 	if getCurrentModeID() == RouletteGame.FreeMode then
-- 		local entityType = ECS.getEntityTypesWithComponents { "Roulette_lobby", "gameObject", "position" }[1]
-- 		if entityType then
-- 			Object.spawn(entityType, 0, 0)
-- 		end
-- 	end
-- end)

-- event.objectSpawn.add("lobbyManager", {
-- 	filter = { "Roulette_lobby", "gameObject", "position" },
-- 	order = "delete",
-- }, function(ev)
-- 	local deleteSelf = false
-- 	for entity in ECS.entitiesWithComponents { "Roulette_lobby", "gameObject", "position" } do
-- 		if entity.id ~= ev.entity.id then
-- 			deleteSelf = true
-- 			break
-- 		end
-- 	end

-- 	if deleteSelf then
-- 		Object.delete(ev.entity)
-- 	else
-- 		local delay = 5 * 60
-- 		LobbyManagerProcess(ev.entity, { delay = delay }, delay)
-- 	end
-- end)

--#endregion

--#region Generic System

ReviveLater = Delay.new(function(entity)
	Respawn.revive(entity, {
		healPercent = 1,
	})
	Move.absolute(entity, 0, 0)
	Object.moveToNearbyVacantTile(entity, entity.collisionCheckOnMove and entity.collisionCheckOnMove.mask, entity.movable and entity.movable.moveType)
end)

event.objectDeath.add("reviveLater", {
	filter = "playableCharacter",
	order = "respawn",
}, function(ev)
	if isFreeModeActive() then
		ReviveLater(ev.entity, nil, 3)
		ev.runSummary = false
	end
end)

event.objectTakeDamage.add("gamblerExplosionImmunity", {
	filter = "Roulette_gambler",
	order = "immunity",
}, function(ev) ---@param ev Event.ObjectTakeDamage
	if isAnyModeActive() and ev.type == Damage.Type.EXPLOSIVE then
		ev.damage = 0
	end
end)

RouletteGame.GrooveChain_Type_ShootingBlank = GrooveChain.Type.extend("Roulette_ShootingBlank", -6)

event.objectGrooveChain.add("gamblerGrooveChainImmunity", {
	filter = "Roulette_gambler",
	order = "immunity"
}, function(ev)
	if ev.type <= GrooveChain.Type.UPDATE and ev.type > RouletteGame.GrooveChain_Type_ShootingBlank and isAnyModeActive() then
		ev.suppressed = true
	end
end)

event.gameStateLevel.add("overrideEnableInstantReplaySetting", {
	order = "resetSettings",
	sequence = 1,
}, function()
	SettingsStorage.set("replay.instant.enabled", RouletteUtility.condition(RouletteGame.isAnyModeActive(), false, nil), Settings.Layer.SCRIPT_OVERRIDE)
end)

--#endregion

--#region Weekly Challenge Specification

if GameMod.isModLoaded("Initializer_io_3812341") then
	Utilities.mergeTables(GameSession.Mode.data[WeeklyChallenge.MODE_ID], {
		applyCustomRules = false,
		depthPriceMultiplier = false,
		generatorOptions = { type = "Necro" },
		id = "Roulette_RouletteRogue",
		introText = false,
		levelCounterHUD = true,
		name = RouletteLocalization.RouletteRogue,
		playerCollisions = true,
		resetTimeScale = true,
		seedHUD = true,
		seedMode = 1,
		timerHUD = true,
		timerName = RouletteLocalization.SpeedrunTimer,
	})

	set[WeeklyChallenge.MODE_ID] = RouletteGame.RogueMode

	function RouletteGame.isWeeklyMode()
		return getCurrentModeID() == WeeklyChallenge.MODE_ID
	end

	--#region rez shrine stuff
	local ECS = require "system.game.Entities"
	local ObjectMap = require "necro.game.object.Map"
	local Player = require "necro.game.character.Player"

	local x, y = 1, -2
	local shrineName = "RezShrine_ShrineOfResurrection"
	local shrineComponent = "RezShrine_rezShrine"

	local function spawnRezShrine(v)
		if RouletteGame.isWeeklyMode()
			and ECS.isValidEntityType(shrineName)
			and not ObjectMap.firstWithComponent(x, y, shrineComponent)
			and Player.getCount() > v
		then
			--- @diagnostic disable-next-line: missing-fields
			Object.spawn(shrineName, x, y, { _Roulette_noConversion = true, priceTagCostCurrency = { cost = 10 } })
			local timeShrine = ObjectMap.firstWithComponent(0, -2, "Roulette_shrineOfTime")
			if timeShrine then
				Move.relative(timeShrine, -1, 0, Move.Type.NONE)
			end
		end
	end

	event.gameStateLevel.add("weeklySpawnRezShrine", {
		order = "spawnPlayers",
		sequence = 1,
	}, function()
		spawnRezShrine(1)
	end)
	event.objectSpawn.add("weeklySpawnRezShrine", {
		filter = "playableCharacter",
		order = "spawnExtras",
	}, function(ev)
		if ev.entity.playableCharacter.pendingPlayerID ~= 0 then
			spawnRezShrine(0)
		end
	end)
	--#endregion
else
	function RouletteGame.isWeeklyMode()
		return false
	end
end

event.gameStateLevel.add("weeklyModeCustomIntroText", "worldLabels", function(ev)
	if ev.level == 1 and RouletteGame.isWeeklyMode() then
		---@diagnostic disable
		Object.spawn("LabelFadingIntroductory", 0, -1, {
			worldLabel = { text = "Roulette mode!", offsetY = 3 },
		})
		Object.spawn("LabelFadingIntroductory", 0, 1, {
			worldLabel = { text = "Play through the game with custom\nruleset. See \"Roulette Guide\"\nin pause menu to learn more!", offsetY = 4 },
		})
		---@diagnostic enable
	end
end)

--#endregion

return RouletteGame
