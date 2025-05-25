--- @meta

local EffectOverlay = {}

--- @class EffectOverlay.ShrinkingFlashArgs
--- @field entity Entity Entity using which to render the shrinking flash effect (required)
--- @field factor number Normalized animation factor between 0 and 1
--- @field visual? VertexBuffer.DrawArgs Visual primitive to draw the shrinking flash with (defaults to entity visual)
--- @field buffer? VertexBuffer Vertex buffer to render to (defaults to `render.Buffer.OBJECT`)
--- @field scale? number Scale factor for the maximum size of the flashing effect (defaults to 4)

--- Draws a flashing effect that rapidly shrinks down to the size of an entity
--- @param args EffectOverlay.ShrinkingFlashArgs
function EffectOverlay.drawShrinkingFlash(args) end

return EffectOverlay
