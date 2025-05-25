--- @meta

local Entities = {}

--- @alias Entity.ComponentType string

--- @alias Entity.Type string

--- @alias Entity.ID integer

--- @class Entity
--- @field id Entity.ID
--- @field name Entity.Type

--- @class ECS.TypeMetaData
--- @field components Entity.ComponentType[] List of component names for this entity type
--- @field mutableComponents Entity.ComponentType[] List of component names for this entity type with at least one mutable field
--- @field setters table Maps component name => field name => setter function
--- @field fieldIDs table Maps component name => field name => field ID
--- @field layoutComponents Entity.ComponentType[] Maps field ID => component name
--- @field layoutFields string[] Maps field ID => field name
--- @field initialValues string Serialized table containing all default values for this entity type

--- @alias EntitySnapshot string

function Entities.hasAllComponents(entity, components) end

--- Returns true if a type exists with the given name, false otherwise
--- @param typeName Entity.Type
--- @return boolean
function Entities.isValidEntityType(typeName) end

--- Returns true if a component exists with the given name, false otherwise
--- @param componentName Entity.ComponentType
--- @return boolean
function Entities.isValidComponent(componentName) end

--- Lists all registered component names
--- @return Entity.ComponentType
function Entities.listComponentNames() end

--- Lists all registered component names
--- @param componentName Entity.ComponentType
--- @param fieldName string
--- @return any
function Entities.getComponentDefault(componentName, fieldName) end

--- Accepts an entity or type name, returns a type name (like entity.name, but also safe on strings)
--- @param entity Entity|Entity.Type
--- @return Entity.Type
function Entities.getEntityTypeName(entity) end

--- Deprecated. Use `ecs.getEntityByID(entityID).name`.
--- @deprecated
--- @param entityID integer
--- @return Entity.Type
function Entities.getEntityTypeID(entityID) end

--- Deprecated. Does nothing.
--- @param typeName Entity.Type
--- @return Entity.Type
function Entities.resolveEntityType(typeName) end

--- Returns true if there is an entity with the given ID, false otherwise.
--- @param entityID number
--- @return boolean
function Entities.entityExists(entityID) end

--- Returns the entity with the given ID.
--- For compatibility, this also accepts entities, returning them unchanged.
--- @param entityID integer|Entity|nil
--- @return Entity?
function Entities.getEntityByID(entityID) end

--- Returns a list of entities of the given type.
function Entities.getEntitiesByType(typeName) end

--- Returns the prototype (an immutable entity with id 0) for the given type.
--- @param typeName Entity.Type
--- @return Entity
function Entities.getEntityPrototype(typeName) end

--- Returns a list of types that have all of the given components.
--- @param componentList Entity.ComponentType[]
--- @return Entity.Type[]
function Entities.getEntityTypesWithComponents(componentList) end

--- Iterates over types that have all of the given components.
--- @param componentList Entity.ComponentType[]
--- @return fun(table: table, i?: integer):integer, Entity.Type
--- @return table
--- @return integer i
function Entities.typesWithComponents(componentList) end

--- Iterates over entities that have all of the given components.
--- @param componentNames Entity.ComponentType[]
--- @return fun(state: table):Entity
--- @return table
function Entities.entitiesWithComponents(componentNames) end

--- Iterates over prototypes of types that have all of the given components.
--- @param componentList Entity.ComponentType[]
--- @return fun(table: table, i?: integer):integer, Entity
--- @return table
--- @return integer i
function Entities.prototypesWithComponents(componentList) end

--- Creates and initializes an entity of the given type. Returns the newly created entity.
--- @param typeName Entity.Type
--- @return Entity
function Entities.spawn(typeName) end

--- Creates a duplicate of the specified entity and returns a wrapper to it.
--- @param entityID Entity.ID
--- @return Entity
function Entities.duplicate(entityID) end

--- Deletes the entity with the given ID.
--- @param entityID integer
function Entities.despawn(entityID) end

--- Deletes all entities, and fully reset ECS state.
function Entities.resetAll() end

--- Converts the given entity to the given type.
--- Components are added and removed to match the target type. For components that exist on both the source and target
--- types, mutable fields keep their current values, while constant fields are reset to the target type’s default.
--- @param entity Entity
--- @param targetTypeName Entity.Type
--- @return Entity
function Entities.convert(entity, targetTypeName) end

--- Returns true if the given type has a component with the given name.
--- Returns nil for invalid types, and false for valid types that don’t have the component.
--- @param typeName Entity.Type
--- @param componentName Entity.ComponentType
--- @return boolean
function Entities.typeHasComponent(typeName, componentName) end

function Entities.defragmentEntityIDs() end

--- Creates a snapshot of the whole entity system's current state
--- @return EntitySnapshot
function Entities.serializeState() end

--- Restores a snapshot of the whole entity system's current state
--- @param serializedState EntitySnapshot
function Entities.deserializeState(serializedState) end

function Entities.makeSchemaIndependentSnapshot(serializedState) end

return Entities
