--- @meta

local RichPresence = {}

--- @class RichPresence.Activity
--- @field playerCount integer
--- @field playerLimit integer
--- @field startTimestamp integer
--- @field endTimestamp integer
--- @field inGame boolean
--- @field spectating boolean
--- @field privacy RichPresence.Privacy
--- @field sessionID string
--- @field matchID string
--- @field connectString string
--- @field connectSpectatorString string
--- @field statusMessage string
--- @field detailMessage string
--- @field largeImage string
--- @field largeText string
--- @field smallImage string
--- @field smallText string

RichPresence.EventType = {
	NONE = 0,
	CONNECT = 1,
	JOIN_REQUEST = 2,
	INVITATION = 3,
}

RichPresence.Privacy = {
	PRIVATE = 0,
	FRIENDS_ONLY = 1,
	PUBLIC = 2,
}

function RichPresence.isAvailable() end

--- @param playerCount? integer
function RichPresence.setPlayerCount(playerCount) end

--- @param playerLimit? integer
function RichPresence.setPlayerLimit(playerLimit) end

--- @param startTimestamp? integer
function RichPresence.setStartTimestamp(startTimestamp) end

--- @param endTimestamp? integer
function RichPresence.setEndTimestamp(endTimestamp) end

--- @param inGame? boolean
function RichPresence.setInGame(inGame) end

--- @param spectating? boolean
function RichPresence.setSpectating(spectating) end

--- @param privacy? RichPresence.Privacy
function RichPresence.setPrivacy(privacy) end

--- @param sessionID? string
function RichPresence.setSessionID(sessionID) end

--- @param matchID? string
function RichPresence.setMatchID(matchID) end

--- @param connectString? string
function RichPresence.setConnectString(connectString) end

--- @param connectSpectatorString? string
function RichPresence.setConnectSpectatorString(connectSpectatorString) end

--- @param statusMessage? string
function RichPresence.setStatusMessage(statusMessage) end

--- @param detailMessage? string
function RichPresence.setDetailMessage(detailMessage) end

--- @param largeImage? string
function RichPresence.setLargeImage(largeImage) end

--- @param largeText? string
function RichPresence.setLargeText(largeText) end

--- @param smallImage? string
function RichPresence.setSmallImage(smallImage) end

--- @param smallText? string
function RichPresence.setSmallText(smallText) end

function RichPresence.clear() end

function RichPresence.update() end

function RichPresence.pollEvent() end

return RichPresence
