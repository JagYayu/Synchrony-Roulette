--- @meta

local ItemGeneration = {}

--- @class ItemGeneration.ChoiceArguments
--- @field player? Entity Do not generate items that this player can't pick up (defaults to a random initial player)
--- @field banMask? ItemBan.Flag Ban flag to check on the player for item generation, defaults to `GENERATE_ITEM_POOL`
--- @field slot? ItemSlot.Type If non-nil, only generate items matching that slot
--- @field requiredComponents? Entity.ComponentType[] Only generate items that have all of those components
--- @field excludedComponents? Entity.ComponentType[] Only generate items that have none of those components
--- @field itemPool? ItemGeneration.Pool Component name used to determine item weights (the component needs a `weights` field)
--- @field chanceType? string Compatibility alias for itemPool (only works for built-in item pools)
--- @field levelBonus? integer Generate items from higher tiers
--- @field chanceFunction? fun(Entity):integer Sets item weights (when set, chanceType and levelBonus are ignored)
--- @field seenCounts? table<Entity.Type,integer> Acts as a counter for tracking item generation to prevent duplicates, defaults to global counter
--- @field depletionLimit? integer Items seen that many time will not be generated, defaults to 8
--- @field transmutedItem? Entity The item being transmuted, if any
--- @field default? Entity.Type If no items match the requirements, this is returned instead
--- @field usePendingItems? boolean Prioritizes pending single-zone items
--- @field markSeen? boolean Overrides whether this entity should be marked as seen or not (default true)
--- @field ignoreProgression? boolean Allow generating locked items in single-zone
--- @field randomPool? RandomPool Weighted choice pool instance from which items will be drawn
--- @field result? Entity.Type Resulting item type (used internally by `event.itemGenerate`)

ItemGeneration.Flag = {
	ON_PICKUP = 1,
	ON_TANGIBLE = 2,
	ON_FIXED_GEN = 4,
	PREGEN_SHRINES = 8,
	PREGEN_SHOPS = 16,
}

ItemGeneration.QueueType = {
	NORMAL = 1,
	SPECIAL = 2,
}

ItemGeneration.Mode = {
	CLASSIC = 11,
	DEFAULT = 4,
	RACING = 28,
	DEFAULT_LEGACY = 20,
}

ItemGeneration.Pool = {
	CHEST = "itemPoolChest",
	RED_CHEST = "itemPoolRedChest",
	PURPLE_CHEST = "itemPoolPurpleChest",
	BLACK_CHEST = "itemPoolBlackChest",
	LOCKED_CHEST = "itemPoolLockedChest",
	SHOP = "itemPoolShop",
	LOCKED_SHOP = "itemPoolLockedShop",
	URN = "itemPoolUrn",
	SECRET = "itemPoolSecret",
	FOOD = "itemPoolFood",
	HEARTS = "itemPoolHearts",
	CRATE = "itemPoolCrate",
	WAR = "itemPoolWar",
	UNCERTAINTY = "itemPoolUncertainty",
	ENCHANT = "itemPoolEnchant",
	NEED = "itemPoolNeed",
}

--- @param args ItemGeneration.ChoiceArguments
--- @return Entity.Type?
function ItemGeneration.choice(args) end

function ItemGeneration.getSeenCounts() end

--- Deprecated
function ItemGeneration.weightedChoice(channel, chanceType, levelBonus, slot, ...) end

--- Deprecated
function ItemGeneration.unweightedChoice(channel, slot, ...) end

function ItemGeneration.markSeen(entity, count) end

function ItemGeneration.getSeenCount(item) end

function ItemGeneration.checkSetting(condition) end

function ItemGeneration.maybeMarkSeen(item, condition) end

return ItemGeneration
