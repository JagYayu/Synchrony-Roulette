--- @meta

local ExtraMode = {}

ExtraMode.Type = {
	NONE = 0,
	DANCEPAD = 1,
	STORY = 2,
	ALL_CHARACTERS = 3,
	ALL_CHARACTERS_AMPLIFIED = 4,
	DEATHLESS = 5,
	CUSTOM = 6,
	LEVEL_EDITOR = 7,
	DOUBLE_TEMPO = 20,
	CHARACTER_LOCK = 21,
	FRIENDLY_FIRE = 22,
	LOW_PERCENT = 23,
	ALL_CHARACTERS_SYNCHRONY = 24,
	ALL_CHARACTERS_MODDED = 25,
	ENSEMBLE = 26,
	PHASING = 10,
	RANDOMIZER = 11,
	MYSTERY = 12,
	NO_BEAT = 13,
	NO_RETURN_SEEDED = 14,
	HARD_SEEDED = 15,
	PHASING_SEEDED = 16,
	RANDOMIZER_SEEDED = 17,
	MYSTERY_SEEDED = 18,
	NO_BEAT_SEEDED = 19,
	CryptArena_MODE_LAST_ONE_DANCING = 27,
	CryptArena_MODE_DEATHMATCH = 28,
	CryptArena_TREASURE_HUNT = 29,
	CryptArena_SEASON_HALLOWEEN = 30,
	CryptArena_SEASON_CHRISTMAS = 31,
	CryptArena_SEASON_NONE = 32,
	CryptArena_LEVELGEN_LARGE = 33,
	CryptArena_LEVELGEN_SMALL = 34,
	CryptArena_LEVELGEN_HALLOWEEN = 35,
	CryptArena_LEVELGEN_CHRISTMAS = 36,
	NO_RETURN = 8,
	HARD = 9,
}

function ExtraMode.getStaircaseI18nKey(mode) end

function ExtraMode.getDescriptionI18nKey(mode) end

function ExtraMode.getDisplayName(mode) end

function ExtraMode.isAvailable(mode) end

function ExtraMode.isVisible(mode) end

function ExtraMode.isActiveInCurrentRun(mode) end

function ExtraMode.isActive(mode) end

function ExtraMode.setActive(mode, active) end

function ExtraMode.listAvailableModes() end

function ExtraMode.isUnlocked(mode) end

function ExtraMode.getGameModeID(mode) end

function ExtraMode.isSeeded(mode) end

return ExtraMode
