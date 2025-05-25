--- @meta

local ItemBan = {}

ItemBan.Flag = {
	--- Prevents the player from picking up the item
	PICKUP = 1,
	--- Prevents the item from being dropped by collecting another item in the same slot.
	--- If the slot capacity is used up by drop-banned items, no more items of this slot can be picked up.
	LOSS_DROP = 2,
	--- Prevents the item from being dropped via Scatter Trap
	LOSS_SCATTER = 4,
	--- Prevents the item from being sold to the Pawnbroker
	LOSS_SELL = 8,
	--- Prevents the item from being consumed by disarming shrines (Peace, Phasing)
	LOSS_SHRINE = 16,
	--- Prevents the item from being changed by conversion shrines (Rhythm, Glass)
	CONVERT_SHRINE = 32,
	--- Prevents the item from being changed by conversion spells (Need, Enchant)
	CONVERT_SPELL = 64,
	--- Prevents the item from being changed by transaction tiles (Transmogrifier)
	CONVERT_TRANSACTION = 128,
	--- Kills the player when trying to pick up the item
	PICKUP_DEATH = 256,
	--- Disallows equipping the item, preventing any events from being forwarded to it
	EQUIP = 512,
	--- Disallows activating the item (action slot, spell, throw, etc.)
	ACTIVATE = 1024,
	--- Prevents this item from being granted via Soul Links
	SOUL_LINK = 2048,
	--- Prevents this item from being carried over across player character changes
	CHARACTER_SWITCH = 4096,
	--- Removes the item from the common chest/shop/mimic/vault item pool
	GENERATE_ITEM_POOL = 32768,
	--- Removes the item from crate-specific drops (food, bombs)
	GENERATE_CRATE = 65536,
	--- Prevents the item from being granted by fixed-outcome shrines (e.g. War, Phasing, No Return)
	GENERATE_SHRINE_FIXED = 131072,
	--- Prevents the item from being granted by flexible-outcome shrines (e.g. Chance, Sacrifice, Pain)
	GENERATE_SHRINE_POOL = 262144,
	--- Prevents the item from dropping from destroyed shrines
	GENERATE_SHRINE_DROP = 524288,
	--- Prevents the item from generating directly in the level (bomb, mouse-traps, potions)
	GENERATE_LEVEL = 1048576,
	--- Prevents the item from being spawned by transaction tiles (Transmogrifier, Conjurer)
	GENERATE_TRANSACTION = 2097152,
}

ItemBan.Type = {
	--- No restrictions
	NONE = 0,
	--- Don't generate in most loot pools, but still allow fixed-outcome shrines to spawn the item.
	--- This flag is typically used for initial equipment or items that would be too weak on the character.
	GENERATION = 2916352,
	--- Don't generate under any circumstances.
	--- This flag is typically used for items that are unusable by the character.
	GENERATION_ALL = 4161536,
	--- Don't lose under any circumstances.
	--- This flag is typically used for items that would cause issues when unexpectedly lost.
	LOSS_ALL = 30,
	--- Don't allow this item to be used under any cirumstances.
	--- This flag is typically used for items that should be temporarily holdable by a shapeshifting character.
	USE_ALL = 5633,
	--- Disallow pickup, drop, scatter or any replacement of this item.
	--- This flag is typically used for irreplacable equipment on the character.
	LOCK = 4167935,
	--- Disallow pickup and don't generate under any circumstances.
	--- This flag is typically used for items that are too powerful on the character.
	FULL = 4169217,
}

function ItemBan.getBanFlags(holder, item) end

function ItemBan.isBanned(holder, item, mask) end

return ItemBan
