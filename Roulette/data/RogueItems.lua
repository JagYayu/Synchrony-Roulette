local RouletteGun = require "Roulette.Gun"

local Collision = require "necro.game.tile.Collision"
local CustomEntities = require "necro.game.data.CustomEntities"
local ItemSlot = require "necro.game.item.ItemSlot"
local StringUtilities = require "system.utils.StringUtilities"
local Utilities = require "system.utils.Utilities"

for _, entry in ipairs {
	--- Charms
	{ "CharmFrost", 5, 10, {
		Roulette_itemChargeRenderOutline = {},
		Roulette_itemCharmFrost = {},
	}, "Freeze attacker, recharge per match" },
	{ "Roulette_CharmGluttony", 5, 12, {
		Roulette_itemCharmFood = {},
		Roulette_itemGamblerMoreHealthItems = {},
		Roulette_itemChargeRenderOutline = {},
	}, "More health items, overheal bonus extra action" },
	{ "CharmLuck", 5, 10, {
		Roulette_itemAddGamblerLuck = { chance = .3 },
	}, "+1 luck" },
	{ "CharmNazar", 5, 12, {
		Roulette_rogueCharmNazar = {},
	} },
	{ "Roulette_CharmProtection", 5, 10, {
		Roulette_itemChargeRenderOutline = {},
		Roulette_itemArmor = { damageReduction = 4 },
	}, "+2 defense, recharge per match" },
	{ "CharmRisk", 5, 10, {
		Roulette_itemCharmRisk = {},
	}, "Low health +1 damage" },
	{ "CharmStrength", 5, 10, {
		Roulette_itemChargeRenderOutline = {},
		Roulette_itemGamblerDamageUpFirstRound = {},
	}, "First round +1 damage" },
	--- Boots
	{ "FeetBootsExplorers", 24, 8, {
		Roulette_itemAddGamblerInitiative = { value = 1 },
		Roulette_rogueItemPoolChest = { weight = 6, chestType = "ChestBlack" },
	}, "+1 initiative" },
	{ "FeetBootsLeaping", 10, 12, {
		Roulette_itemAddGamblerInitiative = { value = 2 },
	}, "+2 initiative, leaping" },
	{ "FeetBootsLunging", 2, 16, {
		Roulette_itemAddGamblerInitiative = { value = 3 },
	}, "+3 initiative, lunging" },
	--- Rings
	{ "RingCourage", 4, 11, {
		Roulette_itemGamblerSuicideProtection = {},
		Roulette_itemCharge = { rechargePerRound = true },
		Roulette_itemChargeRenderOutline = {},
	}, "Suicide protection, recharge per round" },
	{ "RingFrost", 3, 13, {
		Roulette_itemGamblerImmuneFreezing = {},
	}, "Immune to freezing" },
	{ "RingGold", 4, 13, {
		Roulette_itemMoreGolds = {},
	}, "x2 gold drop" },
	{ "RingLuck", 4, 11, {
		Roulette_itemAddGamblerLuck = { chance = .6 },
	}, "+2 luck" },
	{ "RingMana", 3, 13, {
		Roulette_itemMana = {},
	}, "Better freeze and shield" },
	{ "RingPain", 4, 11, {
		Roulette_itemAddGamblerExtraActions = {},
		Roulette_itemGamblerEndTurnDamage = {},
	}, "+1 Extra action, pain every turn" },
	{ "RingPeace", 3, 13, {
		Roulette_itemGamblerBanDamageUpItems = {},
	}, "No more drums, +1 heart" },
	{ "RingPiercing", 3, 11, {
		Roulette_itemPiercing = {},
	}, "Piercing damage, instakill headless skeletons" },
	{ "Roulette_RingProtection", 4, 11, {
		Roulette_itemGamblerProtection = {},
		Roulette_itemCharge = { rechargePerRound = true },
		Roulette_itemChargeRenderOutline = {},
	}, "Death protection, recharge per round" },
	{ "RingRegeneration", 4, 11, {
		Roulette_itemGamblerHealOnKill = { health = 2 },
		Roulette_itemCharge = { rechargePerRound = true },
		Roulette_itemChargeRenderOutline = {},
	}, "Heal as you kill, recharge per round" },
	{ "RingShielding", 4, 11, {
		Roulette_itemGamblerShielding = {},
		Roulette_itemChargeRenderOutline = {},
	}, "Unbreakable 4 turns, recharge per match" },
	{ "RingWar", 4, 11, {
		Roulette_itemGamblerMoreDamageUpItems = {},
		Roulette_itemGamblerSuppressingDamage = {},
	}, "More drums, overwhelm damage" },
} do
	event.entitySchemaLoadNamedEntity.add("equipment" .. (entry[1]):gsub("_", ""), entry[1], function(ev)
		ev.entity.Roulette_rogueItemPoolShop = { advanced = true, weight = entry[2], basePrice = entry[3] }

		for key, value in pairs(entry[4]) do
			ev.entity[key] = value
		end

		if entry[5] then
			ev.entity.Roulette_hintLabel = {
				text = entry[5],
				offsetY = ev.entity.itemHintLabel and ev.entity.itemHintLabel.offsetY,
			}
		elseif ev.entity.itemHintLabel then
			ev.entity.Roulette_hintLabelVanilla = {}
		end

		if ev.entity.Roulette_rogueItemPoolChest then
		elseif StringUtilities.startsWith(entry[1], "Charm") then
			ev.entity.Roulette_rogueItemPoolChest = { weight = 2 }
		elseif StringUtilities.startsWith(entry[1], "Ring") then
			ev.entity.Roulette_ring = {}
			ev.entity.Roulette_rogueItemPoolChest = { weight = 2 }
			ev.entity.Roulette_rogueItemSlot = {}
		end

		ev.entity.Roulette_hintLabelOnCursor = {}
	end)
