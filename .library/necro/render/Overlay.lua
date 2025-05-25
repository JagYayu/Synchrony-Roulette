--- @meta

local Overlay = {}

--- @class Overlay.Attributes
--- @field color? Color Overlay color (defaults to `color.BLACK`)
--- @field delay? number Number of seconds to wait before showing the overlay
--- @field fadeIn? number Duration of the overlay's fade-in in seconds
--- @field fadeOut? number Duration of the overlay's fade-out in seconds
--- @field sustain? number Number of seconds the delay should stay active at full intensity
--- @field waitForLevel? boolean If true, keeps the delay visible until the level ends
--- @field layer? number Z-order to display the overlay with

Overlay.Layer = {
	BELOW_HUD = -1000,
	DEFAULT = 1000,
	HIGH = 1500,
	LEVEL_FADE = 2000,
}

--- @param attributes Overlay.Attributes
function Overlay.add(attributes) end

function Overlay.screenFlash(flashColor, milliseconds, entity) end

function Overlay.levelFade(color, delay, fadeIn) end

function Overlay.removeAll() end

function Overlay.clearLevelFade() end

return Overlay
