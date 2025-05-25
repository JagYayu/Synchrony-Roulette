--- @meta

local Marker = {}

Marker.Type = {
	SPAWN = 1,
	SHOP = 2,
	STAIRS = 3,
	SHOP_CRACKED_WALL = 4,
	--- Unused
	SECRET_CRACKED_WALL = 5,
}

function Marker.lookUpFirst(markerType, defaultX, defaultY) end

function Marker.lookUpMedian(markerType) end

function Marker.lookUpAll(markerType) end

function Marker.setFirst(markerType, x, y) end

return Marker
