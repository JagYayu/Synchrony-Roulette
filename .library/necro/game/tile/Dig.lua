--- @meta

local Dig = {}

Dig.Strength = {
	NONE = -3,
	DOOR = -2,
	EARTH = -1,
	--- Z4 walls
	DEFAULT = 0,
	DIRT = 1,
	STONE = 2,
	CATACOMB = 3,
	SHOP = 4,
	UNBREAKABLE = 99,
}

function Dig.breakTile(x, y, strength, flags, direction) end

function Dig.perform(parameters) end

return Dig
