--- @meta

local ServerInputLock = {}

function ServerInputLock.isPlayerActionPermitted(playerID, turnID) end

function ServerInputLock.setPlayerInputLockState(playerID, locked) end

return ServerInputLock
