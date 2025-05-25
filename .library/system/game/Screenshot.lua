--- @meta

local Screenshot = {}

function Screenshot.take(buffer, filename, rect, size) end

function Screenshot.render(renderFunc, filename, width, height, backgroundColor) end

function Screenshot.processPendingRenders() end

function Screenshot.resizeImageInMemory(image, minWidth, minHeight, maxWidth, maxHeight) end

return Screenshot
