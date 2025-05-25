--- @meta

local AssetReloader = {}

AssetReloader.EventType = {
	NONE = 0,
	CHANGED = 1,
	CHANGED_RECURSIVE = 2,
	ADDED = 4,
	REMOVED = 8,
}

function AssetReloader.freeUnusedData() end

function AssetReloader.reload(resource) end

function AssetReloader.reloadAll() end

function AssetReloader.reloadAllDeferred() end

function AssetReloader.forceReload(resourceName) end

return AssetReloader
