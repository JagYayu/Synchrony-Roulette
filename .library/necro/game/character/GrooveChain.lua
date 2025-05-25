--- @meta

local GrooveChain = {}

GrooveChain.Type = {
	--- Groove chain lost due to idling (can be suppressed by "idle", "action" or "full" groove chain immunity)
	IDLE = -5,
	--- Groove chain lost due to a failed action (can be suppressed by "fail", "action", or "full" groove chain immunity)
	FAIL = -4,
	--- Groove chain lost due to an invalid action (can be suppressed by "action" or "full" groove chain immunity)
	ACTION = -3,
	--- Groove chain lost due to falling down a trapdoor (can be suppressed by "full" groove chain immunity)
	TRAPDOOR = -2,
	--- Groove chain lost due to incoming damage (can be suppressed by "full" groove chain immunity)
	DAMAGE = -1,
	--- Groove chain did not change, but the coin multiplier needs to be updated
	UPDATE = 0,
	--- Groove chain increased due to a kill or a flower hit
	INCREASE = 1,
	--- Groove chain maximized due to a shrine of rhythm or ballet shoes
	MAXIMIZE = 2,
}

function GrooveChain.update(entity) end

function GrooveChain.increase(entity) end

function GrooveChain.maximize(entity) end

--- Drops the entity's groove chain, resetting the multiplier to 1 and kill chain to 0.
function GrooveChain.drop(entity, eventType) end

function GrooveChain.getMultiplier(entity) end

function GrooveChain.getCoinMultiplier(entity) end

function GrooveChain.isActive(entity) end

function GrooveChain.isMaximized(entity) end

return GrooveChain