end

--- @diagnostic disable: missing-fields

for _, entry in ipairs {
	{ "Roulette_ArmorLeather",    "armor_leather",    15, 6,  1, "0.5 defense", { Roulette_rogueItemPoolChest = { weight = 4, chestType = "ChestBlack" } } },
	{ "Roulette_ArmorChainmail",  "armor_chainmail",  9,  12, 2, "1 defense",   { Roulette_rogueItemPoolChest = { weight = 2, chestType = "ChestBlack" } } },
	{ "Roulette_ArmorPlatemail",  "armor_platemail",  4,  18, 3, "1.5 defense", },
	{ "Roulette_ArmorHeavyplate", "armor_heavyplate", 1,  24, 4, "2 defense", },
	{ "Roulette_ArmorQuartz", "armor_leather", 6, 14, 1, "0.5 defense, +1 initiative", {
		Roulette_itemAddGamblerInitiative = {},
		sprite = { texture = "mods/Roulette/gfx/armor_quartz.png" }
	} },
} do
	local components = {
		Roulette_item = {},
		Roulette_itemArmorProtective = {},
		Roulette_itemCharge = { charged = entry[5] },
		Roulette_rogueItemPoolShop = { advanced = true, weight = entry[3], basePrice = entry[4] },
		Roulette_hintLabel = { text = entry[6] },
		itemArmor = false,
		itemArmorLate = false,
	}
	if entry[7] then
		Utilities.mergeTablesRecursive(components, entry[7])
	end

	CustomEntities.extend {
		name = entry[1],
		template = CustomEntities.template.item(entry[2]),
		components = components,
	}
end

