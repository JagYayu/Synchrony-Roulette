--- @meta

local LevelGenerator = {}

--- @class LevelGenerator.Options
--- @field number integer 1-indexed sequential identifier of this level in the whole run. Preserved across sub-runs
--- @field type LevelGenerator.Type Stores the string ID of the generator to use for this level
--- @field modeID GameSession.Mode Stores the string ID of the game mode to use for this level
--- @field isFinal? boolean If true, completing this level counts as a victory and ends the run
--- @field isLoopFinal? boolean If true, completing this level counts as a victory for the current loop
--- @field initialCharacters? table<integer,string> Maps initially present player IDs to chosen characters
--- @field seed integer Specifies the seed to generate this level with
--- @field runState RunState Stores the current run state table
--- @field loopID integer 1-index loop counter, tracking how many sub-runs have been performed within this run
--- @field overridePastLevels? Level.Data Overwrites all past levels to reduce memory usage
--- @field primaryPlayerID? Player.ID Optionally designates a player as the in-turn host for the current session

--- @class Event.LevelGenerate
--- @field options LevelGenerator.Options Defines the input parameters to generate this level with
--- @field level? Level.Data Output parameter to store the generated level
--- @field async? any Output parameter to indicate asynchronous level generation. Event will re-fire until async is nil

LevelGenerator.Type = {
	Boss = "Boss",
	CryptArena_libLevelGen_CryptArena = "CryptArena_libLevelGen_CryptArena",
	CustomDungeon = "CustomDungeon",
	MultiChararacter = "MultiChararacter",
	Necro = "Necro",
	Test = "Test",
	Training = "Training",
	Void = "Void",
}

--- Invokes the level generator specified by the `options` parameter and returns the resulting level
--- @param options LevelGenerator.Options Parameters to invoke the level generator with
--- @param async? any Asynchronous continuation data from the 2nd result of the last invocation to this function
--- @return Level.Data level? Resulting data of the generated level. May be nil if the generator works asynchronously
--- @return any asyncNext? Asynchronous continuation data for the level generator (need to call function again)
function LevelGenerator.generate(options, async) end

return LevelGenerator
