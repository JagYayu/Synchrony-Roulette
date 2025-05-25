--- @meta

local Perspective = {}

--- @class Perspective.Attribute : integer
Perspective.Attribute = {
	--- Boolean: if true, all tiles are visible, as if they were revealed
	TILE_REVEAL_ALL = 1,
	--- Set of strings: tiles with these flags are always visible, as if they were revealed
	TILE_REVEAL_GROUPS = 2,
	--- Set of strings: draws arrows pointing at each tile with the specified flags
	TILE_TARGET_POINTER_GROUPS = 3,
	--- Number: tiles outside of this radius are invisible
	TILE_VISION_RADIUS = 4,
	--- Number: tile brightness change rate per tick
	TILE_BRIGHTNESS_RATE = 5,
	--- Set of strings: tiles with these flags are always fully lit visually
	TILE_ILLUMINATED_GROUPS = 6,
	--- Set of strings: objects with these components are always visible, even if unrevealed
	OBJECT_VISIBILITY_GROUPS = 7,
	--- Set of strings: inventories of entities with these components are visible
	CONTENTS_VISIBILITY_GROUPS = 8,
	--- Set of strings: objects with these components are silhouetted, regardless of visibility and brightness
	OBJECT_SILHOUETTE_GROUPS = 9,
	--- Set of strings: objects with these components are not silhouetted, regardless of visibility and brightness
	OBJECT_UNSILHOUETTE_GROUPS = 10,
	--- Number: objects outside of this radius are invisible
	OBJECT_VISION_RADIUS = 11,
	--- Set of strings: objects with these components are always displayed on the minimap, even if unrevealed
	OBJECT_MINIMAP_GROUPS = 14,
	--- Boolean: if true, shadowed tiles are unshadowed and vice-versa
	SHADOW_INVERT = 15,
	--- Boolean: if true, gold is outlined
	GOLD_OUTLINE = 16,
}

--- Updates an entity's perspective, revealing tiles and objects according to equipped vision-granting items.
--- @param entity? Entity Entity to update the perspective for.
function Perspective.update(entity) end

--- Returns the value of a specific perspective attribute for the locally focused entities.
--- @param attribute Perspective.Attribute Attribute to query
--- @return any value Resulting attribute value
function Perspective.getAttribute(attribute) end

--- For group-based attributes (e.g. `TILE_REVEAL_GROUPS`), converts the set of groups into a flat list and returns it.
--- @param attribute Perspective.Attribute List attribute to query
--- @return string[] value Attribute value list
function Perspective.getListAttribute(attribute) end

--- Checks if the specified entity's components match up with the given group-based attribute.
--- @param entity Entity Entity to match against an attribute
--- @param attribute Perspective.Attribute List attribute to check for a match on
--- @return boolean match `true` if the entity matches, `false` otherwise
function Perspective.isEntityTypeMatchedByAttribute(entity, attribute) end

--- Checks if the specified tile type is revealed by the current perspective attributes
--- @param tileID Tile.ID TileID to match against the `TILE_REVEAL_GROUPS` attribute
--- @return boolean match `true` if the tile type matches, `false` otherwise
function Perspective.isTileTypeRevealed(tileID) end

--- Checks if the specified tile type is illuminated by the current perspective attributes
--- @param tileID Tile.ID TileID to match against the `TILE_ILLUMINATED_GROUPS` attribute
--- @return boolean match `true` if the tile type matches, `false` otherwise
function Perspective.isTileTypeIlluminated(tileID) end

--- Returns the position of the primary perspective-focused entity, or (0, 0) if no entity is focused.
--- @return integer x Horizontal tile position of the primary perspective-focused entity
--- @return integer y Vertical tile position of the primary perspective-focused entity
function Perspective.getTargetPosition() end

return Perspective
