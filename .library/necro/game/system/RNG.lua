--- @meta

local RNG = {}

RNG.Channel = {
	SOUNDTRACK = 1,
	CRATE = 2,
	SHOP = 3,
	DROPS = 4,
	ARENA = 5,
	AMBUSH = 6,
	VISUAL_EFFECTS = 7,
	SOUND_EFFECTS = 8,
	ENEMY_UPGRADES = 9,
	ITEM_GENERATION = 10,
	ENEMY_CULLING = 11,
	LEVEL_INIT_PLACEMENT = 12,
	BOSS_BUTTON_PUZZLES = 13,
	SUPER_SECRET_SHOP = 14,
	WALL_CRACK = 15,
	FACING = 16,
	CryptArena_ArenaEvents = 17,
	CryptArena_ArenaEventData = 18,
	CryptArena_itemPoolChannel = 19,
	CryptArena_RandomItemSpawner = 20,
	CryptArena_PrepRoom = 21,
	CryptArena_SEASON_TRAP_CHEST = 22,
	CryptArena_ArenaShop = 23,
	Sync_DICE_TRAP = 24,
	Sync_TRAP_SPIKE_AUTO = 25,
}

--- @return integer
function RNG.getDungeonSeed() end

--- Generates a seeded random integer between 0 (inclusive) and the specified limit (excluding the limit itself).
--- If an entity with the "random" component is specified, the entity-specific RNG state is used.
--- If a number is specified, the corresponding consistency channel is used.
--- Otherwise, level-global random state is used. The latter is more prone to visual discontinuities during rollback.
--- @param limit integer
--- @param channel any
--- @return integer
function RNG.int(limit, channel) end

--- Shuffles the given list in-place (Fisher-Yates)
--- Channel parameter: see rng.int
--- @generic T
--- @param list T[]
--- @param channel any
--- @return T[]
function RNG.shuffle(list, channel) end

--- Generates a seeded random integer between the lower and upper limit, including both limit values themselves.
--- Channel parameter: see rng.int
function RNG.range(lower, upper, channel) end

--- Chooses a seeded random entry from the specified table.
--- Channel parameter: see rng.int
--- @generic T
--- @param table T[]
--- @param channel any
--- @return T
function RNG.choice(table, channel) end

function RNG.float(limit, channel) end

--- Performs a seeded random check, returning true with the specified probability (between 0 and 1), or false otherwise.
--- Channel parameter: see rng.int
function RNG.roll(probability, channel) end

--- Overrides the current RNG state with the specified seed values.
function RNG.seed(r1, r2, r3, channel) end

--- Creates a standalone RNG channel
function RNG.makeChannel(seed1, seed2, seed3) end

return RNG
