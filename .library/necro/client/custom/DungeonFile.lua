--- @meta

local DungeonFile = {}

--- @class DungeonFile.Header
--- @field v integer Format version (for backwards compatibility)
--- @field name string Dungeon name

function DungeonFile.loadFromString(data, levelNumber) end

function DungeonFile.loadFromFile(fileName, levelNumber) end

function DungeonFile.loadFromStorage(name, levelNumber) end

function DungeonFile.saveToString(dungeonData) end

function DungeonFile.saveToStorage(name, dungeonData) end

function DungeonFile.exists(name) end

function DungeonFile.delete(name) end

function DungeonFile.openDirectory() end

function DungeonFile.list() end

function DungeonFile.resolvePath(name) end

return DungeonFile
