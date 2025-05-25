-- TODO
local RouletteStatistic = {}

local AnimationTimer = require "necro.render.AnimationTimer"
local BasicOps = require "system.utils.BasicOps"
local ECS = require "system.game.Entities"
local Enum = require "system.utils.Enum"
local Focus = require "necro.game.character.Focus"
local GFX = require "system.gfx.GFX"
local HUDLayout = require "necro.render.hud.HUDLayout"
local LocalCoop = require "necro.client.LocalCoop"
local ObjectMap = require "necro.game.object.Map"
local OutlineFilter = require "necro.render.filter.OutlineFilter"
local Render = require "necro.render.Render"
local RenderTimestep = require "necro.render.RenderTimestep"
local Settings = require "necro.config.Settings"
local Snapshot = require "necro.game.system.Snapshot"
local Tile = require "necro.game.tile.Tile"
local UI = require "necro.render.UI"
local Utilities = require "system.utils.Utilities"
local VisualExtent = require "necro.render.level.VisualExtent"

UserStats = Settings.user.table {
	id = "statistics",
	visibility = Settings.Visibility.HIDDEN,
	association = Settings.Association.USER,
	default = {},
}

RouletteStatistic.Update = Enum.immutable {
	bor = BasicOps.booleanOr,
	add = BasicOps.add,
	max = math.max,
}

RouletteStatistic.ID = Enum.protocol {
	AllZonesClears = Enum.entry(1, { update = RouletteStatistic.Update.max }),
	AllZonesPersonalBest = Enum.entry(2, { update = RouletteStatistic.Update.max }),
	AllZonesHighScore = Enum.entry(3, { update = RouletteStatistic.Update.max }),
	EndlessPersonalBest = Enum.entry(4, { update = RouletteStatistic.Update.max }),
	EndlessHighScore = Enum.entry(5, { update = RouletteStatistic.Update.max }),
}
local ID = RouletteStatistic.ID

RunStats = Snapshot.runVariable {}

function RouletteStatistic.commit()
	for playerID, stats in Utilities.sortedPairs(RunStats) do
		-- if type(playerID) == "number" and LocalCoop.isCoopPlayer() then
		-- 	
		-- end
	end

	RunStats = {}
end

-- TODO
-- event.gameStateReset.add("commitStatistics", "statisticsPersistence", RouletteStatistic.commit)
-- event.runComplete.add("commitStatistics", "statistics", RouletteStatistic.commit)

return RouletteStatistic
