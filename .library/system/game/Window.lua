--- @meta

local Window = {}

function Window.isFullscreen() end

function Window.setFullscreen(fullscreen, width, height) end

function Window.getDesktopMode() end

function Window.listVideoModes() end

function Window.getSize() end

function Window.getWidth() end

function Window.getHeight() end

function Window.resize(width, height) end

function Window.setWidth(width) end

function Window.setHeight(height) end

function Window.isFocused() end

function Window.isMinimized() end

function Window.isMaximized() end

function Window.setMaximized(maximized) end

function Window.setFramerateLimit(limit) end

function Window.getFramerateLimit() end

function Window.setTitle(title) end

function Window.setAspectRatio(ratio) end

function Window.getDefaultViewWidth() end

function Window.getDefaultViewHeight() end

function Window.getDefaultViewSize() end

function Window.setViewSize(width, height, roundCoords) end

function Window.getViewSize() end

function Window.getViewWidth() end

function Window.getViewHeight() end

function Window.getViewRect() end

function Window.getViewMatrix() end

function Window.getClipboard() end

function Window.setClipboard(text) end

function Window.setCursorVisible(visible) end

return Window
