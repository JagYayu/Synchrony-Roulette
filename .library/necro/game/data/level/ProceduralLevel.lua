--- @meta

local ProceduralLevel = {}

--- @class LevelGenerator.Options.Procedural : LevelGenerator.Options
--- @field depth integer Depth of the level to generate (always starts at 1 for a regular run)
--- @field zone integer Zone number of the level to generate (usually starts at 1, but can start at 4/5 for Aria)
--- @field floor integer Floor number of the level to generate (starts at 1 for each zone, then increments up to 3-5)
--- @field boss? Boss.Type Generates a specific boss type for this level
--- @field singleZone boolean Toggles whether this level should generate as Single-Zone (true) or All-Zones (false)
--- @field extraRoomCount number Decides how big the generated level should be
--- @field amplified boolean Toggles whether this level should generate with or without AMPLIFIED features
--- @field hardMode boolean Toggles the generation of extra enemies, sarcophagi and minibosses. Requires AMPLIFIED
--- @field playerOptions? Level.PlayerOptions Overrides player spawning behavior for this level

ProceduralLevel.RoomType = {
	UNKNOWN = 0,
	STANDARD = 1,
	SECRET = 2,
	SHOP = 3,
	SECRET_SHOP = 4,
	SPAWN = 5,
	EXIT = 6,
	BOSS = 7,
	VAULT = 8,
}

ProceduralLevel.ZoneColor = {
	[4] = -1029251,
	[1] = -10845486,
	[5] = -14109516,
	[2] = -14112216,
	[3] = -336831,
}

function ProceduralLevel.getName(options) end

return ProceduralLevel
