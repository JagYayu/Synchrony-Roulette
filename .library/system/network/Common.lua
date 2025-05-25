--- @meta

local Common = {}

Common.EventType = {
	NONE = 0,
	CONNECTED = 1,
	DISCONNECTED = 2,
	MESSAGE_RECEIVED = 3,
	ERROR = 4,
}

Common.DisconnectType = {
	NONE = 0,
	LOCAL_DISCONNECT = 1,
	REMOTE_DISCONNECT = 2,
	TIMEOUT = 3,
	ERROR = 4,
}

Common.MessageMode = {
	UNRELIABLE_UNORDERED = 0,
	UNRELIABLE_ORDERED = 1,
	RELIABLE_UNORDERED = 2,
	RELIABLE_ORDERED = 3,
	BROADCAST = 4,
}

Common.LobbyConnectionMethod = {
	LEGACY = 1,
	RELAY = 2,
	LOOPBACK = 4,
	RELAY_MULTI = 8,
}

Common.SocketType = {
	LOCAL = 0,
	UDP = 1,
	STEAM = 2,
	STEAM_MULTI = 3,
	GALAXY = 4,
	TCP = 5,
}

function Common.isAvailable() end

return Common
