--- @meta

local CustomWeapons = {}

--- @class CustomWeapons.ModifierArgs
--- @field entity table Primary entity for this weapon type. If set to nil, skips generation of this weapon type
--- @field entities table List of all entities to generate for this weapon type
--- @field material CustomWeapons.Material Material data of this weapon type
--- @field shape CustomWeapons.Shape Shape data of this weapon type

--- @class CustomWeapons.Shape
--- @field name string Unique identifier of the weapon shape
--- @field friendlyName string Display name of the weapon shape
--- @field hint string Hint text for the weapon shape (if encountered without a material)
--- @field components table Component table to add to weapons with this shape
--- @field modifier fun(ev:CustomWeapons.ModifierArgs) Called for each weapon type using this shape
--- @field texture string Spritesheet texture for generating images for each weapon type (requires 5 vertical frames)
--- @field framesX integer If specified, subdivides the texture into a number of frames along the X-axis
--- @field paletteOverrides table Special palette to apply for this weapon with specific materials
--- @field excludeMaterials string[] Don't generate weapons for this list of materials with the current shape
--- @field includeMaterials string[] Only generate weapons for this list of materials, excluding any others

--- @class CustomWeapons.Material
--- @field name string Unique identifier of the weapon material
--- @field friendlyName string Display name of the weapon material
--- @field hint string Hint text for weapons with this material (overriding the shape-specific hint)
--- @field components table Component table to add to weapons with this material
--- @field modifier fun(ev:CustomWeapons.ModifierArgs) Called for each weapon type using this material
--- @field palette MaterialColorFilter.Palette Palette (or list of palettes) to apply to weapons with this material
--- @field excludeShapes string[] Don't generate weapons for this list of shapes with the current material
--- @field includeShapes string[] Only generate weapons for this list of shapes, excluding any others

--- @param shape CustomWeapons.Shape
function CustomWeapons.registerShape(shape) end

--- @param material CustomWeapons.Material
function CustomWeapons.registerMaterial(material) end

--- @param name string
--- @return CustomWeapons.Shape?
function CustomWeapons.getShapeData(name) end

--- @param name string
--- @return CustomWeapons.Material?
function CustomWeapons.getMaterialData(name) end

--- @param shape CustomWeapons.Shape
--- @param material CustomWeapons.Material
function CustomWeapons.getTexture(shape, material) end

return CustomWeapons
