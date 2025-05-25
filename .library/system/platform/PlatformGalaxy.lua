--- @meta

local PlatformGalaxy = {}

function PlatformGalaxy.isGalaxyBuild() end

function PlatformGalaxy.getUserID() end

function PlatformGalaxy.signInGalaxy() end

function PlatformGalaxy.signInSteam(authTicket, username) end

function PlatformGalaxy.signInToken(token) end

function PlatformGalaxy.isSignedIn() end

function PlatformGalaxy.hasSignInFailed() end

function PlatformGalaxy.getSessionToken() end

function PlatformGalaxy.setLobbyMetaData(lobbyID, key, value) end

function PlatformGalaxy.getLobbyMetaData(lobbyID, key) end

function PlatformGalaxy.setLobbyVisibility(lobbyID, visibility) end

function PlatformGalaxy.queryLobbies(callback, parameters) end

return PlatformGalaxy