for _, entry in ipairs {
	{ "Roulette_Bomb", "Bomb", 4, 2, "ext/items/bomb.png", 24, 24, {
		Roulette_itemTagBomb = {},
		Roulette_itemUseCastSpellOnTarget = { spell = "SpellcastBombInstantExplosion" },
		Roulette_itemUseOnOpponent = {},
		Roulette_stealable = {},
		itemSlot = { name = ItemSlot.Type.BOMB },
	}, "Blow up opponent's items\nUse on opponent" },
	{ "Roulette_HeartTransplant", "Heart Transplant", 2, 4, "ext/items/heart_transplant.png", 24, 24, {
		Roulette_itemUseAddGamblerExtraActions = {},
		Roulette_itemUseOnSelf = {},
		itemSlot = { name = ItemSlot.Type.ACTION },
		Roulette_itemUseSound = { sound = "spellGeneral" },
	}, "+1 extra action\nUse on self" },
	{ "Roulette_ScrollCharm", "Charm Scroll", 1, 5, "mods/Roulette/gfx/scroll_charm.png", 24, 24, {
		Roulette_itemUseCharmGambler = { turns = 5 },
		Roulette_itemUseOnEnemy = {},
		Roulette_itemUseSound = { sound = "spellCharm" },
	}, "Charm opponent 5 turns\nUse on opponent" },
	{ "Roulette_ScrollConvertBlankShell", "Scroll Of Blank Shell", 1, 5, "mods/Roulette/gfx/scroll_shell_green.png", 24, 24, {
		Roulette_itemUseConvertBullets = { bullet = RouletteGun.Bullet.Blank },
		Roulette_itemUseVocalize = { suffix = "Transmute" },
		Roulette_itemUseOnGun = {},
		Roulette_itemUseSound = { sound = "spellTransmute" },
		Roulette_itemUseUpdateAI = {},
	}, "Convert all shells to blank\nUse on gun" },
	{ "Roulette_ScrollConvertLiveShell", "Scroll Of Live Shell", 1, 5, "mods/Roulette/gfx/scroll_shell_red.png", 24, 24, {
		Roulette_itemUseConvertBullets = { bullet = RouletteGun.Bullet.Live },
		Roulette_itemUseVocalize = { suffix = "Transmute" },
		Roulette_itemUseOnGun = {},
		Roulette_itemUseSound = { sound = "spellTransmute" },
		Roulette_itemUseUpdateAI = {},
	}, "Convert all shells to live\nUse on gun" },
	{ "Roulette_ScrollDuplicate", "Scroll of Duplication", 2, 5, "mods/Roulette/gfx/scroll_duplication.png", 24, 24, {
		Roulette_itemUseDuplicate = {},
		Roulette_itemUseOnEnemy = {},
		Roulette_itemUseOnOpponentItem = { canBeAlly = true },
		Roulette_itemUseOnSelfItem = {},
		Roulette_itemUseSound = { sound = "spellGeneral" },
	}, "Duplicate an item or enemy\nUse on item or opponent" },
	{ "Roulette_ScrollFireball", "Flame Scroll", 1, 5, "ext/items/scroll_red.png", 24, 24, {
		Roulette_itemUseBurnGun = { multiplier = 3 },
		Roulette_itemUseOnGun = {},
		Roulette_itemUseSound = { sound = "spellFireball" },
		Roulette_itemUseVocalize = { suffix = "Fireball" },
	}, "Burn gun, x3 damage\nUse on gun" },
	{ "Roulette_ScrollSilence", "Scroll Of Silence", 1, 5, "mods/Roulette/gfx/scroll_silence.png", 24, 24, {
		Roulette_itemUseOnOpponent = {},
		Roulette_itemUseSetGamblerSilence = { turns = 999 },
		Roulette_itemUseSound = { sound = "spellGeneral" },
	}, "Silence an opponent permanently\nUse on opponent" },
	{ "Roulette_TomeCharm", "Charm Tome", 2, 4, "mods/Roulette/gfx/tome_charm.png", 24, 24, {
		Roulette_itemUseCharmGambler = {},
		Roulette_itemUseOnEnemy = {},
		Roulette_itemUseSound = { sound = "spellCharm" },
		positionalSprite = { offsetX = 3 },
		sprite = { width = 17, height = 25 },
	}, "Charm opponent 2 turns\nUse on opponent" },
	{ "Roulette_TomeConvertBlankShell", "Blank Shell Tome", 2, 4, "mods/Roulette/gfx/tome_shell_green.png", 24, 24, {
		Roulette_itemUseConvertLastBullet = { bullet = RouletteGun.Bullet.Blank },
		Roulette_itemUseOnGun = {},
		Roulette_itemUseSound = { sound = "spellTransmute" },
		Roulette_itemUseVocalize = { suffix = "Transmute" },
		positionalSprite = { offsetX = 3 },
		sprite = { width = 17, height = 25 },
	}, "Convert last live shell to blank\nUse on gun" },
	{ "Roulette_TomeConvertLiveShell", "Live Shell Tome", 2, 4, "mods/Roulette/gfx/tome_shell_red.png", 24, 24, {
		Roulette_itemUseConvertLastBullet = { bullet = RouletteGun.Bullet.Live },
		Roulette_itemUseOnGun = {},
		Roulette_itemUseSound = { sound = "spellTransmute" },
		Roulette_itemUseVocalize = { suffix = "Transmute" },
		positionalSprite = { offsetX = 3 },
		sprite = { width = 17, height = 25 },
	}, "Convert last blank shell to live\nUse on gun" },
	{ "Roulette_TomeFireball", "Flame Tome", 2, 4, "mods/Roulette/gfx/tome_fireball.png", 24, 24, {
		Roulette_itemUseBurnGun = {},
		Roulette_itemUseOnGun = {},
		Roulette_itemUseSound = { sound = "spellFireball" },
		Roulette_itemUseVocalize = { suffix = "Fireball" },
		positionalSprite = { offsetX = 3 },
		sprite = { width = 17, height = 25 },
	}, "Burn gun, x2 damage\nUse on gun" },
	{ "Roulette_TomeSilence", "Silence Tome", 2, 4, "mods/Roulette/gfx/tome_silence.png", 24, 24, {
		Roulette_itemUseOnAlly = {},
		Roulette_itemUseOnOpponent = {},
		Roulette_itemUseSetGamblerSilence = {},
		Roulette_itemUseSound = { sound = "spellGeneral" },
		positionalSprite = { offsetX = 3 },
		sprite = { width = 17, height = 25 },
	}, "Silence an opponent 3 turns\nUse on opponent" },
} do
	CustomEntities.register({
		name = entry[1],

		Roulette_categoryRogueItem = {},
		Roulette_hintLabel = { text = entry[9], offsetY = -26 },
		Roulette_hintLabelOnCursor = {},
		Roulette_item = {},
		Roulette_rogueItemPoolShop = { weight = entry[3], basePrice = entry[4] },
		Roulette_rogueItemSlot = {},
		Roulette_selectable = {},
		Roulette_visibilityHideItemHintLabel = {},

		collision = { mask = Collision.Type.ITEM },
		friendlyName = { name = entry[2] },
		hoverEffect = {},
		hoverEffectAlwaysEnabled = {},
		item = {},
		itemDestructible = {},
		itemPickupAnimation = {},
		itemPickupFlyaway = {},
		itemPickupSound = {},
		itemSlot = { name = ItemSlot.Type.ACTION },
		position = {},
		positionalSprite = {},
		rowOrder = {},
		sale = {},
		saleRemoveOnCollect = {},
		saleRemoveOnDespawn = {},
		shadow = {},
		shadowPosition = {},
		silhouette = {},
		sprite = { texture = entry[5], width = entry[6], height = entry[7] },
		spriteSheet = {},
		tween = {},
		visibility = {},
		visibilityRevealWhenLit = {},
		visibleByMonocle = {},
	}, entry[8])
