--- @meta

local Character = {}

Character.Priority = {
	--- Priority value for bombs
	BOMB = 2000000000,
	--- Additive priority modifier for reflected projectiles
	PROJECTILE_REFLECTED = 100000000,
	--- Additive priority modifier for charmed pets
	PET = 100000000,
}

function Character.isTileAttackable(entity, x, y) end

function Character.isTileBlocked(entity, x, y) end

function Character.hopInPlace(entity) end

function Character.isAlive(entity) end

function Character.handleActionResult(entity, parameters) end

function Character.setDynamicSprite(entity, params) end

function Character.setCloneTarget(clone, target) end

function Character.processActionQueue(actionQueue, callback) end

function Character.performAction(entity, act, args) end

return Character
