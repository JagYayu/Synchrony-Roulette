--- @meta

local Server = {}

Server.LobbyVisibility = {
	PRIVATE = 0,
	FRIENDS_ONLY = 1,
	PUBLIC = 2,
	INVISIBLE = 3,
}

function Server.isAvailable() end

function Server.hostUDP(port) end

function Server.hostTCPLocal() end

function Server.hostSteam(visibility, slotCount) end

function Server.hostGalaxy(visibility, slotCount) end

function Server.hostMultiPlatform(args) end

return Server
