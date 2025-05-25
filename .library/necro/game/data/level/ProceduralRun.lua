--- @meta

local ProceduralRun = {}

ProceduralRun.StoryBossMode = {
	ONE_STORY_BOSS = 1,
	ALL_STORY_BOSSES = 2,
	NO_STORY_BOSSES = 3,
}

ProceduralRun.Trait = {
	ZONE5_BLEED = 1,
	NO_BLADEMASTERS = 2,
	NO_GOLD_IN_WALLS = 4,
	EXTRA_MINIBOSS = 8,
	EXTRA_ENEMIES = 16,
	ADD_SPIDERS = 32,
	ADD_SARCOPHAGUS = 64,
	NO_SARCOPHAGUS = 128,
	ZONE4_NO_MONKEYS = 256,
	ZONE4_NO_SPIDERS = 512,
	EXTRA_ENEMIES_Z1Z2Z5 = 1024,
}

ProceduralRun.CharacterTraitMode = {
	DEFAULT = 1,
	ALWAYS_ON = 2,
	ALWAYS_OFF = 3,
}

function ProceduralRun.getPlayerCharacterBitmask(characters) end

--- Adds the levels of a given zone to the end of the sequence
--- @param sequence LevelGenerator.Options.Procedural[]
--- @param zone integer
--- @param depth? integer
--- @param floorCount? integer
function ProceduralRun.addZone(sequence, zone, depth, floorCount) end

--- Appends a boss to the end of the sequence. Does nothing if no boss is specified
--- @param sequence LevelGenerator.Options.Procedural[]
--- @param bossType? Boss.Type
--- @return LevelGenerator.Options.Procedural?
function ProceduralRun.addBoss(sequence, bossType) end

--- Removes the last boss in the sequence. Preserves trailing non-boss levels
--- @param sequence LevelGenerator.Options.Procedural[]
function ProceduralRun.removeTrailingBoss(sequence) end

--- Reverses the order of zones in the specified sequence, as is the case when playing Aria All-Zones mode
--- @param sequence LevelGenerator.Options.Procedural[]
function ProceduralRun.applyZoneReversal(sequence) end

--- Reverses the order of zones in the specified sequence, as is the case when playing Aria Single-Zone mode
--- @param sequence LevelGenerator.Options.Procedural[]
function ProceduralRun.applyDepthReversal(sequence) end

return ProceduralRun
