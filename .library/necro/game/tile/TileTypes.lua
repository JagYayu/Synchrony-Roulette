--- @meta

local TileTypes = {}

--- @return table
function TileTypes.getTileInfo(tileID) end

function TileTypes.lookUpZoneID(tilesetName) end

function TileTypes.getTilesetName(zoneID) end

function TileTypes.getTilesetWallLight(zoneID) end

function TileTypes.getTilesetInfo(zoneID) end

function TileTypes.lookUpTileID(tileName, zoneID) end

function TileTypes.lookUpTileIDByXML(xmlID, zoneID) end

function TileTypes.getCrackedTileID(tileID) end

function TileTypes.getMaximumTileID() end

function TileTypes.getTilesets() end

function TileTypes.listTileNames() end

function TileTypes.reloadTileSchema() end

return TileTypes
