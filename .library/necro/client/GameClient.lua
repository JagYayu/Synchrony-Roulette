--- @meta

local GameClient = {}

function GameClient.setUsername(name) end

function GameClient.getUsername() end

function GameClient.isAvailable() end

function GameClient.connectUDP(ip, port) end

function GameClient.connectSteam(lobbyID) end

function GameClient.connectSteamMultiJoin(steamID) end

function GameClient.connectGalaxy(lobbyID) end

function GameClient.connectLocal() end

function GameClient.reconnect() end

function GameClient.disconnect(args) end

function GameClient.isConnected() end

function GameClient.isConnecting() end

function GameClient.isLoggedIn() end

function GameClient.setAutoJoinPending(pending) end

function GameClient.isAutoJoinPending() end

function GameClient.getLatency() end

function GameClient.getSocketType() end

function GameClient.getConnectionParameters() end

function GameClient.sendUnreliable(messageType, message) end

function GameClient.sendReliable(messageType, message, channel) end

function GameClient.broadcast(messageType, message) end

function GameClient.isBroadcastEnabled() end

function GameClient.sendTransfer(messageType, message, channel, name) end

function GameClient.flush() end

function GameClient.cancelTransfer(transferID) end

function GameClient.getOutgoingTransfers() end

function GameClient.getIncomingTransfers() end

function GameClient.openInvitationOverlay() end

function GameClient.getSteamLobbyID() end

function GameClient.getSteamLobbyOwnerID() end

function GameClient.getLobbyGalaxyID() end

function GameClient.getLobbyPlatformID() end

function GameClient.getConnectionID() end

function GameClient.isInvitationOverlayEnabled() end

function GameClient.getDebugInfo(verbosity) end

--- Returns the timestamp (relative to `timer.getGlobalTime()`) at which the message being processed by
--- `event.clientMessage` was received, or the timestamp of the most recently received message.
function GameClient.getMessageTimestamp() end

function GameClient.getSessionSecret() end

return GameClient
