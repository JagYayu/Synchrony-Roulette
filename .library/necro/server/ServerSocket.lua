--- @meta

local ServerSocket = {}

function ServerSocket.host(serverType, serverImplementation) end

function ServerSocket.close() end

function ServerSocket.addLocalClient() end

function ServerSocket.disconnect(playerID) end

function ServerSocket.sendUnreliable(messageType, message, target) end

function ServerSocket.sendReliable(messageType, message, target, channel) end

function ServerSocket.sendTransfer(messageType, message, target, channel, name) end

function ServerSocket.cancelTransfer(playerID, transferID) end

function ServerSocket.flush(playerID) end

function ServerSocket.getExternalUsernameForPlayer(playerID) end

function ServerSocket.getPlayerIdentity(playerID) end

function ServerSocket.getPlatformID(playerID) end

function ServerSocket.getLatency(playerID) end

function ServerSocket.getOutgoingTransfers(playerID) end

function ServerSocket.getIncomingTransfers(playerID) end

function ServerSocket.getType() end

function ServerSocket.getSocket() end

function ServerSocket.isLocalPlayer(playerID) end

return ServerSocket
