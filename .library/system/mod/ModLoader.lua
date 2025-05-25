--- @meta

local ModLoader = {}

--- @class ModLoader.Reference
--- Reference to a specific version of a loadable or loaded mod.
--- @field name string Mod ID (unique identifier for retrieving and distinguishing this mod)
--- @field namespace? string Namespace (prefix for content provided by this mod - must be unique in set of loaded mods)
--- @field basePath string Storage path prefix within which this mod's files are located
--- @field path string File/directory path of the mod's contents relative to the storage path
--- @field displayName string Mod name as shown in the UI
--- @field public package boolean Packaging state of the mod
--- @field version string Version number (should follow semantic versioning scheme)
--- @field info table Metadata for this mod

ModLoader.File = {
	MOD_INFO = "mod.json",
	PACKAGE_HASH = "$packageHash",
	NAME_OVERRIDE = "mod.id",
}

function ModLoader.validateModNamespace(modNamespace) end

function ModLoader.validateModName(modName) end

function ModLoader.validateModVersion(version) end

function ModLoader.validateModDisplayName(displayName) end

function ModLoader.getMountPoint(modName) end

--- @return table<string,table<string,ModLoader.Reference>>
function ModLoader.getAvailableMods() end

function ModLoader.listLoadedMods() end

function ModLoader.isLoaded(modName) end

function ModLoader.isAnyUnpackagedModLoaded() end

function ModLoader.resolveNamespace(modNamespace) end

function ModLoader.getLoadedModInfo(modName) end

function ModLoader.isLoadedAsPackage(modName) end

function ModLoader.getLoadedPackageHash(modName) end

function ModLoader.getModPriority(modName) end

function ModLoader.peek(modEntry, filename) end

function ModLoader.addPackageBasePath(basePath, modStorage, recursive) end

function ModLoader.addDirectoryBasePath(basePath, modStorage) end

function ModLoader.findMatchingVersion(versions, target) end

function ModLoader.loadMods(mods) end

function ModLoader.generatePackageFilename(name, version) end

function ModLoader.openModDirectory(modEntry) end

function ModLoader.writeModInfo(modEntry, modInfo) end

function ModLoader.getStorage(modEntry) end

function ModLoader.create(path, modInfo, templateFiles) end

function ModLoader.compile(modEntry, callbacks) end

return ModLoader
