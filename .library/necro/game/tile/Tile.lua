--- @meta

local Tile = {}

--- @alias Tile.ID number
--- @alias Tile.Info table

--- @class Tile.Coord
--- @field [1] integer X position of the tile
--- @field [2] integer Y position of the tile

--- Attempts to reduce the coordinates of the specified tile into a single number.
--- Returns nil if the coordinates fall out of level range.
--- @param x integer
--- @param y integer
--- @return integer i
function Tile.reduceCoordinates(x, y) end

--- Yields the X and Y position represented by the specified reduced coordinate value.
--- @param i integer
--- @return integer x
--- @return integer y
function Tile.unwrapCoordinates(i) end

--- Returns the level boundaries (x, y, width, height)
function Tile.getLevelBounds() end

function Tile.getLevelPosition() end

function Tile.getLevelSize() end

function Tile.isInBounds(x, y) end

--- Sets the level boundaries. Optionally clears the level.
function Tile.setLevelBounds(x, y, width, height, clearLevel) end

--- Returns the tile at the specified position.
function Tile.get(x, y) end

--- Returns the tile info at the specified position.
--- @return Tile.Info
function Tile.getInfo(x, y) end

--- Checks if the specified tile is not empty.
function Tile.exists(x, y) end

--- Places a tile at the specified position.
function Tile.set(x, y, id) end

--- Changes the type of the tile at the specified position without changing its zone.
function Tile.setType(x, y, type) end

--- Checks if the tile at the specified position is solid.
function Tile.isSolid(x, y) end

--- Clears the level, removing all tiles and setting the map size to 0x0
function Tile.clearLevel() end

--- Returns the tile at the specified numeric index.
function Tile.getAtIndex(index) end

return Tile
