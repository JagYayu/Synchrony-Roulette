--- @meta

local ModListProvider = {}

ModListProvider.Annotation = {
	NONE = 0,
	ENABLED = 1,
	INSTALLED = 2,
	UPGRADABLE = 4,
	UNPACKAGED = 8,
	PINNED = 16,
	AUTO_LOADED = 32,
	FAILED = 64,
}

ModListProvider.Type = {
	LOCAL = 1,
	PORTAL = 2,
	NETWORK_MODS = 3,
	ASSET_MODS = 4,
	DLC = 5,
	CUSTOM_SOUNDTRACK = 6,
	PUBLISH_ASSET_MOD = 7,
	PUBLISH_MOD = 8,
}

function ModListProvider.getProvider() end

return ModListProvider
