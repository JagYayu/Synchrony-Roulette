--- @meta

local ModUpdate = {}

ModUpdate.Mode = {
	MANUAL = 1,
	CHECK_FOR_UPDATES = 2,
	AUTOMATICALLY_INSTALL = 3,
}

function ModUpdate.setPinned(modName, pinned) end

function ModUpdate.isPinned(modName) end

function ModUpdate.loadLatestLocalVersion(modName) end

function ModUpdate.loadAllLatestLocalVersions() end

function ModUpdate.getAvailableUpdate(modName) end

function ModUpdate.refreshAvailableUpdates() end

function ModUpdate.fetchAvailableUpdates() end

function ModUpdate.listAvailableUpdates() end

function ModUpdate.update(modName) end

function ModUpdate.updateAll() end

function ModUpdate.getAutoUpdateMode() end

function ModUpdate.isUnloadedModNotificationEnabled() end

return ModUpdate
