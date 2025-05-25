--- @meta

local CameraTarget = {}

CameraTarget.BossLockMode = {
	NEVER = 1,
	SINGLE_PLAYER = 2,
	ALWAYS = 3,
}

CameraTarget.Mode = {
	FIXED = 1,
	TRACK_LOCAL_PLAYER = 2,
	TRACK_ALL_PLAYERS = 3,
	MAP_OVERVIEW = 4,
	REVEALED_MAP_OVERVIEW = 5,
	TRACK_ARENA = 6,
	NecroEdit_Editor = 10,
	CryptArena_PVP_LOBBY = 7,
	CryptArena_PVP_VICTORY = 8,
	CryptArena_PVP_SPECTATOR = 9,
}

function CameraTarget.rectangleCentered(cx, cy, w, h) end

function CameraTarget.rectangleWithSizeAtLeast(x, y, w, h, minWidth, minHeight) end

function CameraTarget.rectangleUnion(x1, y1, w1, h1, x2, y2, w2, h2) end

function CameraTarget.rectangleCenteredOnPlayers(players, minWidth, minHeight, splitFactor) end

function CameraTarget.rectangleOfSegment(segmentID) end

function CameraTarget.rectangleMapOverview() end

function CameraTarget.registerMode(name, targetRectFunc, targetPlayersFunc) end

return CameraTarget
