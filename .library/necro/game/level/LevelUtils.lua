--- @meta

local LevelUtils = {}

--- @class LevelUtils.TileIDMap
--- @field mapID fun(tileID:integer):integer
--- @field getMappingTable fun():Level.TileMapping

--- Creates a new abstract level from the specified options
--- @param options? LevelGenerator.Options.Procedural
--- @param initialValues? Level.Data
--- @return Level.Data
function LevelUtils.new(options, initialValues) end

--- Creates a level tile ID map, which maps session-dependent tile IDs to a level-specific, dense range of IDs.
--- @return LevelUtils.TileIDMap
function LevelUtils.newTileIDMap() end

--- Converts a level tile ID map into a flat table of session-specific tile IDs which can be indexed directly when
--- loading a level.
function LevelUtils.getReverseTileIDMap(mappingTable) end

--- Looks up a single entry in a tile ID mapping table
function LevelUtils.lookUpTileIDMapEntry(mappingTable, index) end

--- Creates an entity for use in the intermediate level format
function LevelUtils.makeEntity(entityType, x, y) end

--- Sets an attribute for a specific component/field for the specified entity. If a "default" value is supplied, the
--- attribute will not be set if its value equals the default value.
function LevelUtils.addEntityAttribute(entity, component, field, value, default) end

--- Adds an item entity to the specified holder entity's inventory
function LevelUtils.addEntityToInventory(holderEntity, itemEntity) end

--- Assigns a purchase price to the specified entity
function LevelUtils.setEntityPriceTag(entity, bloodCost, saleCost) end

return LevelUtils
