--- @meta

local Configuration = {}

Configuration.DataType = {
	MISSING = 0,
	NULL = 1,
	STRING = 2,
	BOOL = 3,
	INT = 4,
	FLOAT = 5,
	ARRAY = 6,
	MAP = 7,
}

function Configuration.getString(key) end

function Configuration.getNumber(key) end

function Configuration.getBool(key) end

function Configuration.getType(key) end

function Configuration.get(key) end

function Configuration.set(key, value) end

return Configuration
