--- @meta

local SegmentVisibility = {}

SegmentVisibility.Mode = {
	EVERYONE = 1,
	MAIN_FLOOR = 2,
	SECRET_SHOP = 3,
	CryptArena_PVP_VICTORY = 4,
}

function SegmentVisibility.getCurrentMode() end

function SegmentVisibility.isVisible(entityOrSegmentID) end

function SegmentVisibility.isVisibleAt(x, y) end

function SegmentVisibility.update() end

return SegmentVisibility
