--- @meta

local LevelRegion = {}

LevelRegion.Type = {
	SAFE = 1,
}

function LevelRegion.anyExists(regionType) end

function LevelRegion.check(x, y, regionType) end

function LevelRegion.checkEntity(entity, regionType) end

function LevelRegion.getAll() end

function LevelRegion.add(regionType, rect, negate) end

function LevelRegion.remove(id) end

return LevelRegion
