--- @meta

local Components = {}

Components.field = {
}

Components.constant = {
}

--- Registers a set of components. Accepts a table of component definitions, mapping the component's name to its list of
--- fields.
function Components.register(components) end

function Components.dependency(target) end

--- Used to register dependencies on external components.
function Components.registerDependency(source, target) end

function Components.getComponentDefaults() end

function Components.getLocalizableFields(componentName) end

function Components.field.string(name, default) end

function Components.field.bool(name, default) end

function Components.field.int(name, default) end

function Components.field.float(name, default) end

function Components.field.entityID(name, default) end

function Components.field.table(name, default) end

function Components.field.enum(name, enumeration, default) end

function Components.field.int16(name, default) end

function Components.field.int32(name, default) end

function Components.field.int64(name, default) end

function Components.field.int8(name, default) end

function Components.constant.string(name, default) end

function Components.constant.bool(name, default) end

function Components.constant.int(name, default) end

function Components.constant.float(name, default) end

function Components.constant.table(name, default) end

function Components.constant.enum(name, enumeration, default) end

function Components.constant.int16(name, default) end

function Components.constant.int32(name, default) end

function Components.constant.int64(name, default) end

function Components.constant.int8(name, default) end

function Components.constant.localizedString(name, default, alias) end

return Components
