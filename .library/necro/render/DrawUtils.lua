--- @meta

local DrawUtils = {}

--- Crops the specified visual primitive to an absolute minimum X-position.
--- @param visual VertexBuffer.DrawArgs The visual primitive to be cropped
--- @param cropPosX number Absolute position above which to crop the sprite
--- @return VertexBuffer.DrawArgs
function DrawUtils.cropLeft(visual, cropPosX) end

--- Crops the specified visual primitive to an absolute maximum X-position.
--- @param visual VertexBuffer.DrawArgs The visual primitive to be cropped
--- @param cropPosX number Absolute position below which to crop the sprite
--- @return VertexBuffer.DrawArgs|nil visual The input visual, or nil if the object is invisible after cropping
function DrawUtils.cropRight(visual, cropPosX) end

--- Crops the specified visual primitive to an absolute minimum Y-position.
--- @param visual VertexBuffer.DrawArgs The visual primitive to be cropped
--- @param cropPosY number Absolute position above which to crop the sprite
--- @return VertexBuffer.DrawArgs
function DrawUtils.cropTop(visual, cropPosY) end

--- Crops the specified visual primitive to an absolute maximum Y-position.
--- @param visual VertexBuffer.DrawArgs The visual primitive to be cropped
--- @param cropPosY number Absolute position below which to crop the sprite
--- @return VertexBuffer.DrawArgs|nil visual The input visual, or nil if the object is invisible after cropping
function DrawUtils.cropBottom(visual, cropPosY) end

function DrawUtils.cropHorizontal(visual, leftX, rightX) end

function DrawUtils.cropVertical(visual, topY, bottomY) end

function DrawUtils.cropRect(visual, rect) end

return DrawUtils
