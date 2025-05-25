--- @meta

local ModWizard = {}

function ModWizard.createAssetMod(name) end

function ModWizard.readResource(modName, resourceName) end

function ModWizard.writeResource(modName, resourceName, data) end

function ModWizard.hasResource(modName, resourceName) end

function ModWizard.removeResource(modName, resourceName, recursive) end

function ModWizard.createDirectory(modName, resourceName, recursive) end

function ModWizard.generate(modName, resourceList, overwrite) end

return ModWizard
