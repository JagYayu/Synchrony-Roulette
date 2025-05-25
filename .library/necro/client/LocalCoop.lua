--- @meta

local LocalCoop = {}

--- @return Player.ID[]
function LocalCoop.getLocalPlayerIDs() end

function LocalCoop.getLocalPlayerCount() end

function LocalCoop.isActive() end

function LocalCoop.getLocalIndex(playerID) end

function LocalCoop.isLocal(playerID) end

function LocalCoop.addPlayer(callback) end

function LocalCoop.removePlayer(playerID, callback) end

function LocalCoop.removeAllPlayers() end

function LocalCoop.setPlayerAttribute(playerID, key, value) end

function LocalCoop.isCoopPlayer(playerID) end

function LocalCoop.getParentPlayerID(playerID) end

function LocalCoop.getCoopPlayerNumber(playerID) end

function LocalCoop.getControllerID(playerID) end

function LocalCoop.makeInitialCharacterMap() end

return LocalCoop