end

CustomEntities.extend {
	name = "Roulette_CharmGluttony",
	template = CustomEntities.template.item "charm_gluttony",
	components = {
		itemConsumeOnFoodOverheal = false,
		itemEnableFoodOverheal = false,
	},
}

CustomEntities.extend {
	name = "Roulette_CharmProtection",
	template = CustomEntities.template.item "charm_protection",
	components = {
		itemArmor = false,
	},
}

CustomEntities.extend {
	name = "Roulette_RingProtection",
	template = CustomEntities.template.item "ring_protection",
	components = {
		itemArmor = false,
		itemDeathProtection = false,
	},
}

CustomEntities.extend {
	name = "Roulette_HeadCrownOfGreed",
	template = CustomEntities.template.item "head_crown_of_greed",
	--- @diagnostic disable-next-line: assign-type-mismatch
	components = { itemCurrencyDrain = false },
}

CustomEntities.extend {
	name = "Roulette_CharmInfernal",
	template = CustomEntities.template.item "charm_nazar",
	components = {
		Roulette_hintLabel = { text = "Halve fire damage", offsetY = -26 },
		Roulette_itemHalveFireDamage = {},
		Roulette_rogueItemPoolShop = { advanced = true, weight = 5, basePrice = 10 },
		positionalSprite = { offsetY = 2 },
		sprite = { texture = "mods/Roulette/gfx/charm_infernal.png", width = 18, height = 22 }
	},
	data = {
		flyaway = "Infernal Charm",
		hint = false,
		itemDeleteApparitions = false,
	},
}

