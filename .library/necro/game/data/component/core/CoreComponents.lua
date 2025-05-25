--- @meta

local CoreComponents = {}

--- Core component common to all spawned entities.
--- Trying to spawn an entity type that doesn’t have this component is an error.
--- Any spawned entity can be safely assumed to have `gameObject`.
--- Some entity types do not have `gameObject`: those can only be used as prototypes (spells works this way).
--- @class Component.gameObject
--- @field tangible boolean # `= true` Whether this entity is currently present in the world. While false, `position` fields are meaningless. Protected field! Do not modify directly, use `Tangibility.setTangible` or `Tangibility.update` instead.
--- @field active boolean # `= true` Whether this entity is acting this turn. For players, this is set when inputting an action. For other entities, this is copied from a player, usually the nearest one.
--- @field persist boolean # `= false` Whether this entity can persist across levels. If false, this entity will be deleted on level change. Legacy field! It is now recommended to use an `objectCheckPersistence` handler instead.
--- @field despawned boolean # `= false` Whether this entity is pending deletion. If true, this entity will be deleted for real at end of turn.

--- Indicates that this entity is automatically persistent and does not get cleaned up at level transitions.
--- This can still be overridden by mods via the `event.objectCheckPersistence` event.
--- @class Component.persistent

--- For internal use. It is not recommended for modded entities to use this component.
--- @class Component.objectMapInsertAtStart

--- Sets the display name of this entity. Most user-visible text mentioning it
--- (kill message, editor, etc) will use this name.
--- @class Component.friendlyName
--- @field name localizedString # `= nil, "name"` 

--- Tracks an RNG state specific to this entity, independent from other entities and global RNG channels.
--- This makes it possible to use this entity as the `channel` argument to functions in the RNG module.
--- @class Component.random
--- @field state1 integer # `= 0` Internal state used by the RNG. There’s normally no reason to modify this directly.
--- @field state2 integer # `= 0` 
--- @field state3 integer # `= 0` 

--- Marks this entity for immediate deletion (checked twice per turn).
--- This is used by the `Tombstone` system entity.
--- @class Component.autoDespawn

--- Marks this entity for deletion after a given number of turns.
--- @class Component.despawnCountdown
--- @field remainingTurns integer # `= 0` Number of turns until this entity is deleted (0 = at end of this turn).

--- For internal use. Mods should not add or remove this component from any entity.
--- @class Component.eventCache
--- @field key string # `= ""` 

--- Marks this entity as a variant of another entity type.
--- @class Component.variant
--- @field base string # `= ""` 

--- @class Entity
--- @field gameObject Component.gameObject
--- @field persistent Component.persistent
--- @field objectMapInsertAtStart Component.objectMapInsertAtStart
--- @field friendlyName Component.friendlyName
--- @field random Component.random
--- @field autoDespawn Component.autoDespawn
--- @field despawnCountdown Component.despawnCountdown
--- @field eventCache Component.eventCache
--- @field variant Component.variant

return CoreComponents
