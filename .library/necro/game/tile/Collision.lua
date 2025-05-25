--- @meta

local Collision = {}

--- @enum Collision.Type
Collision.Type = {
	NONE = 0,
	WALL = 1,
	--- Chests, shrines
	OBJECT = 2,
	--- Playable characters
	PLAYER = 4,
	--- Enemies, cratelikes
	ENEMY = 8,
	--- Deprecated legacy value representing PLAYER|ENEMY
	CHARACTER = 12,
	BORDER = 16,
	FLOOR = 32,
	HAZARD = 64,
	LIQUID = 128,
	EXIT = 256,
	TRAP = 512,
	ITEM = 1024,
	--- Wall torches, firepigs, doors, spike traps
	FIXTURE = 2048,
	FAMILIAR = 4096,
	PREBOSS = 8192,
	--- Players wearing a ring of luck
	LUCK = 16384,
	CRATE = 32768,
	--- Electric orbs
	ORB = 65536,
	--- Doors
	DOOR = 131072,
}

Collision.Group = {
	CHARACTER = 65548,
	SOLID = 65551,
	IGNORE_WALLS = 65566,
	--- Deprecated
	UNSAFE = 704,
	WEAPON_CLEARANCE = 8195,
	ENEMY_PLACEMENT = 65999,
	ITEM_PLACEMENT = 67087,
	PLAYER_PLACEMENT = 67535,
}

function Collision.check(x, y, mask) end

--- @param x integer
--- @param y integer
--- @param mask integer
--- @param offsets any
--- @param limit any
--- @return integer x
--- @return integer y
function Collision.findNearbyVacantTile(x, y, mask, offsets, limit) end

function Collision.getVacantTiles(entity, minDistance, maxDistance, radius, noAlign, mask) end

function Collision.setMask(entity, mask) end

function Collision.getAt(x, y) end

function Collision.arePlayerCollisionsEnabled() end

function Collision.update(entity) end

return Collision
