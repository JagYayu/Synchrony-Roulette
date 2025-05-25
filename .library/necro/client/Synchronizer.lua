--- @meta

local Synchronizer = {}

Synchronizer.DesyncMode = {
	IGNORE = 1,
	NOTIFY = 2,
	AUTO_CORRECT = 3,
	RECONNECT = 4,
	DISCONNECT = 5,
}

function Synchronizer.isGameStateSynced() end

function Synchronizer.getDesyncNotification() end

function Synchronizer.resynchronize() end

return Synchronizer
