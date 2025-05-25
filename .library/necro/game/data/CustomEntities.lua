--- @meta

local CustomEntities = {}

--- @class CustomEntities.Parameters
--- @field name string
--- @field template table
--- @field components? Entity
--- @field data? table
--- @field preserveMappingComponents? boolean
--- @field modifier? function

CustomEntities.template = {
}

--- @param parameters CustomEntities.Parameters
function CustomEntities.extend(parameters) end

--- Registers a custom entity type with the specified components. Must be called at load time
--- @param definition Entity Base component table, including default field values. Must contain a `name` field
--- @param extras Entity? Optional secondary components table to merge into the first (convenience for entity variants)
--- @return string name Entity type name
function CustomEntities.register(definition, extras) end

function CustomEntities.template.enemy(xmlName, xmlType) end

function CustomEntities.template.item(xmlName) end

function CustomEntities.template.player(xmlID) end

return CustomEntities
