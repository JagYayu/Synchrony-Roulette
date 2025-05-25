local RouletteDelayEvents = require "Roulette.DelayEvents"
local RouletteRogue = require "Roulette.Rogue"

local Flyaway = require "necro.game.system.Flyaway"
local Object = require "necro.game.object.Object"
local ObjectMap = require "necro.game.object.Map"
local TextPool = require "necro.config.i18n.TextPool"

--#region Shrines

local function getShrineOfTimeKey(entity)
	return ("%s:%d"):format(entity.Roulette_shrineOfTime.key, entity.id)
end

event.shrine.add("shrineOfTime", "DelayEventTimeScaler", function(ev)
	local shrineOfTime = ev.entity.Roulette_shrineOfTime
	if not (shrineOfTime and ev.entity.shrine) then
		return
	end

	ev.entity.shrine.active = false

	shrineOfTime.level = shrineOfTime.level % #shrineOfTime.scales + 1
	local level = shrineOfTime.level
	RouletteDelayEvents.setTimeScale(getShrineOfTimeKey(ev.entity), shrineOfTime.scales[level])
	Flyaway.create {
		entity = ev.entity,
		text = TextPool.get(("mod.Roulette.%s.shrineOfTime.%d"):format(ev.entity.name, level)) or tostring(shrineOfTime.flyaways[level]),
	}
end)

event.objectDespawn.add("shrineOfTimeResetScale", {
	filter = "Roulette_shrineOfTime",
	order = "despawnExtras",
}, function(ev)
	RouletteDelayEvents.setTimeScale(getShrineOfTimeKey(ev.entity), nil)
end)

event.gameStateLevel.add("placeShrineOfTime", "spawnPlayers", function(ev)
	if ev.level == 1 and RouletteRogue.isModeActive() then
		local x, y = 0, -2
		if not ObjectMap.firstWithComponent(x, y, "Roulette_shrineOfTime") then
			Object.moveToNearbyVacantTile(Object.spawn("Roulette_ShrineOfDelayEventTimeScaler", x, y))
		end
	end
end)

event.lightSourceUpdate.add("shrineOfTimeAlwaysActive", {
	filter = { "Roulette_shrineOfTime", "lightSourceRadial", "shrine" },
	order = "shrine",
	sequence = 2,
}, function(ev)
	ev.entity.lightSourceRadial.active = true
end)

--#endregion

--#region Secret Rooms

event.objectSpawn.add("makeSecretShop", {
	filter = "Roulette_secretShopkeeper",
	order = "spawnExtras",
}, function(ev) --- @param ev Event.ObjectSpawn
	local x = ev.x + ev.entity.Roulette_secretShopkeeper.tileX
	local y = ev.y + ev.entity.Roulette_secretShopkeeper.tileY
	local components = {
		trapTransaction = {
			shopkeeper = ev.entity.id,
			targetX = x,
			targetY = y + 3,
		},
		editorLinkChildEntity = { parent = ev.entity.id },
		transactionAutoDespawnOnProvoke = { shopkeeper = ev.entity.id }
	}

	Object.spawn("TransactionTileFeet", x - 1, y, components)
	Object.spawn("TransactionTileBody", x + 0, y, components)
	Object.spawn("TransactionTileRing", x + 1, y, components)
end)

--#endregion Secret Rooms
