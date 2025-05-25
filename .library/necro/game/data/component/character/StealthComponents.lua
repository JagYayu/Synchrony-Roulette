--- @meta

local StealthComponents = {}

--- Allows this entity to be stealthy. By default, it’s stealthy while inside a wall.
--- @class Component.stealth
--- @field collisionMask Collision.Type # `= collision.Type.WALL` 
--- @field active boolean # `= false` 
--- @field radius number # `= 0` 

--- Specific to the ninja mask.
--- @class Component.itemStealth
--- @field radius number # `= 0` 

--- Prevents this entity from acting while its target is stealthy.
--- @class Component.idleOnTargetStealth

--- @class Entity
--- @field stealth Component.stealth
--- @field itemStealth Component.itemStealth
--- @field idleOnTargetStealth Component.idleOnTargetStealth

return StealthComponents
