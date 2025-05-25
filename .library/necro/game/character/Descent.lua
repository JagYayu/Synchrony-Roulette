--- @meta

local Descent = {}

Descent.Type = {
	NONE = 0,
	STAIRS = 1,
	TRAPDOOR = 2,
	RHYTHM = 3,
	CRACKED_FLOOR = 4,
	CryptArena_PVP_VICTORY = 5,
}

function Descent.perform(entity, descentType) end

--- Places a descended entity back on the level
function Descent.ascend(entity) end

--- Deprecated, use `descent.perform(entity, descent.Type.TRAPDOOR)` instead
function Descent.drop(entity) end

function Descent.isExitRequirementVisuallyMet() end

function Descent.isExitRequirementLogicallyMet() end

function Descent.completeLevel() end

function Descent.exitIfRequirementIsMet() end

function Descent.levelFade() end

function Descent.getLevelTransitionDelay() end

return Descent