for _, definition in pairs {
	{
		name = "Roulette_SpellDisengageBlank",
		components = {
			Roulette_itemUseSetGamblerDisengage = { field = "blank", gold = 25, flyawaySuccess = "Shooting a blank at yourself to escape" },
			Roulette_rogueModeEntityReplaceOnLevelLoad = false,

			sprite = { texture = "mods/Roulette/gfx/spell_disengage_green.png", width = 24, height = 24 },

			itemCastOnUse = false,
		},
		data = {
			flyaway = "Disengage Spell",
			hint = "Disengage Spell (Blank)",
		},
	},
	{
		name = "Roulette_SpellDisengageLive",
		components = {
			Roulette_itemUseSetGamblerDisengage = { field = "live", gold = 15, flyawaySuccess = "Shooting a live at yourself to escape" },
			Roulette_rogueModeEntityReplaceOnLevelLoad = false,

			sprite = { texture = "mods/Roulette/gfx/spell_disengage_red.png", width = 24, height = 24 },

			itemCastOnUse = false,
		},
		data = {
			flyaway = "Disengage Spell",
			hint = "Disengage Spell (Live)",
		},
	},
} do
	definition.components.DynChar_dynamicItem = false
	definition.components.DynChar_dynamicItemHover = false
	definition.components.itemScreenFlash = false
	definition.components.itemCastOnUse = false
	definition.components.spellBloodMagic = false
	definition.components.spellCooldownKills = false
	definition.components.spellReusable = false
	definition.components.voiceSpellTypeSuffix = false

	CustomEntities.extend {
		name = definition.name,
		template = CustomEntities.template.item "spell_fireball",
		components = definition.components,
		data = definition.data,
	}
end

for i = 1, 4 do
	CustomEntities.extend {
		name = "Roulette_HeartContainer" .. i,
		template = CustomEntities.template.item "misc_heart_container",
		components = {
			Roulette_rogueItemPoolShop = { advanced = true, weight = 3, basePrice = 15 },
			Roulette_rogueItemPoolChest = { weight = 2, chestType = "ChestRed" },
			--- @diagnostic disable-next-line: assign-type-mismatch
			itemPoolHearts = false,
			itemSlot = { name = "" },
			sale = {},
			saleRemoveOnCollect = {},
			saleRemoveOnDespawn = {},
		},
	}
end

local definitionBagRogue = {
	name = "Roulette_BagRogue",

	Roulette_rogueBag = {},
	Roulette_rogueModeEntityReplaceOnLevelLoad = false,

	collision = { mask = Collision.Type.ITEM },
	friendlyName = { name = "Backpack" },
	hoverEffect = {},
	hoverEffectAlwaysEnabled = {},
	item = {},
	itemCommon = {},
	itemHintLabel = { text = "3x3 inventory" },
	itemSlot = { name = ItemSlot.Type.HUD },
	position = {},
	positionalSprite = { offsetY = 0 },
	shadow = {},
	shadowPosition = {},
	rowOrder = { z = -24 },
	sprite = { texture = "ext/items/hud_backpack.png" },
	tween = {},
	visibility = {},
	visibilityRevealWhenLit = {},
}

CustomEntities.register(definitionBagRogue)
CustomEntities.register(definitionBagRogue, {
	name = "Roulette_BagRogue2",

	Roulette_rogueBag = { gridWidth = 5 },
	Roulette_rogueItemPoolShop = { advanced = true, weight = 12, basePrice = 8 },
	Roulette_hintLabelVanilla = {},

	friendlyName = { name = "Large Backpack" },
	itemHintLabel = { text = "5x5 inventory" },
	positionalSprite = { offsetY = 0 },
	sale = {},
	saleRemoveOnCollect = {},
	saleRemoveOnDespawn = {},
	silhouette = {},
	sprite = { texture = "ext/items/bag_holding.png" },
	spriteSheet = {},
	visibility = {},
	visibleByMonocle = {},
})
