--- @meta

local Camera = {}

Camera.Mode = {
	FIXED = 1,
	NecroEdit_Editor = 10,
	TRACK_LOCAL_PLAYER = 2,
	TRACK_ALL_PLAYERS = 3,
	MAP_OVERVIEW = 4,
	REVEALED_MAP_OVERVIEW = 5,
	TRACK_ARENA = 6,
	CryptArena_PVP_LOBBY = 7,
	CryptArena_PVP_VICTORY = 8,
	CryptArena_PVP_SPECTATOR = 9,
}

function Camera.updateVisibleTileRect() end

function Camera.getBaseViewSize() end

function Camera.updateTarget() end

function Camera.adjust(delta) end

function Camera.setModeOverride(override) end

function Camera.getModeOverride() end

function Camera.setClientModeOverride(override) end

function Camera.getClientModeOverride() end

function Camera.getMode() end

function Camera.getViewCenter() end

function Camera.getViewSize() end

function Camera.getViewRect() end

function Camera.getViewScale() end

function Camera.transformRect(rect) end

function Camera.transformPoint(x, y) end

function Camera.snapToTarget() end

function Camera.resetSnapAvailability() end

function Camera.applyRelativeShift(dx, dy) end

function Camera.setLockedWhilePaused(locked) end

function Camera.isLockedWhilePaused() end

function Camera.getVisibleTileRect() end

function Camera.isTileOnScreen(x, y) end

return Camera
