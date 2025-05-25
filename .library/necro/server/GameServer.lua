--- @meta

local GameServer = {}

function GameServer.hostLocal() end

function GameServer.hostUDP(port) end

function GameServer.hostSteam(visibility, lobbyName) end

function GameServer.hostGalaxy(visibility, lobbyName) end

function GameServer.hostMultiPlatform(args) end

function GameServer.isSeamlessHostPossible() end

function GameServer.addLocalClient() end

function GameServer.getSocketType() end

function GameServer.getConnectionParameters() end

function GameServer.getPort() end

function GameServer.close() end

function GameServer.isOpen() end

return GameServer
