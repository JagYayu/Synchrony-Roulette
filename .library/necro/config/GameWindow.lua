--- @meta

local GameWindow = {}

GameWindow.ScaleMode = {
	LETTERBOX = 1,
	STRETCH = 2,
	FIXED = 3,
	AUTO = 4,
}

function GameWindow.getEffectiveScale() end

function GameWindow.getFramerateLimit() end

function GameWindow.roundX(x) end

function GameWindow.roundY(y) end

--- "Wakes up" the mouse cursor, preventing it from auto-hiding
function GameWindow.preventMouseCursorAutoHide() end

function GameWindow.accelerateMouseCursorAutoHide(amount) end

function GameWindow.forceMouseCursorAutoHide() end

function GameWindow.isMouseCursorVisible() end

function GameWindow.isFocused() end

function GameWindow.applyChanges() end

return GameWindow
