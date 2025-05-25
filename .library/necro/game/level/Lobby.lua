--- @meta

local Lobby = {}

Lobby.StartPermissions = {
	ANY_PLAYER = 1,
	MAJORITY_VOTE = 2,
	ALL_PLAYERS = 3,
	FIRST_PLAYER = 4,
	HOST_ONLY = 5,
}

function Lobby.open(delayTime, resetPlayers) end

function Lobby.isLobbyLevelEnabled() end

return Lobby
