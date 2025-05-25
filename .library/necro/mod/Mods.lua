--- @meta

local Mods = {}

function Mods.load(modName, packaged, priority) end

function Mods.unload(modName) end

function Mods.isLoaded(modName) end

function Mods.isActivated(modName) end

function Mods.resolveNamespace(namespace) end

function Mods.listLoadedMods() end

function Mods.listUnloadedMods() end

function Mods.listAllMods() end

function Mods.listVersions(modName) end

function Mods.listVersionsIncludeUnavailable(modName) end

function Mods.getLatestVersion(modName, package) end

function Mods.findMatchingVersion(modName, version, package) end

function Mods.findUnpackagedVersion(modName, targetVersion) end

function Mods.setVersion(modName, version) end

function Mods.getVersion(modName) end

function Mods.isLoadedAsPackage(modName) end

function Mods.isValidVersionLoaded(modName) end

function Mods.unloadInvalidVersions() end

function Mods.setPriority(modName, priority) end

function Mods.getPriority(modName) end

function Mods.getMetadata(modName, key) end

function Mods.getDisplayName(modName) end

function Mods.validateModNamespace(modName) end

function Mods.validateModVersion(version) end

function Mods.validateModDisplayName(displayName) end

function Mods.updateModList() end

function Mods.openDirectory(modName) end

function Mods.create(modInfo) end

function Mods.writeModInfo(modName, modInfo) end

function Mods.compile(modName, callbacks) end

--- Prevents the specified mod from being automatically loaded on startup for the current session.
function Mods.blacklist(modName) end

function Mods.applyChanges() end

function Mods.hasPendingChanges() end

function Mods.saveModListSnapshot() end

function Mods.saveRemoteModListSnapshot() end

function Mods.loadModListSnapshot(snapshot) end

return Mods
