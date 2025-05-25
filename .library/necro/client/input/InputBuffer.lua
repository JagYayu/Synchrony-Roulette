--- @meta

local InputBuffer = {}

InputBuffer.Flag = {
	GENERIC = 1,
	INTRO = 2,
	RUN_START = 4,
	LEVEL_TRANSITION = 8,
}

function InputBuffer.activate(flag, timeout) end

function InputBuffer.deactivate(flag) end

function InputBuffer.isActive() end

function InputBuffer.actOnLevelStart(actionID, playerID) end

return InputBuffer
