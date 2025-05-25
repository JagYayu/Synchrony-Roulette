--- @meta

local TileRenderer = {}

TileRenderer.DiscoFloorMode = {
	OFF = 1,
	SOFT = 2,
	ON = 3,
}

--- @return integer
function TileRenderer.getCurrentBeat() end

--- @return boolean
function TileRenderer.isGrooveChainActive() end

function TileRenderer.getFloorVisual(x, y, tileID, groove, visible, beat, crop) end

function TileRenderer.getWallVisual(x, y, tileID, crop) end

return TileRenderer
