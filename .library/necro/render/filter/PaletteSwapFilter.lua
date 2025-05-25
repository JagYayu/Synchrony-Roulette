--- @meta

local PaletteSwapFilter = {}

PaletteSwapFilter.AlphaMode = {
	--- Override the input pixel's alpha value with the replacement color's alpha value
	OVERRIDE = 1,
	--- Multiply the input pixel's alpha value with the replacement color's alpha value
	BLEND = 2,
	--- Preserve the alpha value of all pixels in the image
	PRESERVE = 3,
}

--- Returns the path to a modified image in which each pixel with a specific color has been replaced with another color
--- @param image string Path to the image to perform the color substitution on
--- @param inputColor? Color The color to find within the image. Defaults to white
--- @param outputColor? Color The color to replaced the input color with. Defaults to transparent
--- @return string outputImage Path to a virtual copy of image with the specified color having been substituted
function PaletteSwapFilter.replaceSingleColor(image, inputColor, outputColor) end

--- Returns the path to a modified image to which a number of color substitutions has been applied
--- @param image string Path to the image to perform the color substitution on
--- @param colorTable table<Color,Color> Key-value map for color replacements
--- @param fallback? Color Fallback color to use in case a pixel's color is not in the lookup table
--- @param alphaMode? PaletteSwap.AlphaMode Specifies how to handle pixel transparency. Defaults to `OVERRIDE`
--- @return string outputImage Path to a virtual copy of image with the specified colors having been substituted
function PaletteSwapFilter.replaceByColorTable(image, colorTable, fallback, alphaMode) end

return PaletteSwapFilter
