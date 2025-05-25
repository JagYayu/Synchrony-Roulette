--- @meta

local BossLevel = {}

--- @class LevelGenerator.Options.Boss : LevelGenerator.Options
--- @field boss Boss.Type Type of boss to spawn
--- @field depth integer Depth of the boss level to generate (defaults to 1)
--- @field zone integer Zone number of the boss level to generate (defaults to 1)
--- @field floor integer Floor number of the boss level to generate (defaults to 4)
--- @field extraSize integer Amount by which to increase or decrease the boss arena size (defaults to 0)

function BossLevel.getName(options) end

return BossLevel
