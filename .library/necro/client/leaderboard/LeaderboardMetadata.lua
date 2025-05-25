--- @meta

local LeaderboardMetadata = {}

--- @class LeaderboardMetadata.FlagData
--- @field playerCount integer Number of players in the run
--- @field victory boolean If true, the run was completed victoriously
--- @field lowPercent boolean If true, the run was completed without items or shrines
--- @field goldDuplication boolean If true, this run made use of gold duplication to gain extra score

LeaderboardMetadata.Column = {
	--- The zone in which the run ended (legacy field)
	ZONE = 1,
	--- The level in which the run ended (legacy field)
	LEVEL = 2,
	--- Version information (currently a constant number as a development placeholder)
	VERSION = 3,
	--- Bitmask for run-specific flags
	FLAGS = 4,
	--- ID of the damage source that killed the player (see TextPoolKillerName)
	KILLER_ID = 5,
	--- Bitmask of the first 6 player characters' leaderboard IDs
	CHARACTER_IDS = 6,
}

LeaderboardMetadata.Flag = {
	--- Bitmask for player count (0-255)
	PLAYER_COUNT_LSB = 1,
	PLAYER_COUNT_MSB = 128,
	--- If set, this run ended in a victory
	VICTORY = 256,
	--- If set, this run was completed without picking up items or using shrines
	LOW_PERCENT = 512,
	--- If set, this run made use of gold duplication to gain extra score
	GOLD_DUPLICATION = 1024,
}

function LeaderboardMetadata.versionBitmaskToString(versionBits) end

function LeaderboardMetadata.versionStringToBitmask(versionString) end

function LeaderboardMetadata.getCurrentVersion() end

function LeaderboardMetadata.characterBitmaskToList(characterBits) end

function LeaderboardMetadata.characterListToBitmask(characterList) end

--- @param flagTable LeaderboardMetadata.FlagData
--- @return LeaderboardMetadata.Flag
function LeaderboardMetadata.flagTableToBitmask(flagTable) end

--- @param flagBits LeaderboardMetadata.Flag
--- @return LeaderboardMetadata.FlagData
function LeaderboardMetadata.flagBitmaskToTable(flagBits) end

--- @param context LeaderboardContext
--- @return integer[]
function LeaderboardMetadata.generateFromContext(context) end

return LeaderboardMetadata
