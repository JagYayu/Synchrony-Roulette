--- @meta

local VisionAccel = {}

VisionAccel.Map = {
	VIS = 1,
	FOV = 2,
	REVEAL = 3,
	LIGHT = 4,
}

VisionAccel.Attribute = {
	BIT_OFFSET_LIGHT = 0,
	BIT_COUNT_LIGHT = 24,
	BIT_OFFSET_OPAQUE = 26,
	BIT_OFFSET_VALID = 27,
	BIT_OFFSET_SHADOW = 28,
	BIT_OFFSET_PERSPECTIVE_REVEAL = 29,
	BIT_OFFSET_PERSPECTIVE_OCCLUDE = 30,
	BIT_OFFSET_PERSPECTIVE_ILLUMINATE = 31,
	LIGHT_TILE_SIZE = 256,
	LIGHT_REVEAL_THRESHOLD = 7650,
	LIGHT_LEVEL_MAX = 25500,
	BRIGHTNESS_REVEALED = 91,
	BRIGHTNESS_SHADOWED = 66,
	BRIGHTNESS_MAX = 255,
}

function VisionAccel.setMap(mapType, map, width, height) end

function VisionAccel.setClippingRectangle(x, y, width, height) end

function VisionAccel.fovClear(mask) end

function VisionAccel.fovAddRaycast(mask, x, y) end

function VisionAccel.fovAddCircle(mask, x, y, radius) end

function VisionAccel.fovReveal() end

function VisionAccel.shadowClear() end

function VisionAccel.shadowInvert() end

function VisionAccel.shadowAddCircle(x, y, radius) end

function VisionAccel.perspectiveClear() end

function VisionAccel.perspectiveFill() end

function VisionAccel.perspectiveAddCircle(x, y, radius) end

function VisionAccel.lightApplyRadial(x, y, innerRadius, outerRadius, intensity) end

function VisionAccel.updateLightMap(factor) end

return VisionAccel
