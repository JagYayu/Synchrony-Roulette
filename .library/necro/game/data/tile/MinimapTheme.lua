--- @meta

local MinimapTheme = {}

MinimapTheme.Color = {
	--- Entities
	PLAYER = -65536,
	ENEMY = -16767519,
	NPC = -10382523,
	ITEM = -16718593,
	TRAP = -10041,
	SHRINE = -1,
	CHEST = -16743169,
	--- Walls
	DIRT = -14126693,
	STONE = -14332294,
	CATACOMB = -11168804,
	SHOP = -16738363,
	DOOR = -9634048,
	METAL_DOOR = -10890752,
	LEVEL_BORDER = -9539986,
	STAGE = 0,
	--- Floors
	FLOOR = -5652534,
	STAIRS = -65295,
	WATER = -872332,
	TAR = -12378521,
	ICE = -5200,
	HOT_COALS = -7037185,
	OOZE = -15095268,
	WIRE = -16715077,
}

MinimapTheme.Depth = {
	NONE = 0,
	FLOOR = 1,
	ITEM = 2,
	SHRINE = 3,
	CHEST = 4,
	TRAP = 5,
	ENEMY = 6,
	STAIRS = 7,
	WALL = 8,
	PLAYER = 9,
}

return MinimapTheme
