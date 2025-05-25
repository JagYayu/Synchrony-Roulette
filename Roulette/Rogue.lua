local RouletteGame = require "Roulette.Game"
local RouletteRogue = {}
local RouletteUtility = require "Roulette.Utility"

local Boss = require "necro.game.level.Boss"
local Collision = require "necro.game.tile.Collision"
local CurrentLevel = require "necro.game.level.CurrentLevel"
local ECS = require "system.game.Entities"
local EntityGeneration = require "necro.game.level.EntityGeneration"
local Flyaway = require "necro.game.system.Flyaway"
local Inventory = require "necro.game.item.Inventory"
local LevelExit = require "necro.game.tile.LevelExit"
local LevelSequence = require "necro.game.level.LevelSequence"
local MoveAnimations = require "necro.render.level.MoveAnimations"
local Object = require "necro.game.object.Object"
local ObjectMap = require "necro.game.object.Map"
local Random = require "system.utils.Random"
local RunState = require "necro.game.system.RunState"
local Settings = require "necro.config.Settings"
local Snapshot = require "necro.game.system.Snapshot"
local Tile = require "necro.game.tile.Tile"
local TileDamage = require "necro.game.tile.TileDamage"
local Turn = require "necro.cycles.Turn"
local Utilities = require "system.utils.Utilities"
local WeeklyChallenge = require "necro.game.data.modifier.WeeklyChallenge"

local RogueMode = RouletteGame.RogueMode
local RogueModeSeeded = RouletteGame.RogueModeSeeded
local getMode = CurrentLevel.getMode

RouletteRogue.Bosses = {
	Boss.Type.KING_CONGA,
	Boss.Type.DEATH_METAL,
	Boss.Type.DEEP_BLUES,
	Boss.Type.CORAL_RIFF,
}

pcall(function()
	LevelSequence.Zone.data[LevelSequence.Zone.ZONE_1].Roulette_rogueEnemyComponent = "Roulette_enemyPoolZ1"
	LevelSequence.Zone.data[LevelSequence.Zone.ZONE_2].Roulette_rogueEnemyComponent = "Roulette_enemyPoolZ2"
	LevelSequence.Zone.data[LevelSequence.Zone.ZONE_3].Roulette_rogueEnemyComponent = "Roulette_enemyPoolZ3"
	LevelSequence.Zone.data[LevelSequence.Zone.ZONE_4].Roulette_rogueEnemyComponent = "Roulette_enemyPoolZ4"
end)

--- @param id GameSession.Mode
--- @return boolean
function RouletteRogue.checkMode(id)
	return id == RogueMode or id == RogueModeSeeded or id == WeeklyChallenge.MODE_ID
end

local checkMode = RouletteRogue.checkMode

event.runStateInit.add("rogueModeOverrideRunState", "extraModes", function(ev)
	if checkMode(ev.mode.id) then
		ev.state[RunState.Attribute.GENERATED_LOCKED_SHOP] = true
		ev.state[RunState.Attribute.GENERATED_URN] = true
		ev.state[RunState.Attribute.GENERATED_VAULT] = true
	end
end)

event.gameStateLevel.add("rogueModeOverrideRunState", "levelLoadingDone", function()
	RunState.set(RunState.Attribute.LEPRECHAUN_SPAWNED, 1)
end)

function RouletteRogue.isModeActive()
	return checkMode(getMode().id)
end

local isModeActive = RouletteRogue.isModeActive

--#region Overrides

local function disableHandlerOnRogueActive(func, ev)
	if not isModeActive() then
		func(ev)
	end
end

