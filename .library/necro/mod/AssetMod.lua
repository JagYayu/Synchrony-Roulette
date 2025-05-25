--- @meta

local AssetMod = {}

AssetMod.Source = {
	LOCAL = 1,
	DOWNLOADED = 2,
	WORKSHOP = 3,
}

function AssetMod.list(source) end

function AssetMod.load(modName) end

function AssetMod.unload(modName) end

function AssetMod.reload(modName) end

function AssetMod.isLoaded(modName) end

function AssetMod.isActivated(modName) end

function AssetMod.listLoaded() end

function AssetMod.refresh() end

function AssetMod.listFiles(modName, subdirectory, listFlags) end

function AssetMod.openDirectory(modName) end

function AssetMod.isDirectoryOpenable(modName) end

function AssetMod.getImage(modName, imageType) end

function AssetMod.getWarning(modName) end

function AssetMod.openWorkshop() end

function AssetMod.isWorkshopAvailable() end

function AssetMod.openHomepage(modName) end

function AssetMod.getMetadata(modName, key) end

function AssetMod.setPriority(modName, priority) end

function AssetMod.getPriority(modName) end

function AssetMod.resolve(modName) end

function AssetMod.getPath(modName) end

function AssetMod.applyChanges(silent) end

function AssetMod.disableTemporarily() end

function AssetMod.initialize() end

return AssetMod
