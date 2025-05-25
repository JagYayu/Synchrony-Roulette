--- @meta

local Platform = {}

Platform.LobbyDistanceLimit = {
	CLOSE = 0,
	MEDIUM = 1,
	FAR = 2,
	WORLDWIDE = 3,
}

function Platform.isAvailable() end

function Platform.isSteamAvailable() end

function Platform.isSteamBuild() end

function Platform.isSteamDeck() end

function Platform.isGalaxyAvailable() end

function Platform.isGalaxyBuild() end

function Platform.isMultiplayerAvailable() end

function Platform.getLanguage() end

function Platform.getLaunchCommandLine() end

function Platform.getUserName(userID) end

function Platform.getUserID() end

function Platform.isFriend(userID) end

function Platform.listFriends() end

function Platform.addFriend(userID) end

function Platform.openProfile(userID) end

function Platform.getAvatar(userID, targetFramebuffer) end

function Platform.inviteFriendToLobby(userID, lobbyID) end

function Platform.openLobbyInvitationOverlay(lobbyID) end

function Platform.openStorePage(appID) end

function Platform.getNativeSocketType() end

function Platform.setLobbyJoinable(lobbyID, joinable) end

function Platform.setLobbyMetaData(lobbyID, key, value) end

function Platform.getLobbyMetaData(lobbyID, key) end

function Platform.setLobbyVisibility(lobbyID, visibility) end

function Platform.updatePingLocation() end

function Platform.getLocalPingLocation() end

function Platform.getPingEstimateTo(location) end

function Platform.isCloudEnabled() end

function Platform.getCloudFileTimestamp(filename) end

function Platform.readFileFromCloud(filename) end

function Platform.writeFileToCloud(filename, data, async) end

function Platform.deleteFileFromCloud(filename) end

function Platform.existsInCloud(filename) end

function Platform.isAppTicketAvailable() end

function Platform.requestAppTicket(data) end

function Platform.getAppTicket() end

return Platform
