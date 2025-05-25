--- @meta

local ModCompiler = {}

ModCompiler.PatchLevel = {
	NONE = 0,
	MAJOR = 1,
	MINOR = 2,
	PATCH = 3,
}

function ModCompiler.incrementVersionNumber(version, level) end

function ModCompiler.setPatchLevel(level) end

return ModCompiler
