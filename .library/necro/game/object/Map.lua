--- @meta

local Map = {}

--- Remove entityID from the map. Does nothing if the entity wasn't there.
function Map.remove(entityID, x, y) end

function Map.move(entityID, x1, y1, x2, y2) end

--- Add entityID to the map. If the entity was already present, it is moved to the end.
function Map.add(entityID, x, y) end

function Map.getAll(x, y) end

function Map.get(x, y) end

--- Returns the first entity on tile (x, y) with the specified component,
--- or nil if no such entity exists.
--- @return Entity?
function Map.firstWithComponent(x, y, component) end

--- Returns true if any entity on tile (x, y) has the specified component, false otherwise
function Map.hasComponent(x, y, component) end

--- Returns a list of entities on tile (x, y) having the specified component
--- @param x integer
--- @param y integer
--- @param component string
--- @return Entity[]
function Map.allWithComponent(x, y, component) end

--- Iterates over entities on tile (x, y) having the specified component
function Map.entitiesWithComponent(x, y, component) end

function Map.reset() end

return Map
