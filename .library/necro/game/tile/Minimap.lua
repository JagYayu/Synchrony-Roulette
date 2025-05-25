--- @meta

local Minimap = {}

function Minimap.mapSegment(segmentID) end

function Minimap.unmapSegment(segmentID) end

function Minimap.isSegmentMapped(segmentID) end

function Minimap.setSingleMappedSegment(segmentID) end

function Minimap.isAnyMappedSegmentVisible() end

function Minimap.getFramebuffer() end

function Minimap.getSize() end

function Minimap.getRect() end

function Minimap.clearBuffers() end

return Minimap
