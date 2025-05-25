--- @meta

local ObjectRenderer = {}

--- Deprecated
function ObjectRenderer.drawObjectInScreenspace(entity, rect, opacity) end

--- Deprecated
function ObjectRenderer.getSpriteRect(entity) end

--- Returns the visual representation of the passed entity
--- @param entity Entity
--- @return VertexBuffer.DrawArgs
function ObjectRenderer.getObjectVisual(entity) end

--- Deprecated
function ObjectRenderer.drawObject(entity) end

--- Returns the visual representation of the passed entity
--- @param entity Entity
--- @return VertexBuffer.DrawArgs
function ObjectRenderer.getShadowVisual(entity) end

--- Deprecated
function ObjectRenderer.drawShadow(entity) end

--- @param item Entity
--- @param container Entity
--- @return VertexBuffer.DrawArgs
function ObjectRenderer.getContentVisual(item, container) end

return ObjectRenderer
