--- @meta

local DebugOverlay = {}

DebugOverlay.Overlay = {
	OUTPUT = 1,
	LAG_LOG = 2,
	PERF_TICK = 3,
	PERF_TURN = 4,
	ROLLBACK = 5,
	NETWORK = 6,
	HUD = 7,
	LIGHT = 8,
	Sprites = 9,
}

function DebugOverlay.register(name, func, dev) end

function DebugOverlay.setOverlayEnabled(enabled) end

function DebugOverlay.isOverlayEnabled() end

function DebugOverlay.getOverlayCount() end

function DebugOverlay.setOverlayMode(mode) end

function DebugOverlay.getOverlayMode() end

function DebugOverlay.handleOverlayMouseInput(x, y, press) end

function DebugOverlay.print(str) end

return DebugOverlay
