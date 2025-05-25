--- @meta

local Targeting = {}

--- @class Targeting.AlignedHostileArgs
--- @field entity? Entity Entity to find a nearby aligned target for (must be specified if x and y are absent)
--- @field x? integer X-coordinate of the position to start the search from (must be specified if entity is absent)
--- @field y? integer Y-coordinate of the position to start the search from (must be specified if entity is absent)
--- @field team? Team.Id TeamID to check for hostiles of (must be specified if entity is absent)
--- @field maxDistance? integer Maximum distance to the target (defaults to 1000)
--- @field directions? table<Action.Direction,boolean> Set of directions to check (defaults to entity AI or orthogonals)
--- @field mask? Collision.Type Collision bitmask for the line of sight check (defaults to AI collision)
--- @field checkPreviousPosition? boolean If true, additionally checks for alignment with the target's previous position
--- @field target? Entity Specifies the preferred target to check for, before falling back to other hostile entities
--- @field singleTarget? boolean If set, limits the search to a single target

function Targeting.getCachedPosition(entityID) end

function Targeting.selectNearest(targets, x, y, bias, ignoreSegments) end

function Targeting.squareDistance(entity) end

function Targeting.previousSquareDistance(entity) end

--- @return Entity[]
function Targeting.getEntitiesOnTeam(entityOrTeamID) end

--- @return Entity[]
function Targeting.getHostileEntities(entityOrTeamID) end

function Targeting.getNearestPlayer(x, y, bias) end

function Targeting.getNearestHostileEntity(x, y, entityOrTeamID, bias) end

--- Looks for the nearest aligned targetable hostile entity and returns it
--- @param parameters Targeting.AlignedHostileArgs Parameters specifying how to search for an aligned target
--- @return Entity? target The found target entity
--- @return Action.Direction? direction The direction in which the nearest aligned target was found
function Targeting.getAlignedHostileEntity(parameters) end

function Targeting.setTarget(entity, target) end

--- Makes an entity targetable or untargetable. Any changes made by this function are overridden during gameplay.
--- Prefer using `targeting.updateTargetability()` in combination with `event.objectUpdateTargetability` instead.
--- @param entity Entity Entity to be made targetable/untargetable
--- @param targetable boolean Targetability state to apply to the entity
function Targeting.setTargetable(entity, targetable) end

--- Fires `event.objectUpdateTargetability` for the specified entity and makes the entity targetable/untargetable.
--- @param entity Entity Entity to be made targetable/untargetable
function Targeting.updateTargetability(entity) end

return Targeting
