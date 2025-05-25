--- @meta

local ServerPlayerList = {}

--- @class PlayerAttributeMetaData
--- @field public user boolean If true, the player attribute's value can be freely set by the player
--- @field public private boolean If true, the player attribute's value is not synchronized to other clients
--- @field public silent boolean If true, this attribute does not broadcast changes when set

function ServerPlayerList.disconnectPlayer(playerID, message) end

function ServerPlayerList.cleanUpDisconnectedPlayers() end

function ServerPlayerList.isValidPlayerID(playerID) end

function ServerPlayerList.setAttribute(playerID, key, value) end

function ServerPlayerList.setAttributeSilent(playerID, key, value) end

function ServerPlayerList.getAttribute(playerID, key) end

function ServerPlayerList.isAttributeUserSettable(key) end

function ServerPlayerList.isConnected(playerID) end

function ServerPlayerList.isLoggedIn(playerID) end

function ServerPlayerList.isHost(playerID) end

function ServerPlayerList.getName(playerID) end

function ServerPlayerList.getClientID(playerID) end

function ServerPlayerList.getRoomID(playerID) end

function ServerPlayerList.isNetworkParticipant(playerID) end

function ServerPlayerList.getLatency(playerID) end

function ServerPlayerList.changePlayerID(oldPlayerID, newPlayerID) end

function ServerPlayerList.isFastForwardActive(playerID) end

function ServerPlayerList.kick(playerID, message) end

function ServerPlayerList.ban(playerID, message) end

function ServerPlayerList.isBanned(rejoinToken) end

function ServerPlayerList.unban(banID) end

function ServerPlayerList.unbanAll() end

function ServerPlayerList.lookUpPlayerByClientID(clientID) end

function ServerPlayerList.lookUpPlayerByName(name) end

function ServerPlayerList.lookUpPlayerByRejoinToken(rejoinToken) end

function ServerPlayerList.allPlayers() end

function ServerPlayerList.allPlayersIncludeDisconnected() end

function ServerPlayerList.allPlayersExcept(exceptPlayerID) end

function ServerPlayerList.allDisconnectedPlayers() end

function ServerPlayerList.getPlayerCount() end

function ServerPlayerList.isOccupyingSlot(playerID) end

function ServerPlayerList.getConnectedPlayerCount() end

function ServerPlayerList.setMaximumPlayerCount(maxPlayers) end

function ServerPlayerList.getMaximumPlayerCount() end

function ServerPlayerList.getNextPlayerID() end

function ServerPlayerList.createPlayerEntry(playerID) end

return ServerPlayerList
