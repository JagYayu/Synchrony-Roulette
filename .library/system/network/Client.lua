--- @meta

local Client = {}

function Client.isAvailable() end

function Client.connectUDP(ip, port, identity) end

function Client.connectTCP(ip, port) end

function Client.connectSteam(lobbyID, allowPeering, method) end

function Client.connectGalaxy(lobbyID) end

function Client.pollSteamJoinRequest() end

function Client.pollGalaxyJoinRequest() end

return Client
