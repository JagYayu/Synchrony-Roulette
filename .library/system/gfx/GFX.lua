--- @meta

local GFX = {}

--- @return table
function GFX.getImageGeometry(imageName) end

function GFX.isAvailable() end

function GFX.clear() end

function GFX.unloadImage(imageName) end

function GFX.unloadAllImages() end

function GFX.isValidImage(imageName) end

--- @return integer
--- @return integer
function GFX.getImageSize(imageName) end

function GFX.getImageWidth(imageName) end

function GFX.getImageHeight(imageName) end

function GFX.preloadImage(imageName) end

function GFX.getAvailablePreloadCapacity() end

--- Draws the current intermediate frame to the screen
function GFX.displayCurrentFrame() end

--- Returns the time elapsed since the last frame was drawn to the screen (in seconds)
function GFX.getTimeSinceLastDisplay() end

return GFX
