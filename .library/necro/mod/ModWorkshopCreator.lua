--- @meta

local ModWorkshopCreator = {}

function ModWorkshopCreator.isLegacyAPI() end

--- @param modName string
--- @return table?
function ModWorkshopCreator.readMetadata(modName) end

function ModWorkshopCreator.writeMetadata(modName, metadata) end

function ModWorkshopCreator.setMetadataValue(modName, key, value) end

function ModWorkshopCreator.setMetadataValues(modName, values) end

function ModWorkshopCreator.getMetadataValue(modName, key) end

function ModWorkshopCreator.createNewMod(metadata) end

function ModWorkshopCreator.migrateWorkshopMetadata(modName, metadata) end

function ModWorkshopCreator.openUploadMenu(modName) end

function ModWorkshopCreator.upload(modName, changelog) end

function ModWorkshopCreator.getActiveUploads() end

return ModWorkshopCreator
