--- @meta

local PlatformSteam = {}

function PlatformSteam.isSteamBuild() end

function PlatformSteam.getUserID() end

function PlatformSteam.getUserName() end

function PlatformSteam.isAppTicketAvailable() end

function PlatformSteam.requestAppTicket(data) end

function PlatformSteam.getAppTicket() end

function PlatformSteam.initAuthentication() end

function PlatformSteam.setLobbyMetaData(lobbyID, key, value) end

function PlatformSteam.getLobbyMetaData(lobbyID, key) end

function PlatformSteam.setLobbyVisibility(lobbyID, visibility) end

function PlatformSteam.queryLobbies(callback, parameters) end

return PlatformSteam
