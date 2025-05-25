--- @meta

local OutlineFilter = {}

OutlineFilter.Mode = {
	BASIC = 1,
	WITH_EYES = 2,
	AUTO_COLOR = 3,
}

function OutlineFilter.getEntityImage(entity, texture, mode) end

function OutlineFilter.padVisual(visual, frameOffsetX, frameOffsetY) end

--- @return table
function OutlineFilter.getEntityVisual(entity, visual, mode) end

return OutlineFilter
