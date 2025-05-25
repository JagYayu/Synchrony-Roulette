--- @meta

local PositionComponents = {}

--- Tracks this entity’s position in the world.
--- @class Component.position
--- @field x integer # `= 0` Horizontal position of this entity (- = left, + = right). Protected field! Do not modify directly, use `Move.absolute` instead.
--- @field y integer # `= 0` Vertical position of this entity (- = up, + = down). Protected field! Do not modify directly, use `Move.absolute` instead.

--- This entity’s "previous" position, for some definition of "previous".
--- Updated when this entity moves, but also for some special actions.
--- This is used by enemy AIs, and may not be the best fit for any other purpose.
--- @class Component.previousPosition
--- @field x integer # `= 0` 
--- @field y integer # `= 0` 

--- Causes all special actions to reset this entity's previousPosition.
--- When this is absent, only IDLE resets previousPosition.
--- @class Component.previousPositionResetOnSpecialAction

--- Updated at the start of each turn (or when an entity spawns).
--- Mitigates rollback artifacts when performing distance checks for teleports.
--- @class Component.turnStartPosition
--- @field x integer # `= 0` 
--- @field y integer # `= 0` 

--- Position where this entity spawned.
--- @class Component.homePosition
--- @field x integer # `= 0` 
--- @field y integer # `= 0` 

--- Dimensions of the "room" where this entity spawned.
--- @class Component.homeArea
--- @field minX integer # `= 0` 
--- @field minY integer # `= 0` 
--- @field maxX integer # `= 0` 
--- @field maxY integer # `= 0` 

--- @class Entity
--- @field position Component.position
--- @field previousPosition Component.previousPosition
--- @field previousPositionResetOnSpecialAction Component.previousPositionResetOnSpecialAction
--- @field turnStartPosition Component.turnStartPosition
--- @field homePosition Component.homePosition
--- @field homeArea Component.homeArea

return PositionComponents
