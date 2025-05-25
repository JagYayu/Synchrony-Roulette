--- @meta

local Area = {}

--- Maximum relative distance from (x, y) to the area edges.
--- 0 for the area edges, < 0 inside the area, > 0 outside the area.
function Area.distance(rect, x, y) end

--- Returns true if `visitor` is within `homeOwner`’s homeArea, false otherwise.
--- Excludes the area’s edge by default; use threshold = 1 to include the edges.
function Area.isHome(homeOwner, visitor, threshold) end

function Area.iterateBorder(rect, outset) end

return Area