event.frame.override("aggro", disableHandlerOnRogueActive)
event.holderTakeDamage.override("deathProtection", disableHandlerOnRogueActive)
event.objectCheckMove.override("checkInnateAttack", disableHandlerOnRogueActive)
event.objectCheckMove.override("stasisOnMove", disableHandlerOnRogueActive)
event.objectCheckMove.override("unstasisOnAttack", disableHandlerOnRogueActive)
event.objectCheckMove.override("unstasisOnCollision", disableHandlerOnRogueActive)
event.objectMove.override("stasisOnApproach", disableHandlerOnRogueActive)
event.objectMove.override("stasisOnApproachMinDistance", disableHandlerOnRogueActive)
event.objectMoveResult.override("aggroOnMove", disableHandlerOnRogueActive)
event.objectReveal.override("aggroOnReveal", disableHandlerOnRogueActive)
event.objectTickle.override("stasis", disableHandlerOnRogueActive)
event.render.override("renderItemHintLabels", disableHandlerOnRogueActive)

event.objectDeath.override("castOnDeath", function(func, ev)
	if not (ev.entity.Roulette_rogueModeSuppressCastOnDeath and isModeActive()) then
		return func(ev)
	end
end)

event.objectParry.override("createFlyaway", function(func, ev)
	if not ev.entity.Roulette_rogueModeParryFlyawayOverride then
		return func(ev)
	end

	Flyaway.create {
		entity = ev.entity,
		text = ev.entity.Roulette_rogueModeParryFlyawayOverride.text
	}
end)

--#endregion

SettingInitialItems = Settings.shared.number {
	id = "rogue.initialItems",
	name = "Rogue initial item points",
	default = 0,
	minimum = 0,
	sliderMaximum = 50,
}

event.objectSpawn.add("rogueModeInitialItems", {
	filter = { "inventory", "initialInventory" },
	order = "items",
	sequence = 1,
}, function(ev)
	if isModeActive() then
		Inventory.grantIfUncursed("ShovelBasic", ev.entity)
		Inventory.grantIfUncursed("Roulette_BagRogue", ev.entity)
		Inventory.grantIfUncursed("Roulette_SpellDisengageBlank", ev.entity)
		Inventory.grantIfUncursed("Roulette_SpellDisengageLive", ev.entity)
	end
end)

event.objectSpawn.add("rogueInitialItems", {
	filter = { "inventory", "initialInventory", "playableCharacter", "position" },
	order = "items",
	sequence = 123,
}, function(ev)
	if ev.entity.playableCharacter.pendingPlayerID == 0 then
		return
	end

	local coins = RouletteGame.isWeeklyMode() and 10 or tonumber(SettingInitialItems) or 0
	if coins == 0 then
		return
	end

	local seed = CurrentLevel.getSeed() + ev.entity.id
	local itemSet = Utilities.listToSet {
		"Food1",
		"Food2",
		"Food3",
		"Food4",
		"FoodCarrot",
		"HolyWater",
		"ScrollFreezeEnemies",
		"ScrollShield",
		"ScrollTransmute",
		"Roulette_HeartTransplant",
		"Roulette_ScrollCharm",
		"Roulette_ScrollConvertBlankShell",
		"Roulette_ScrollConvertLiveShell",
		"Roulette_ScrollFireball",
		"Roulette_ScrollSilence",
	}
	local overrideWeight = {
		HolyWater = 1,
	}
	local seenCounts = {}
	for _ = 1, 9 do
		local name = EntityGeneration.choice {
			player = ev.entity,
			requiredComponents = { "Roulette_rogueItemPoolShop" },
			chanceFunction = function(e)
				return overrideWeight[e.name] or e.Roulette_rogueItemPoolShop.weight * 4
			end,
			filter = function(e)
				return itemSet[e.name] and coins >= e.Roulette_rogueItemPoolShop.basePrice
			end,
			seenCounts = seenCounts,
			seed = seed,
		}

		if not name then
			break
		end
		--- @diagnostic disable-next-line: missing-fields
		Object.spawn(name, ev.entity.position.x, ev.entity.position.y, { _Roulette_noConversion = true })
		coins = coins - ECS.getEntityPrototype(name).Roulette_rogueItemPoolShop.basePrice
		if coins <= 0 then
			break
		end
	end
end)

event.levelLoad.add("rogueModeOverridePlayerOptions", "currentLevel", function(ev)
	if isModeActive() then
		ev.playerOptions = ev.playerOptions or {}
		ev.playerOptions.noItems = true
	end
end)

