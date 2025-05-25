--- @meta

local Theme = {}

Theme.Color = {
	HIGHLIGHT = -9096,
	STATUS_OK = -8847496,
	STATUS_WARNING = -8856356,
	STATUS_ERROR = -8881921,
	SELECTION = -17579,
}

function Theme.getLocalChatColor() end

function Theme.getRemoteChatColor() end

function Theme.getLocalNameColor() end

function Theme.getRemoteNameColor() end

function Theme.getSystemMessageColor() end

function Theme.getChatOutlineColor() end

function Theme.getErrorNameColor() end

function Theme.getErrorMessageColor() end

function Theme.getMenuHeaderColor(selected, disabled) end

function Theme.getMenuItemColor(selected, disabled) end

function Theme.getLocalPlayerColor(playerIndex) end

return Theme
