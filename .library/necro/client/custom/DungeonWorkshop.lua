--- @meta

local DungeonWorkshop = {}

function DungeonWorkshop.isLegacyAPI() end

--- @param dungeonName string
--- @return table?
function DungeonWorkshop.readMetadata(dungeonName) end

function DungeonWorkshop.writeMetadata(dungeonName, metadata) end

function DungeonWorkshop.setMetadataValue(dungeonName, key, value) end

function DungeonWorkshop.setMetadataValues(dungeonName, values) end

function DungeonWorkshop.getMetadataValue(dungeonName, key) end

function DungeonWorkshop.migrateWorkshopMetadata(dungeonName, metadata) end

function DungeonWorkshop.openUploadMenu(dungeonName) end

function DungeonWorkshop.getPreviewPath(dungeonName) end

function DungeonWorkshop.takeScreenshot(dungeonName, override) end

function DungeonWorkshop.upload(dungeonName, changelog) end

function DungeonWorkshop.getActiveUploads() end

function DungeonWorkshop.isAvailable() end

return DungeonWorkshop
