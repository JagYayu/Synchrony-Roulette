--- @meta

local Migration = {}

Migration.Level = {
	SILENT = 0,
	DEBUG = 1,
	INFO = 2,
	WARNING = 3,
	ERROR = 4,
}

function Migration.apply(entityType) end

function Migration.register(version, level, migrations) end

function Migration.custom(componentName, func) end

function Migration.removeComponent(componentName) end

function Migration.renameFields(componentName, fieldNameMapping) end

function Migration.renameComponent(oldComponentName, newComponentName, fieldNameMapping) end

function Migration.addComponent(oldComponentName, newComponentName) end

--- migration.splitComponent("oldComponent", {
---     renamedField = "newFieldName",
---     movedField = { component = "newComponent" },
---     movedAndRenamedField = { component = "newComponent", field = "newField" },
---     deletedField = false,
--- })
function Migration.splitComponent(componentName, fieldMapping, remove) end

function Migration.defaultValue(componentName, fieldName, defaultValue) end

return Migration
