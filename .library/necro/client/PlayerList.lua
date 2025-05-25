--- @meta

local PlayerList = {}

function PlayerList.getPlayerList() end

function PlayerList.getCrossRoomPlayerList() end

function PlayerList.verifyAllPlayers(func) end

function PlayerList.isValidPlayerID(playerID) end

function PlayerList.isConnected(playerID) end

function PlayerList.getName(playerID) end

function PlayerList.getLatency(playerID) end

function PlayerList.getRoomID(playerID) end

function PlayerList.getCharacter(playerID) end

function PlayerList.isReady(playerID) end

function PlayerList.setAttribute(key, value) end

function PlayerList.getAttribute(playerID, key) end

function PlayerList.allPlayersReady() end

function PlayerList.getLocalPlayerID() end

function PlayerList.isHost(playerID) end

function PlayerList.getHostPlayerID() end

function PlayerList.lookUpByPeerID(peerID) end

return PlayerList
