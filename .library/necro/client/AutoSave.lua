--- @meta

local AutoSave = {}

AutoSave.Mode = {
	AUTOMATIC = 1,
	MANUAL = 2,
	OFF = 3,
}

function AutoSave.getMode() end

function AutoSave.setSuspendPending(pending) end

function AutoSave.isSuspendPending() end

function AutoSave.setRestorePending(pending) end

function AutoSave.isRestorePending() end

function AutoSave.isCurrentSessionSavable(manual) end

function AutoSave.isCurrentSessionCorrupted() end

function AutoSave.isSavedSessionAvailable() end

function AutoSave.cancel() end

function AutoSave.isLoading() end

function AutoSave.load() end

function AutoSave.save() end

function AutoSave.delete() end

function AutoSave.saveBackup(backupName) end

return AutoSave
