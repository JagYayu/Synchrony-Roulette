--- @meta

local LevelExit = {}

LevelExit.StairLock = {
	INACTIVE = 0,
	SARCOPHAGUS = 1,
	MINIBOSS = 2,
}

function LevelExit.isUnlocked() end

function LevelExit.unlock() end

function LevelExit.unlockIfNeeded() end

--- This function is deprecated.
function LevelExit.completeLevel() end

--- This function is deprecated.
function LevelExit.performExit(entity) end

return LevelExit
