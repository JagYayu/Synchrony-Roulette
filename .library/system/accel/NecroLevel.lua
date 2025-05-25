--- @meta

local NecroLevel = {}

NecroLevel.TileFlags = {
	TORCH = 1,
	TRIGGER = 4,
	WIRE_RIGHT = 8,
	WIRE_DOWN = 16,
	WIRE_LEFT = 32,
	WIRE_UP = 64,
	TORCH_BRIGHT = 128,
}

NecroLevel.Directions = {
	NONE = -1,
	RIGHT = 0,
	DOWN = 1,
	LEFT = 2,
	UP = 3,
	DOWN_RIGHT = 4,
	DOWN_LEFT = 5,
	UP_LEFT = 6,
	UP_RIGHT = 7,
}

NecroLevel.ItemPlaceholder = {
	CHEST_REGULAR = 1,
	CHEST_INVISIBLE = 2,
	CHEST_LOCKED = 3,
	VAULT = 4,
	POTION = 5,
	RAT_TRAP = 6,
	LOCKED_SHOP_BOMB = 7,
	GOLD_OR_BOMBS = 8,
	DIAMONDS = 9,
	CHEST_KEY = 10,
	NPC_KEY = 11,
}

function NecroLevel.init(xmlData) end

function NecroLevel.cleanUp() end

function NecroLevel.generate(parameters) end

function NecroLevel.pollLevel(id) end

return NecroLevel
