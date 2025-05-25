--- @meta

local UI = {}

--- @class UI.Font
--- @field size number

--- @type table<string,UI.Font>
UI.Font = {
	SYSTEM = {
  characterSize = 16,
  fillColor = -1,
  font = "gfx/font.png;ttf/Silver.ttf",
  gradient = true,
  outlineThickness = 1,
  shadowColor = -2147483648,
  size = 16
},
	SMALL = {
  characterSize = 19,
  fillColor = -1,
  font = "gfx/necro/font/necrosans-6.png;ttf/Silver.ttf",
  outlineThickness = 1,
  shadowColor = -16777216,
  size = 6,
  szc = 0.5,
  uppercase = true
},
	MONO_SMALL = {
  characterSize = 19,
  fillColor = -1,
  font = "gfx/necro/font/necrosans-6.png;gfx/necro/font/necrosans-6_MONO.png;ttf/Silver.ttf",
  outlineThickness = 1,
  shadowColor = -16777216,
  size = 6,
  szc = 0.5,
  uppercase = true
},
	DIGITS = {
  characterSize = 6,
  fillColor = -1,
  font = "gfx/necro/font/necrosans-digits.png",
  outlineThickness = 1,
  shadowColor = -16777216,
  size = 6
},
	MEDIUM = {
  characterSize = 19,
  fillColor = -1,
  font = "gfx/necro/font/necrosans-12.png;ttf/Silver.ttf",
  outlineThickness = 1,
  shadowColor = -16777216,
  size = 12,
  spacingX = 1,
  spacingY = 1,
  szc = 0.5,
  uppercase = true
},
	LARGE = {
  characterSize = 19,
  fillColor = -1,
  font = "gfx/necro/font/necrosans-18.png;ttf/Silver.ttf",
  outlineThickness = 1,
  shadowColor = -16777216,
  size = 18,
  spacingX = 2,
  spacingY = 1,
  szc = 0.5,
  uppercase = true
},
	VECTOR = {
  characterSize = 19,
  fillColor = -1,
  font = "ttf/Silver.ttf;ttf/Silver.ttf",
  outlineColor = -16777216,
  outlineThickness = 6,
  size = 19,
  spacingX = 1,
  spacingY = 1,
  szc = 0.5
},
}

--- Deprecated alias for TextFormat.lua
UI.Symbol = {
	QUANTITY = "\16",
	EIGHTH_NOTES = "\17",
}

function UI.isCJKFontActive() end

function UI.isCJKPixelFontActive() end

function UI.drawText(args) end

function UI.measureText(args) end

function UI.setUppercaseEnabled(uppercase) end

function UI.isUppercaseEnabled() end

function UI.upper(text) end

function UI.drawMenuFrame(args) end

function UI.setScaleFactor(factor) end

function UI.getScaleFactor() end

function UI.getRhythmicBounce(exponent, bounceTime, bounceScale) end

return UI
