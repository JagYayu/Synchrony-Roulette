--- @meta

local ModGroup = {}

ModGroup.Type = {
	UPGRADABLE = 1,
	MISSING_DLC = 2,
	MISSING_UNFIXABLE = 4,
	MISSING = 8,
	PORTAL_POPULAR = 16,
	TOOLS = 16384,
	PUBLISHED = 1024,
	SELECTED = 128,
	HIDDEN = 131072,
	UNPUBLISHED = 2048,
	DESELECTED = 256,
	FAVORITE = 32,
	UNCATEGORIZED = 32768,
	DLC = 4096,
	PACKAGEABLE = 512,
	AVAILABLE = 64,
	BUNDLED = 65536,
	DOWNLOADED = 8192,
}

function ModGroup.groupByPackageAvailability(provider, modName) end

function ModGroup.groupBySelection(provider, modName) end

function ModGroup.groupByPublication(provider, modName) end

function ModGroup.groupByMismatch(provider, modName) end

return ModGroup
