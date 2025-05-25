--- @meta

local LineOfSight = {}

--- Checks if a clear line of sight exists between the specified two points (with an optional number of tiles to skip
--- relative to the starting position), testing for the presence of walls or solid entities.
--- @param x1 integer X-coordinate of the starting point
--- @param y1 integer Y-coordinate of the starting point
--- @param x2 integer X-coordinate of the ending point
--- @param y2 integer Y-coordinate of the ending point
--- @param mask? Collision.Type Bitmask to use for the collision check (defaults to `Collision.Group.SOLID`)
--- @param skipTiles? integer Number of tiles to skip for the line-of-sight check
--- @return integer? x X-position of the collision (or nil if no collision occurred)
--- @return integer? y Y-position of the collision (or nil if no collision occurred)
function LineOfSight.check(x1, y1, x2, y2, mask, skipTiles) end

--- Checks if a clear line of sight exists between the two specified entities.
--- @param entity Entity
--- @param target Entity
--- @param mask? Collision.Type Bitmask to use for the collision check (defaults to `Collision.Type.WALL`)
--- @return boolean true if `entity` can see `target`.
function LineOfSight.canSee(entity, target, mask) end

return LineOfSight
