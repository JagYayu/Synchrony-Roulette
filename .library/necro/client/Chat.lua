--- @meta

local Chat = {}

--- @class Chat.Message
--- @field text string
--- @field sound? Chat.Sound
--- @field name? string
--- @field color? Color
--- @field nameColor? Color
--- @field playerID? Player.ID

Chat.Prompt = {
	CHAT = 1,
	MENU_SEARCH = 2,
	NecroEdit_EDITOR_FILTER = 3,
	DEBUG_CONSOLE = 4,
}

Chat.VisibilityMode = {
	ALWAYS = 1,
	IN_GAME_ONLY = 2,
	LOBBY_ONLY = 3,
	NEVER = 4,
	SINGLE_PLAYER = 5,
}

Chat.SoundMode = {
	ALWAYS = 1,
	FOREGROUND = 2,
	BACKGROUND = 3,
	NEVER = 4,
}

Chat.Sound = {
	MESSAGE_REMOTE = 2,
	MESSAGE_LOCAL = 1,
	JOIN_LOCAL = 3,
	JOIN_REMOTE = 4,
	LEAVE_LOCAL = 5,
	LEAVE_REMOTE = 6,
}

function Chat.clear() end

function Chat.print(message, color) end

function Chat.addMessage(message) end

function Chat.send(message) end

function Chat.isPromptTypeActive(promptType) end

function Chat.openChatbox(promptText, promptType) end

function Chat.closeChatbox() end

function Chat.isChatboxOpen() end

function Chat.isBlockingInput() end

function Chat.getChatboxText() end

function Chat.setMuted(playerID, muted) end

function Chat.isMuted(playerID) end

function Chat.isVisible() end

return Chat
