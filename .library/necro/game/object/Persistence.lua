--- @meta

local Persistence = {}

Persistence.Context = {
	NONE = 0,
	LEVEL_TRANSITION = 1,
	BOSS_FIGHT_START = 2,
	BOSS_FIGHT_END = 3,
	LOBBY_GENERATION = 4,
	DESCENT = 5,
	DISAPPEAR_ON_COLLISION = 6,
}

function Persistence.check(entity, context) end

function Persistence.maybeDelete(entity, context) end

function Persistence.deleteAllNonPersistentObjects(context) end

return Persistence
