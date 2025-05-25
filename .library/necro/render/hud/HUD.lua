--- @meta

local HUD = {}

HUD.MirrorMode = {
	NONE = 1,
	HORIZONTAL = 2,
	VERTICAL = 3,
	FULL = 4,
	REFLECTED = 5,
}

HUD.MirrorSlotMode = {
	NONE = 1,
	FULL = 2,
}

function HUD.scaleRectGlobally(rect, scaleX, scaleY) end

--- @return { [1]: number, [2]: number, [3]: number, [4]: number }
function HUD.getSlotRect(args) end

--- Valid argument table keys:
--- image [string]
--- element [string]
--- slot = {x, y}
--- imageRect = {x, y, w, h}
--- rect = {x, y, w, h}
--- buffer [enum render.Buffer]
--- z [float]
function HUD.drawSprite(args) end

--- Valid argument table keys:
--- text [string]
--- element [string]
--- slot = {x, y}
--- rect = {x, y, w, h}
--- font [enum ui.Font]
--- fillColor = {r, g, b, [a]}
--- maxWidth [number]
--- maxHeight [number]
--- [any other keys accepted by ui.drawText]
function HUD.drawText(args) end

function HUD.setSlotCount(elementName, slotsX, slotsY) end

function HUD.setMargins(elementName, left, top, right, bottom) end

function HUD.getSlotCount(elementName) end

function HUD.getScaleFactor() end

function HUD.getLayoutCount() end

function HUD.getLayout(index) end

function HUD.getActiveLayout() end

function HUD.getGlobalLayout() end

function HUD.getLayoutGridSize() end

function HUD.getMirrorMode() end

function HUD.isReflected() end

function HUD.getActiveLayoutIndex() end

return HUD
