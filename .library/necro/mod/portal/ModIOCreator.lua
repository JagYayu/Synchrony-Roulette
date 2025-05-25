--- @meta

local ModIOCreator = {}

--- Maps Steam Workshop item visibility states to mod.io visibility codes
ModIOCreator.Visibility = {
	PUBLIC = 0,
	PRIVATE = 2,
}

function ModIOCreator.isLegacyAPI() end

--- @param modName string
--- @return table?
function ModIOCreator.readMetadata(modName) end

function ModIOCreator.writeMetadata(modName, metadata) end

function ModIOCreator.setMetadataValue(modName, key, value) end

function ModIOCreator.setMetadataValues(modName, values) end

function ModIOCreator.getMetadataValue(modName, key) end

function ModIOCreator.openUploadMenu(modName) end

function ModIOCreator.isOwnedByOtherPlayer(modName) end

function ModIOCreator.upload(modName, changelog) end

function ModIOCreator.getActiveUploads() end

return ModIOCreator
