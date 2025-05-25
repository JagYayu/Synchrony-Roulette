--- @meta

local MultiInstance = {}

MultiInstance.MessageType = {
	RENDER_WIDGETS = 1,
	KEY_EVENTS = 2,
	CLOSE_MENU = 3,
}

MultiInstance.WidgetVisibility = {
	ON_HOVER = 1,
	MENU_ONLY = 2,
}

function MultiInstance.isMultiWindowSupported() end

function MultiInstance.create(args) end

function MultiInstance.isDuplicate() end

function MultiInstance.isEmbedded() end

function MultiInstance.getParentPlayerID() end

function MultiInstance.getSessionUID() end

return MultiInstance
