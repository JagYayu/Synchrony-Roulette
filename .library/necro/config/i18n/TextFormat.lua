--- @meta

local TextFormat = {}

TextFormat.Symbol = {
	QUANTITY = "\16",
	EIGHTH_NOTES = "\17",
	DROPDOWN = "\18",
	INFINITY = "\3I0;0;0;0;0;2;",
	CHECKBOX_OFF = "\3I0;15;0;15;14;2;",
	CHECKBOX_ON = "\3I0;0;0;15;14;2;",
	SMALL_CHECKBOX_OFF = "\3I0;15;0;15;14;1;",
	SMALL_CHECKBOX_ON = "\3I0;0;0;15;14;1;",
}

function TextFormat.color(text, col) end

function TextFormat.fade(text, alpha) end

function TextFormat.quantityColor(text, quantity) end

function TextFormat.background(text, bgColor) end

function TextFormat.underline(text) end

function TextFormat.alternateFont(text) end

function TextFormat.monospace(text, width) end

function TextFormat.icon(texture, scale, texRect) end

function TextFormat.highlightSearchQuery(text, query) end

function TextFormat.checkbox(state, scale) end

return TextFormat
