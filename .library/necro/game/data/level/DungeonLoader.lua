--- @meta

local DungeonLoader = {}

--- @class LevelGenerator.Options.CustomDungeon : LevelGenerator.Options
--- @field fileName? string Name of the dungeon file to load the level from
--- @field number? integer Level number to load from the dungeon file (defaults to 1)

function DungeonLoader.loadFromString(data, levelNumber) end

function DungeonLoader.loadFromFile(fileName, levelNumber) end

return DungeonLoader
