--- @meta

local MaterialColorFilter = {}

--- @class MaterialColorFilter.AuxLayer
--- @field channel integer Color to multiply for computing this auxiliary layer's weight

--- @class MaterialColorFilter.Palette
--- @field materialColor integer|integer[] Primary color/gradient to replace gray pixels in the main layer with
--- @field handleColor integer Secondary material color to replace brown pixels in the main layer with
--- @field gripColor integer Tertiary color to replace blue pixels in the main layer with
--- @field tipColor integer Auxiliary color to replace cyan pixels in the main layer with
--- @field guardColor integer Auxiliary color to replace magenta pixels in the main layer with
--- @field detailColor integer Detailing color to replace green pixels in the main layer with
--- @field shineColor integer Overlay color for reflections. Applies to a specific color channel from the shine layer
--- @field shineChannel integer Per-channel color weights for the shine layer, resulting in different shine patterns
--- @field glowColor integer Color to apply to all visible glow pixels
--- @field glowThreshold number Minimum brightness value required for glow pixels to show up
--- @field auxLayers MaterialColorFilter.AuxLayer[] Additional layers for various details
--- @field silhouette integer|nil Color to apply to all pixels of the main and invariant layers

--- @class MaterialColorFilter.Args : MaterialColorFilter.Palette
--- @field image string Image to use as a template

--- @param args MaterialColorFilter.Args
--- @return string
function MaterialColorFilter.getPath(args) end

--- @param args MaterialColorFilter.Args[]
--- @return string
function MaterialColorFilter.getPathMultiFrame(args) end

return MaterialColorFilter
