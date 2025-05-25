--- @meta

local VertexBuffer = {}

--- @class VertexBuffer

--- @class VertexBuffer.DrawArgs
--- @field rect number[] Rectangle to draw the visual primitive at (x, y, width, height)
--- @field z number Depth position of the visual primitive to draw. Defaults to 0
--- @field texture string File name of the image to use as a texture. Defaults to no texture (white)
--- @field texRect number[] Sub-rectangle for the texture, in pixels (x, y, width, height). Defaults to full image
--- @field color Color RGBA color of the visual primitive. Defaults to white
--- @field angle number Angle to rotate the visual primitive by (in radians). Defaults to 0 (no rotation)
--- @field origin number[] Origin to rotate the visual primitive around (x, y). Defaults to (0, 0)

--- @class VertexBuffer.DrawTextArgs
--- @field text string
--- @field font string
--- @field x number
--- @field y number
--- @field z number
--- @field alignX number
--- @field alignY number
--- @field size number
--- @field opacity number
--- @field fillColor integer
--- @field outlineColor integer
--- @field outlineThickness number
--- @field gradient boolean
--- @field shadowColor integer
--- @field spacingX number
--- @field spacingY number
--- @field maxWidth number
--- @field maxHeight number
--- @field clip boolean
--- @field wordWrap boolean
--- @field maxLines integer
--- @field fixedWidth boolean

--- @return VertexBuffer
function VertexBuffer.new() end

return VertexBuffer
