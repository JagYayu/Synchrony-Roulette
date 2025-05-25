--- @meta

local Ping = {}

--- @class Ping.Target
--- @field x integer
--- @field y integer
--- @field type Ping.Type
--- @field tile string?
--- @field entityID Entity.ID?
--- @field entityType Entity.Type?
--- @field overlay Entity.Type?
--- @field reveal boolean?
--- @field runeID Entity.ID?
--- @field playerID Player.ID?
--- @field multiple boolean? Allows multiple pings to exist for the same player
--- @field silent boolean?
--- @field remote boolean?
--- @field time number?
--- @field visible boolean?
--- @field timedOut boolean?
--- @field refreshCount integer?

Ping.Context = {
	CURSOR = 1,
	NEARBY = 2,
	REFRESH = 3,
}

Ping.Sound = {
	NEUTRAL = 0,
	--- Same as NEUTRAL for now
	REWARD = 1,
	DANGER = 2,
}

Ping.Type = {
	GENERIC = 1,
	TILE = 2,
	GOLD = 3,
	ALLY = 4,
	TRAP_NEUTRAL = 5,
	OBJECT = 6,
	TRAVEL_RUNE_EXIT = 7,
	GOLD_DANGER = 8,
	REWARD = 9,
	DANGER = 10,
	NPC = 11,
	CONTAINER = 12,
	TRANSACTION_PANEL = 13,
	ENEMY = 14,
	ENEMY_CONTAINER = 15,
	ITEM = 16,
	EXIT_LOCKED = 17,
	EXIT = 18,
	MINIBOSS = 19,
	WALL_CRACKED = 20,
	TRAVEL_RUNE = 21,
}

--- @param pingType1? Ping.Type
--- @param pingType2? Ping.Type
--- @return boolean
function Ping.compareTypes(pingType1, pingType2) end

--- @return Ping.Target[]
function Ping.getActivePings() end

function Ping.getDuration() end

function Ping.isCooldownActive() end

--- @param target Ping.Target
function Ping.createLocal(target) end

--- @param target Ping.Target
function Ping.send(target) end

function Ping.checkTile(x, y, playerID, context) end

function Ping.perform(x, y, playerID) end

function Ping.performNearby(playerID) end

return Ping
