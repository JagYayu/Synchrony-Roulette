--- @meta

local NetworkMods = {}

NetworkMods.Problem = {
	MISSING_LOCALLY = 1,
	VERSION_MISMATCH = 2,
	HASH_MISMATCH = 3,
	PACKAGE_MISMATCH = 4,
	MISSING_DLC = 5,
}

function NetworkMods.isActive() end

function NetworkMods.getPackagePreference() end

function NetworkMods.isReady() end

function NetworkMods.isExactMatch() end

function NetworkMods.isWritable() end

function NetworkMods.hasRemoteModList() end

function NetworkMods.getRemoteModList() end

function NetworkMods.updateRemoteModList(modList) end

function NetworkMods.forcePackages() end

function NetworkMods.isPlayerModListSynchronized(playerID) end

function NetworkMods.allModsSynchronized() end

function NetworkMods.loadRemoteMods() end

function NetworkMods.getVersion(modName) end

function NetworkMods.getDisplayName(modName) end

function NetworkMods.getMismatches() end

function NetworkMods.getMismatch(modName) end

return NetworkMods
