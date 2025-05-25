--- @meta

local NativeFileChooser = {}

NativeFileChooser.Type = {
	OPEN_FILE = 0,
	SAVE_FILE = 1,
	OPEN_FOLDER = 2,
}

function NativeFileChooser.new() end

return NativeFileChooser