event.objectSpawn.add("sarcophagusNoStairLock", {
	filter = "stairLocker",
	order = "overrides",
}, function(ev)
	if ev.entity.stairLocker.level == LevelExit.StairLock.SARCOPHAGUS and isModeActive() then
		ev.entity.stairLocker.level = LevelExit.StairLock.INACTIVE
	end
end)

event.objectSpawn.add("playableCharacterHealthOverride", {
	filter = { "playableCharacter", "health" },
	order = "overrides",
}, function(ev)
	if isModeActive() then
		if ev.entity.health.maxHealth > 5 then
			ev.entity.health.maxHealth = ev.entity.health.maxHealth - 2
			ev.entity.health.health = Utilities.clamp(0, ev.entity.health.health, ev.entity.health.maxHealth)
		end
	end
end)

event.objectSpawn.add("rogueModeBeatDelayOverride", {
	filter = { "Roulette_rogueBeatDelayOverride", "beatDelay" },
	order = "overrides",
}, function(ev)
	if isModeActive() then
		ev.entity.beatDelay.interval = ev.entity.Roulette_rogueBeatDelayOverride.interval
	end
end)

event.objectBeginSlide.add("rogueModeSlideImmunity", {
	filter = "Roulette_gambler",
	order = "itemCancel",
}, function(ev)
	if isModeActive() then
		ev.suppressed = true
	end
end)

event.objectHotTileStep.add("rogueModeHotTileImmunity", {
	filter = "Roulette_gambler",
	order = "immunity",
}, function(ev)
	if isModeActive() then
		ev.result = TileDamage.IdleResult.SUPPRESSED
	end
end)

event.objectShrink.add("rogueModeShrinkImmunity", {
	filter = "Roulette_gambler",
	order = "immunityItem",
}, function(ev)
	if isModeActive() then
		ev.suppressed = true
	end
end)

event.objectSink.add("rogueModeSinkImmunity", {
	filter = "Roulette_gambler",
	order = "immunity",
}, function(ev)
	if isModeActive() then
		ev.suppressed = true
	end
end)

event.objectUpdateCollision.add("rogueModeNoEnemyCollision", {
	filter = { "Roulette_gambler", "collisionCheckOnMove", "playableCharacter" },
	order = "noPlayerCollision",
}, function(ev)
	if isModeActive() then
		ev.checkOnMove = Collision.Type.unmask(ev.checkOnMove, Collision.Type.ENEMY)
	end
end)

event.objectSpawn.add("rogueModeDeactivateGamblerAI", {
	filter = { "Roulette_gambler", "ai" },
	order = "ai",
}, function(ev)
	if isModeActive() then
		ev.entity.ai.active = false
	end
end)

event.objectSpawn.add("gamblerHealthOverride", {
	filter = { "Roulette_rogueHealthOverride", "health" },
	order = "healthBonus",
	sequence = 7,
}, function(ev)
	if isModeActive() then
		local v = ev.entity.Roulette_rogueHealthOverride.health
		ev.entity.health.health = v
		ev.entity.health.maxHealth = v
	end
end)

event.objectSpawn.add("rogueModeApparitionGamblerAggro", {
	filter = { "Roulette_apparition", "aggro" },
	order = "overrides",
}, function(ev)
	if isModeActive() and not CurrentLevel.isLoading() then
		ev.entity.aggro.active = true
	end
end)

event.objectSpawn.add("rogueModeApparitionGamblerAppear", {
	filter = { "Roulette_apparition", "apparition" },
	order = "overrides",
}, function(ev)
	if isModeActive() and not CurrentLevel.isLoading() then
		ev.entity.apparition.appeared = true
	end
end)

event.Roulette_gamblerStartGame.add("rogueModePlayerGamblerTeam", {
	filter = { "controllable", "team" },
	order = "team",
}, function(ev) --- @param ev Event.Roulette_gamblerJoin
	if ev.entity.controllable.playerID ~= 0 and isModeActive() then
		ev.component.team = ev.entity.team.id
	end
end)

