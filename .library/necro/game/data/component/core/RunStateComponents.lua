--- @meta

local RunStateComponents = {}

--- Marks the shopkeeper as dead when this entity dies.
--- This causes future shops to be empty, and the shopkeeper ghost to spawn.
--- @class Component.runStateMarkShopkeeperDeath

--- @class Entity
--- @field runStateMarkShopkeeperDeath Component.runStateMarkShopkeeperDeath

return RunStateComponents
