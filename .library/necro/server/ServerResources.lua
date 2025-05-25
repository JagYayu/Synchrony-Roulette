--- @meta

local ServerResources = {}

function ServerResources.getResource(roomID, resourceID) end

function ServerResources.getResourceData(roomID, resourceID) end

function ServerResources.getOutgoingTransfers(playerID) end

function ServerResources.getIncomingTransfers(playerID) end

function ServerResources.load(roomID, resourceID, resourceName, resourceData) end

return ServerResources