event.objectTakeDamage.add("rogueModeLowHealthConvert", {
	filter = { "Roulette_rogueLowHealthConvert", "health" },
	order = "healthConvert",
}, function(ev)
	if ev.damage > 0 and ev.entity.health.health == 1 and isModeActive() then
		local targetType = tostring(ev.entity.Roulette_rogueLowHealthConvert.targetTypes[ev.entity.health.health])

		if targetType and targetType ~= ev.entity.name then
			local hadShield = ev.entity.shield and ev.entity.shield.active

			Object.convert(ev.entity, targetType)

			if hadShield and not ev.entity.shield.active then
				ev.shieldBreak = true
			end
			ev.knockback = 0
		end
	end
end)

event.objectTakeDamage.add("rogueModeLowHealthLockMaximumHealth", {
	filter = { "Roulette_rogueLowHealthLockMaximum", "health" },
	order = "spellLate",
	sequence = 30,
}, function(ev)
	if ev.survived and isModeActive() and ev.entity.health.health <= ev.entity.Roulette_rogueLowHealthLockMaximum.health then
		ev.entity.health.maxHealth = ev.entity.health.health
	end
end)

event.objectTakeDamage.add("rogueModeBystandingPlayerGamblerImmunity", {
	filter = { "Roulette_gambler", "playableCharacter" },
	order = "immunity",
	sequence = 30,
}, function(ev)
	if isModeActive() and not ECS.entityExists(ev.entity.Roulette_gambler.judge) then
		ev.suppressed = true
		ev.damage = 0
	end
end)

--#region Rogue Shop

event.levelLoad.add("initializeRogueShopkeeperPlacements", {
	order = "initialItems",
	sequence = 1e6,
}, function()
	if RunState.get(RunState.Attribute.SHOPKEEPER_DEAD) then
		return
	end

	local placementTIDSet = {}

	for item in ECS.entitiesWithComponents { "position", "sale" } do
		local priceTag = ECS.getEntityByID(item.sale.priceTag)
		local shopkeeper = priceTag and priceTag.priceTagShopkeeperProximity and ECS.getEntityByID(priceTag.priceTagShopkeeperProximity.shopkeeper)
		if shopkeeper and shopkeeper.Roulette_rogueShopkeeper then
			placementTIDSet[Tile.reduceCoordinates(item.position.x, item.position.y) or false] = true
			table.insert(shopkeeper.Roulette_rogueShopkeeper.placements, { item.position.x, item.position.y })
		end
	end

	for shopkeeper in ECS.entitiesWithComponents { "Roulette_rogueShopkeeper", "position" } do
		for _, offset in ipairs(shopkeeper.Roulette_rogueShopkeeper.placementsInitial) do
			local x = shopkeeper.position.x + (tonumber(offset[1]) or 0)
			local y = shopkeeper.position.y + (tonumber(offset[2]) or 0)
			if Tile.exists(x, y) and not placementTIDSet[Tile.reduceCoordinates(x, y)] then
				table.insert(shopkeeper.Roulette_rogueShopkeeper.placements, { x, y })
			end
		end
	end
end)

ItemSeenCounts = Snapshot.runVariable {}

function RouletteRogue.getItemSeenCount()
	return ItemSeenCounts
end

