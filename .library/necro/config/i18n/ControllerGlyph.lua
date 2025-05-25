--- @meta

local ControllerGlyph = {}

ControllerGlyph.Size = {
	SMALL = 1,
	MEDIUM = 2,
	COOP_HUD = 3,
}

ControllerGlyph.LegacyStyle = {
	TEXT = 0,
	XBOX = 1,
	PLAYSTATION = 2,
	JOY_CON = 3,
}

function ControllerGlyph.lookUp(bindingID, size) end

function ControllerGlyph.clearCache() end

function ControllerGlyph.isDirectionalPad(bindingID) end

function ControllerGlyph.getControllerModelName(controllerID) end

return ControllerGlyph
