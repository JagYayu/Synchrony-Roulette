--- @meta

local FloorVisuals = {}

--- @return string
function FloorVisuals.getTexture(tileID, x, y) end

function FloorVisuals.getColor(brightness) end

--- @return table?
function FloorVisuals.getFloorSprite(tileID, x, y, beat, visible, grooveChain) end

return FloorVisuals