local function restoreItem(shopkeeper, itemPosition, advancedItems, seenSlots, existedItems)
	if Collision.check(itemPosition[1], itemPosition[2], Collision.Group.ITEM_PLACEMENT) then
		return false
	end

	local shop = shopkeeper.Roulette_rogueShopkeeper
	local shopPosition = shopkeeper.position
	local function filter(e)
		return not (existedItems[e.name] or e.itemSlot and seenSlots[e.itemSlot.name])
	end

	local entityType = EntityGeneration.choice {
		requiredComponents = { "Roulette_rogueItemPoolShop" },
		chanceFunction = function(e)
			return e.Roulette_rogueItemPoolShop.weight
		end,
		filter = advancedItems and function(e)
			return e.Roulette_rogueItemPoolShop.advanced and filter(e)
		end or function(e)
			return not e.Roulette_rogueItemPoolShop.advanced and filter(e)
		end,
		seenCounts = advancedItems and ItemSeenCounts or nil,
		seed = Random.noise3(shopkeeper.id, shop.generationIndex, CurrentLevel.getSeed(), 16777216),
	}
	local entity = entityType and Object.spawn(entityType, itemPosition[1], itemPosition[2], shop.attributes)
	if entity and entity.sale then
		if entity.itemSlot then
			seenSlots[entity.itemSlot.name] = true
		end

		local multiplier = shop.priceMultiplier
		if Turn.getCurrentTurnID() > 0 then
			shop.priceMultiplierIncrement = shop.priceMultiplierIncrement + 1
			multiplier = multiplier + shop.priceMultiplierIncrement
		end
		if entity.Roulette_rogueItemPoolShop.advanced then
			multiplier = multiplier + shopkeeper.Roulette_rogueShopkeeper.advancedExtraMultiplier
		end

		--- @diagnostic disable: missing-fields
		entity.sale.priceTag = Object.spawn("PriceTagGold", itemPosition[1], itemPosition[2], {
			priceTagCostCurrency = { cost = entity.Roulette_rogueItemPoolShop.basePrice * multiplier },
			priceTagCostHealth = { cost = math.ceil(entity.Roulette_rogueItemPoolShop.basePrice * multiplier) },
			priceTagShopkeeperProximity = { shopkeeper = shopkeeper.id },
		}).id
		--- @diagnostic enable: missing-fields

		MoveAnimations.play(entity, MoveAnimations.Type.HOP, shopPosition.x, shopPosition.y)
		shop.generationIndex = shop.generationIndex + 1
		return entity
	end
end

--- @param entity Entity
--- @param extra { count: integer?, advancedItems: table | true? }?
--- @return integer?
function RouletteRogue.shopGenerate(entity, extra)
	local shop = entity.Roulette_rogueShopkeeper
	if not shop or not entity.position then
		return
	end

	extra = extra or RouletteUtility.emptyTable
	local count = tonumber(extra.count) or math.huge
	local advancedItems = not not extra.advancedItems
	local seenSlots = {}

	local existedItems = {}
	for _, position in ipairs(shop.placements) do
		local item = ObjectMap.firstWithComponent(position[1], position[2], "item")
		if item then
			existedItems[item.name] = true
		end
	end

	for _, position in ipairs(shop.placements) do
		if restoreItem(entity, position, advancedItems, seenSlots, existedItems) then
			shop.generationIndex = shop.generationIndex + 1

			count = count - 1
			if count <= 0 then
				break
			end
		end
	end
end

event.gameStateLevel.add("rogueShopGenerateItems", {
	order = "level",
	sequence = 999,
}, function()
	if isModeActive() then
		for entity in ECS.entitiesWithComponents { "Roulette_rogueShopkeeper", "position" } do
			RouletteRogue.shopGenerate(entity, {
				count = #entity.Roulette_rogueShopkeeper.placements - 2,
				advancedItems = true,
			})
			RouletteRogue.shopGenerate(entity)
		end
	end
end)

event.turn.add("rogueShopkeeperRestoreItems", "updateItems", function(ev)
	if ev.globalActivation and isModeActive() then
		for entity in ECS.entitiesWithComponents { "Roulette_rogueShopkeeper", "position", "visibility" } do
			if entity.visibility.revealed then
				RouletteRogue.shopGenerate(entity)
			end
		end
	end
end)

event.objectSpawn.add("rogueShopkeeperReplaceCrown", {
	filter = { "Roulette_rogueShopkeeper", "storage" },
	order = "itemsExtraMode",
}, function(ev)
	if isModeActive() then
		local i = Utilities.arrayFind(ev.entity.storage.items, "HeadCrownOfGreed")
		if i then
			ev.entity.storage.items[i] = "Roulette_HeadCrownOfGreed"
		end
	end
end)

--#endregion Rogue Shop

return RouletteRogue
