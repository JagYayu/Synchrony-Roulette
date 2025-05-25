--- @meta

local Graphics = {}

--- @param buffer VertexBuffer
function Graphics.setBuffer(buffer) end

--- @return VertexBuffer
function Graphics.getBuffer() end

function Graphics.setTransform(matrix) end

function Graphics.getTransform() end

function Graphics.setZOrder(z) end

function Graphics.getZOrder() end

function Graphics.flush() end

function Graphics.drawBox(rect, col) end

function Graphics.drawSprite(imageName, rect, textureRect) end

function Graphics.drawTintedSprite(imageName, rect, textureRect, col) end

function Graphics.drawRotatedSprite(imageName, rect, textureRect, angle, origin) end

function Graphics.drawRotatedBox(rect, col, angle, origin) end

function Graphics.drawRotatedTintedSprite(imageName, rect, textureRect, col, angle, origin) end

function Graphics.drawText(args) end

return Graphics
