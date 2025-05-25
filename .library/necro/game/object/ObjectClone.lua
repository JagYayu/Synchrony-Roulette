--- @meta

local ObjectClone = {}

--- @class ObjectClone.Args
--- @field source Entity|Entity.ID
--- @field attributes Entity?
--- @field parent Entity?

function ObjectClone.registerFieldReset(component, field) end

function ObjectClone.registerTopLevelFieldReset(component, field) end

--- Clones an entity. This is a low-level function - use `object.clone()` instead.
--- @param args ObjectClone.Args
--- @return Entity
function ObjectClone.perform(args) end

return ObjectClone
