--- @meta

local ServerSnapshot = {}

function ServerSnapshot.sendRequest(playerID, callback, turnID) end

function ServerSnapshot.getCachedSnapshot(roomID) end

function ServerSnapshot.invalidateCachedSnapshot(roomID) end

return ServerSnapshot
