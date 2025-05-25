--- @meta

local FileIO = {}

--- Flags for determining the result of resource listings
--- @class ListFlags
--- @field FILES integer List regular files
--- @field DIRECTORIES integer List subdirectories
--- @field FULL_PATH integer List each resource's absolute path, prepending the 'path' parameter to the relative path
--- @field SORTED integer Sort results alphabetically
--- @field RECURSIVE integer Recursively list the contents of subdirectories.

FileIO.List = {
	FILES = 1,
	FULL_PATH = 16,
	DIRECTORIES = 2,
	RECURSIVE = 4,
	SORTED = 8,
}

function FileIO.getSubstitute(fileName) end

function FileIO.isSubstituted(fileName) end


function FileIO.readFileToString(fileName, maxBytes) end

function FileIO.listFiles(path, ...) end

function FileIO.exists(path) end

return FileIO
