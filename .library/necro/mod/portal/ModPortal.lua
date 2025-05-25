--- @meta

local ModPortal = {}

ModPortal.Status = {
	NONE = 0,
	PENDING = 1,
	ACTIVE = 2,
	COMPLETE = 3,
	FAILED = 4,
}

ModPortal.SortMode = {
	ID = 1,
	NAME = 2,
	RELEASE_DATE = 3,
	LAST_UPDATE = 4,
	DOWNLOADS = 5,
	POPULAR = 6,
}

ModPortal.Protocol = {
	--- mods.necro.marukyu.de (legacy mod portal)
	SYNCHROMOD = 1,
	--- mod.io (new API)
	MOD_IO = 2,
}

function ModPortal.resolveProtocol(modName) end

function ModPortal.getProtocol() end

function ModPortal.isReady(modName) end

function ModPortal.getMetadata(modName, key) end

function ModPortal.listAllMods() end

function ModPortal.listVersions(modName) end

function ModPortal.getProvider(protocol) end

function ModPortal.download(modName, version, callback) end

function ModPortal.delete(modName) end

function ModPortal.isDeletable(modName) end

function ModPortal.query(args, callback) end

function ModPortal.refresh() end

function ModPortal.getImage(modName, imageType, immediate) end

function ModPortal.getActiveDownloads() end

function ModPortal.hasActiveOrLingeringDownloads() end

function ModPortal.hasActiveDownloads() end

function ModPortal.getDownloadStatus(modNameOrIdentifier, version) end

function ModPortal.openDirectory() end

function ModPortal.openHomepage(modName) end

function ModPortal.saveToDownloadedMods(modDownload) end

return ModPortal
