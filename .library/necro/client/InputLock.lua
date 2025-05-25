--- @meta

local InputLock = {}

function InputLock.isActive(playerID) end

function InputLock.hasQueuedInputs(playerID) end

function InputLock.isValidPeerToPeerTurnID(turnID) end

return InputLock
