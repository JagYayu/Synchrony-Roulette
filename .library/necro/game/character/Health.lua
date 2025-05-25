--- @meta

local Health = {}

Health.Heart = {
	--- Red player health: 1 heart = 2 health
	RED_EMPTY = 1,
	RED_HALF = 2,
	RED_FULL = 3,
	--- Cursed player health: 1 heart = 2 health
	CURSED_EMPTY = 4,
	CURSED_HALF = 5,
	CURSED_FULL = 6,
	--- Enemy health: 1 heart = 1 health
	ENEMY_EMPTY = 7,
	ENEMY_FULL = 8,
	--- Broken (half) heart containers
	BROKEN_RED_EMPTY = 9,
	BROKEN_RED_FULL = 10,
	BROKEN_CURSED_EMPTY = 12,
	BROKEN_CURSED_FULL = 11,
	--- Shattered heart containers
	SHATTERED_EMPTY = 13,
	Sync_POSSESSED_FULL = 14,
	Sync_POSSESSED_EMPTY = 15,
}

function Health.heal(parameters) end

function Health.increaseMaxHealth(entity, amount, healer) end

function Health.getCurrentHealth(entity) end

function Health.getMaxHealth(entity) end

function Health.addCursed(entity, cursedHealth) end

function Health.curseHealth(entity, cursedHealth) end

function Health.uncurseHealth(entity, amount) end

function Health.incrementRegenerationKillCounter(entity, amount) end

function Health.getRemainingRegenerationKills(entity) end

--- @return any[]
function Health.getHearts(entity) end

return Health
