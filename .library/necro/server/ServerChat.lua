--- @meta

local ServerChat = {}

ServerChat.BroadcastMode = {
	NONE = 0,
	SAME_ROOM = 1,
	ALL_ROOMS = 2,
}

--- @param message Chat.Message
--- @param target Player.ID|Player.ID[]|nil
function ServerChat.send(message, target) end

--- @deprecated
function ServerChat.sendMessage(name, message, color, target, sound) end

function ServerChat.sendSystemMessage(message, target, sound) end

return ServerChat
