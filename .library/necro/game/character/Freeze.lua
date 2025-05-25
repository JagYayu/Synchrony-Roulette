--- @meta

local Freeze = {}

Freeze.Type = {
	ICE = 1,
	STONE = 2,
	INVISIBLE = 3,
}

function Freeze.isFrozen(entity) end

function Freeze.inflict(entity, turns, type) end

function Freeze.thaw(entity) end

return Freeze
