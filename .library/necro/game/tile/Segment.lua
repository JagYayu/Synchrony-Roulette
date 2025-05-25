--- @meta

local Segment = {}

function Segment.getSegmentIDAt(x, y) end

function Segment.getBounds(segmentID) end

function Segment.getRect(segmentID) end

function Segment.contains(segmentID, x, y) end

function Segment.getSegmentBoundsAt(x, y) end

--- Checks if two points share the same segment, and returns the ID of that segment.
--- Never returns the NONE segment (which contains the whole level, including all other segments).
--- @param x1 integer First point's X coordinate in tile space
--- @param y1 integer First point's Y coordinate in tile space
--- @param x2 integer Second point's X coordinate in tile space
--- @param y2 integer Second point's Y coordinate in tile space
--- @return integer? segmentID ID of the segment containing both points, or nil if no such segment exists
function Segment.getShared(x1, y1, x2, y2) end

function Segment.add(x, y, width, height) end

function Segment.setBounds(segmentID, x, y, width, height) end

--- Expands the specified segment to ensure in contains the specified rectangle
function Segment.expand(segmentID, rect) end

function Segment.remove(segmentID) end

function Segment.clearAll() end

function Segment.getCount() end

return Segment
