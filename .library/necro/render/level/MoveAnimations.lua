--- @meta

local MoveAnimations = {}

--- @enum MoveAnimations.Type
MoveAnimations.Type = {
	data = {},
	
	HOP = 1,
	BOUNCE = 2,
	SLIDE = 3,
	QUARTIC = 4,
	BOUNCE_FLAT = 5,
	MULTI_HOP = 6,
	FAST_HOP = 7,
}

--- @param x1 any
--- @param y1 any
--- @param x2 any
--- @param y2 any
--- @param factor any
--- @param bounciness any
--- @param maxHeight any
--- @param exponent any
--- @return number x
--- @return number y
--- @return number z
function MoveAnimations.animateHop(x1, y1, x2, y2, factor, bounciness, maxHeight, exponent) end

function MoveAnimations.play(entity, tweenType, x, y) end

function MoveAnimations.cancel(entity) end

return MoveAnimations
