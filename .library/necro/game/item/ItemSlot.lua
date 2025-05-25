--- @meta

local ItemSlot = {}

ItemSlot.Type = {
	--- Shovels and other digging items.
	SHOVEL = "shovel",
	--- Weapons and other offensive items. Throw/reload actions are typically bound to `action.Special.THROW`.
	WEAPON = "weapon",
	--- Armor and other protective items.
	BODY = "body",
	--- Helmets and other headwear.
	HEAD = "head",
	--- Boots and other footwear. Toggling is typically bound to `action.Special.THROW`.
	FEET = "feet",
	--- Torches and other illuminating items.
	TORCH = "torch",
	--- Rings and other utility items.
	RING = "ring",
	--- Shields (Synchrony DLC only).
	SHIELD = "shield",
	--- Charms and other miscellaneous items that show up to the right of the player's equipment. Infinite slot capacity.
	MISC = "misc",
	--- Consumables and other action items. Slot capacity is 1 by default, but can be increased by HUD slot items.
	--- Activation is automatically bound to `action.Special.ITEM_1` or `action.Special.ITEM_2` based on slot index.
	ACTION = "action",
	--- Backpacks and other storage items. Special action typically bound to `action.Special.ITEM_2`.
	HUD = "hud",
	--- Bombs and other explosive items. Activation is automatically bound to `action.Special.BOMB`.
	BOMB = "bomb",
	--- Spells and other magical items. Slot capacity is 2 by default.
	--- Activation is automatically bound to `action.Special.SPELL_1` or `action.Special.SPELL_2` based on slot index.
	SPELL = "spell",
	--- Internal slot for deployed familiars. Not displayed in the HUD. Infinite slot capacity.
	FOLLOWER = "follower",
	--- Internal slot for activated shrines. Not displayed in the HUD. Infinite slot capacity.
	SHRINE = "shrine",
	--- Internal slot for an item stash container.
	STASH = "stash",
	--- Internal slot for a charmed enemy storage container.
	STASH_PETS = "stashPets",
	CryptArena_PRESENT_COUNTER = "CryptArena_PRESENT_COUNTER",
}

return ItemSlot
