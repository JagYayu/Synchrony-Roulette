--- @meta

local Object = {}

function Object.processPendingConversions() end

function Object.isTangible(entity) end

--- @param objectType string
--- @param x integer
--- @param y integer
--- @param attributes? Entity
--- @return Entity
function Object.spawn(objectType, x, y, attributes) end

function Object.spawnAttachment(attachmentType, parent) end

--- Kills the entity specified in the parameter table. Does nothing if the entity is already dead or does not exist.
--- @param args Event.ObjectDeath Death event parameters
function Object.die(args) end

function Object.kill(entity, killer, killerName, damageType, silent) end

function Object.delete(entity) end

function Object.firstWithComponents(componentNames) end

--- Duplicates an entity, creating another copy of it with exactly the same attributes
--- @param entity Entity|Entity.ID The entity to duplicate
--- @param attributes? Entity Table of attributes to merge into the newly cloned entity
--- @return Entity
function Object.clone(entity, attributes) end

--- Queues an entity for deletion on the next `event.frame` call.
--- @param entity? Entity Entity to be deleted. Does nothing on already-deleted entities.
function Object.lazyDelete(entity) end

--- Converts an entity to another type.
--- @param entity Entity Entity to be converted.
--- @param targetType string The new type for the entity.
--- @param preserve table? Set of names of components that should not be reset.
function Object.convert(entity, targetType, preserve) end

--- This is **not safe** to use while any event is running on the converted entity.
--- Use Object.convert instead if that is the case or if you’re not sure.
function Object.convertImmediately(entity, targetType, preserve) end

function Object.resetFieldOnConvert(component, field) end

function Object.moveToNearbyVacantTile(entity, mask, moveType, offsets) end

function Object.updateAttachments() end

return Object
