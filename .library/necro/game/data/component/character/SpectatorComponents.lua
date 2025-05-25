--- @meta

local SpectatorComponents = {}

--- @class Component.spectator
--- @field active boolean # `= false` 

--- @class Component.spectatorIntangible

--- @class Component.spectatorMoveToVacantTileOnJoin
--- @field mask Collision.Type # `= collision.Group.PLAYER_PLACEMENT` 
--- @field moveType integer # `= 0` 

--- @class Entity
--- @field spectator Component.spectator
--- @field spectatorIntangible Component.spectatorIntangible
--- @field spectatorMoveToVacantTileOnJoin Component.spectatorMoveToVacantTileOnJoin

return SpectatorComponents
