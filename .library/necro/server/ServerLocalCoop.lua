--- @meta

local ServerLocalCoop = {}

function ServerLocalCoop.getParentPlayer(playerID) end

function ServerLocalCoop.getChildPlayers(playerID) end

function ServerLocalCoop.getChildPlayerCount(playerID) end

function ServerLocalCoop.isParentPlayer(playerID) end

function ServerLocalCoop.isChildPlayer(playerID) end

function ServerLocalCoop.isLocalCoopPlayer(playerID) end

function ServerLocalCoop.isParentChildPair(parentPlayerID, childPlayerID) end

function ServerLocalCoop.setMaximumLocalPlayerCount(maxLocalPlayers) end

function ServerLocalCoop.getMaximumLocalPlayerCount() end

function ServerLocalCoop.addPlayer(parentPlayerID) end

function ServerLocalCoop.removePlayer(childPlayerID) end

return ServerLocalCoop
