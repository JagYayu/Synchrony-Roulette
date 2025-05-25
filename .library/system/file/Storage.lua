--- @meta

local Storage = {}

Storage.Location = {
	WORKING_DIRECTORY = 0,
	HOME = 1,
	CONFIGURATION = 2,
	USER_DATA = 3,
	CACHE = 4,
	WORKING_DIRECTORY_PARENT = 5,
	EXTERNAL_ASSETS = 6,
}

function Storage.exists(prefix, location) end

function Storage.isReadOnly() end

function Storage.readAbsolutePath(filename, maxBytes) end

function Storage.new(prefix, location, readOnly) end

return Storage
