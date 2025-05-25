--- @meta

local ChatBadge = {}

ChatBadge.Type = {
	BRACE_YOURSELF_GAMES = 1,
	VORTEX_BUFFER = 2,
}

function ChatBadge.lookUpByPlatformID(platformID) end

function ChatBadge.getOwnBadge() end

function ChatBadge.getBadgeForPlayer(playerID) end

function ChatBadge.getIcon(badgeType, scale) end

function ChatBadge.getColor(badgeType) end

return ChatBadge
