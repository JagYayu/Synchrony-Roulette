--- @meta

local VisualExtent = {}

function VisualExtent.getOrigin(entity) end

function VisualExtent.getTileCenter(entity) end

--- @return table
function VisualExtent.getRect(entity) end

function VisualExtent.getRectIncludeZ(entity) end

function VisualExtent.getPosition(entity, alignX, alignY, alignZ) end

function VisualExtent.getZOrder(entity) end

return VisualExtent
