local RouletteLocalization = require "Roulette.data.Localization"

local Collision = require "necro.game.tile.Collision"
local CustomEntities = require "necro.game.data.CustomEntities"
local GameDLC = require "necro.game.data.resource.GameDLC"
local ItemSlot = require "necro.game.item.ItemSlot"

do -- item overrides
	local function foodEntry(name, maximumRound)
		return { name, "+1 health\nUse on ally or self", 1, {
			Roulette_itemGenRoundLimit = { maximum = maximumRound },
			Roulette_itemTagFood = {},
			Roulette_itemTagHeal = {},
			Roulette_itemUseHeal = {},
			Roulette_itemUseOnAlly = {},
			Roulette_itemUseOnSelf = {},
			Roulette_itemUseSound = { sound = "eatFood" },
			Roulette_rogueItemPoolShop = { weight = 1, basePrice = 3 },
		} }
	end

	for _, entry in ipairs {
		{ "BloodDrum", "x2 damage, -1 health\nUse on gun", 2, {
			Roulette_itemGenRoundLimit = { minimum = 3 },
			Roulette_itemTagAIUseLimit = { key = "BloodDrum" },
			Roulette_itemTagOffensive = {},
			Roulette_itemUseDamageUser = {},
			Roulette_itemUseOnGun = {},
			Roulette_itemUseSetGunDamageDouble = {},
			Roulette_itemUseSound = { sound = "warDrum2" },
			Roulette_itemUseUserHop = {},
			Roulette_rogueItemPoolShop = { weight = 4, basePrice = 4 },
		} },
		{ "Roulette_CursedPotion", "+2/-1 health, 50% chance\nUse on ally or self", 3, {
			Roulette_itemGenRoundLimit = { maximum = 8, weightOverride = 1 },
			Roulette_itemTagHeal = {},
			Roulette_itemUseConditionalDamageLater = {},
			Roulette_itemUseOnAlly = {},
			Roulette_itemUseOnSelf = {},
			Roulette_itemUseHeal = { health = 2 },
			Roulette_itemUseSound = { sound = "drinkCursedPotion" },
			Roulette_rogueItemPoolShop = { weight = 2, basePrice = 2 },
		} },
		foodEntry("Food1", 7),
		foodEntry("Food2", 5),
		foodEntry("Food3", 4),
		foodEntry("Food4", 3),
		foodEntry("FoodCarrot", 6),
		foodEntry("Roulette_FoodCookies", 8),
		{ "Roulette_HeadCircletTelepathy", "Tell a random shell\nUse on gun", 4, {
			Roulette_itemGenGunBulletsRequired = { minimum = 3 },
			Roulette_itemTagOneUsePerTurn = {},
			Roulette_itemTagAIUseLimit = { key = "TellRandomShell" },
			Roulette_itemTagMisc = {},
			Roulette_itemTagTellRestBullet = {},
			Roulette_itemUseOnGun = {},
			Roulette_itemUseTellGunBullet = {
				indices = { 2, 3, 4 },
			},
			Roulette_itemUseTellGunBulletFlyaway = {
				fallback = "Very interesting...",
				format = "The %s shell is... %s",
				texts = { RouletteLocalization.Location_2, RouletteLocalization.Location_3, RouletteLocalization.Location_4 },
			},
			Roulette_itemUseVocalize = { suffix = "Hm2" },
			Roulette_rogueItemPoolShop = { weight = 5, basePrice = 4 },
		} },
		{ "Roulette_HeadMonocle", "Tell current shell\nUse on gun", 6, {
			Roulette_itemTagAIUseLimit = { key = "TellFirstShell" },
			Roulette_itemTagMisc = {},
			Roulette_itemTagOneUsePerTurn = {},
			Roulette_itemTagTellFirstBullet = {},
			Roulette_itemUseOnGun = {},
			Roulette_itemUseTellGunBullet = {},
			Roulette_itemUseTellGunBulletFlyaway = {
				format = "%s shell is... %s",
				texts = { RouletteLocalization.Location_Next },
			},
			Roulette_itemUseVocalize = { suffix = "Hm" },
			Roulette_rogueItemPoolShop = { weight = 5, basePrice = 4 },
		} },
		{ "HolyWater", "Consume current shell\nUse on gun", 6, {
			Roulette_itemTagMisc = {},
			Roulette_itemTagRetreat = {},
			Roulette_itemUseOnGun = {},
			Roulette_itemUseParticle = {
				type = "particlePuff",
				texture = "ext/particles/TEMP_particle_heal.png",
				particleCount = 25,
				duration = 2.25,
				maxDelay = 0.75,
				fadeDelay = 1,
				fadeTime = 0.5,
				minOpacity = 0.6,
				radius = 12,
				zVelocity = 75,
				gravity = -1.8,
			},
			Roulette_itemUseRemoveGunBullet = {},
			Roulette_itemUseTellGunBullet = {},
			Roulette_itemUseTellGunBulletFlyaway = {
				focusedOnly = false,
				format = "%sA %s shell consumed!",
				texts = { "" },
			},
			Roulette_itemUseSound = { sound = "holyWater" },
			Roulette_itemUseUpdateAI = {},
			Roulette_rogueItemPoolShop = { weight = 4, basePrice = 1 },
		} },
		{ "Roulette_MiscMonkeyPaw", "Steal an item\nUse on opponent's item", 4, {
			Roulette_itemGenRoundLimit = { minimum = 2 },
			Roulette_itemTagSteal = {},
			Roulette_itemTagMisc = {},
			Roulette_itemUseAllowTargetOpponentItem = {},
			Roulette_itemUseOnOpponentItem = { canBeAlly = true },
			Roulette_itemUseSound = { sound = "monkeyGrab" },
			Roulette_itemUseSteal = {},
			Roulette_rogueItemPoolShop = { weight = 7, basePrice = 3 },
		} },
		{ "ScrollFreezeEnemies", "Freeze all opponents 1 turn\nUse on opponent", 1, {
			Roulette_itemGenGamblersRequired = {},
			Roulette_itemTagControl = {},
			Roulette_itemUseOnOpponent = { canBeAlly = true },
			Roulette_itemUseSetGamblersFreeze = {},
			Roulette_itemUseSound = { sound = "spellFreeze" },
			Roulette_itemUseVocalize = { suffix = "Freeze" },
			Roulette_rogueItemPoolShop = { weight = 1, basePrice = 5 },
		} },
		{ "ScrollShield", "Invincible shield 2 turns, skip turn\nUse on ally or self", 1, {
			Roulette_itemGenGamblersRequired = {},
			Roulette_itemTagAIUseLimit = { key = "Shield", times = 5 },
			Roulette_itemTagDefensive = {},
			Roulette_itemUseOnAlly = {},
			Roulette_itemUseOnSelf = {},
			Roulette_itemUseSetGamblerShield = { turns = 1.5, allyBuff = .75 },
			Roulette_itemUseSkipTurn = {},
			Roulette_itemUseSound = { sound = "spellShield" },
			Roulette_itemUseVocalize = { suffix = "Shield" },
			Roulette_rogueItemPoolShop = { weight = 1, basePrice = 5 },
		} },
		{ "ScrollTransmute", "Transmute all shells\nUse on gun", 1, {
			Roulette_itemGenGunBulletsRequired = {},
			Roulette_itemTagTransmute = {},
			Roulette_itemUseOnGun = {},
			Roulette_itemUseSound = { sound = "spellTransmute" },
			Roulette_itemUseTransmuteBullet = { count = 100 },
			Roulette_itemUseVocalize = { suffix = "Transmute" },
			Roulette_rogueItemPoolShop = { weight = 1, basePrice = 5 },
		} },
		{ "Roulette_TomeFreeze", "Freeze opponent 1 turn\nUse on opponent", 4, {
			Roulette_itemTagControl = {},
			Roulette_itemUseOnOpponent = { canBeAlly = true },
			Roulette_itemUseSetGamblerFreeze = {},
			Roulette_itemUseSound = { sound = "spellFreeze" },
			Roulette_itemUseVocalize = { suffix = "Freeze" },
			Roulette_rogueItemPoolShop = { weight = 2, basePrice = 4 },
		} },
		{ "Roulette_TomeShield", "Invincible shield 1 turn\nUse on ally or self", 4, {
			Roulette_itemTagAIUseLimit = { key = "Shield", times = 5 },
			Roulette_itemTagDefensive = {},
			Roulette_itemUseOnAlly = {},
			Roulette_itemUseOnSelf = {},
			Roulette_itemUseSetGamblerShield = {},
			Roulette_itemUseSound = { sound = "spellShield" },
			Roulette_itemUseVocalize = { suffix = "Shield" },
			Roulette_rogueItemPoolShop = { weight = 2, basePrice = 4 },
		} },
		{ "Roulette_TomeTransmute", "Transmute current shell\nUse on gun", 4, {
			Roulette_itemTagTransmute = {},
			Roulette_itemUseOnGun = {},
			Roulette_itemUseSound = { sound = "spellTransmute" },
			Roulette_itemUseTransmuteBullet = {},
			Roulette_itemUseVocalize = { suffix = "Transmute" },
			Roulette_rogueItemPoolShop = { weight = 2, basePrice = 4 },
		} },
		{ "WarDrum", "+1 damage, 3/5 combos: +2/+3\nUse on gun", 8, {
			Roulette_itemTagAIUseLimit = { key = "WarDrum", times = 5 },
			Roulette_itemTagOffensive = {},
			Roulette_itemUseAddGunDamageCombo = {},
			Roulette_itemUseOnGun = {},
			Roulette_itemUseUserHop = {},
			Roulette_itemUseSound = { sound = "warDrum1" },
			Roulette_rogueItemPoolShop = { weight = 7, basePrice = 3 },
		} },
	} do
		event.entitySchemaLoadNamedEntity.add("item" .. (entry[1]):gsub("_", ""), entry[1], function(ev)
			ev.entity.Roulette_categoryBaseItem = {}
			ev.entity.Roulette_selectable = {}
			ev.entity.Roulette_item = {}
			ev.entity.Roulette_hintLabel = {
				text = entry[2],
				offsetY = ev.entity.itemHintLabel and ev.entity.itemHintLabel.offsetY,
			}
			ev.entity.Roulette_hintLabelOnCursor = {}
			ev.entity.Roulette_itemPool = { weight = entry[3] }
			ev.entity.Roulette_stealable = {}
			ev.entity.Roulette_rogueItemSlot = {}
			ev.entity.Roulette_visibilityHideItemHintLabel = {}
			if ev.entity.itemStack and ev.entity.itemStackQuantityLabelWorld then
				ev.entity.Roulette_visibilityHideItemStackQuantityLabel = {}
			end

			for key, value in pairs(entry[4]) do
				if key then
					ev.entity[key] = value
				end
			end
		end)
	end
end

--- @diagnostic disable

for _, entry in ipairs {
	{ "Roulette_FoodCookies",   "mods/Roulette/gfx/food_cookies.png",   18, 18, 3, 3,  "Cookie" },
	{ "Roulette_CursedPotion",  "mods/Roulette/gfx/cursed_potion.png",  14, 23, 5, 0,  "Grape Juice" },
	{ "Roulette_TomeFreeze",    "mods/Roulette/gfx/tome_freeze.png",    17, 25, 3, -0, "Freeze Tome" },
	{ "Roulette_TomeShield",    "mods/Roulette/gfx/tome_shield.png",    17, 25, 3, -0, "Shield Tome" },
	{ "Roulette_TomeTransmute", "mods/Roulette/gfx/tome_transmute.png", 17, 25, 3, -0, "Transmute Tome" },
} do
	CustomEntities.register {
		name = entry[1],
		friendlyName = { name = entry[7] },
		collision = { mask = Collision.Type.ITEM },
		hoverEffect = {},
		hoverEffectAlwaysEnabled = {},
		item = {},
		itemDestructible = {},
		itemNegateLowPercent = {},
		itemPickupFlyaway = {},
		itemPickupSound = { sound = "pickupGeneral" },
		itemSlot = {},
		position = {},
		positionalSprite = { offsetX = entry[5], offsetY = entry[6] },
		rowOrder = {},
		sale = {},
		saleRemoveOnCollect = {},
		saleRemoveOnDespawn = {},
		shadow = {},
		shadowPosition = {},
		silhouette = {},
		sprite = { texture = entry[2], width = entry[3], height = entry[4] },
		spriteSheet = {},
		tween = {},
		visibility = {},
		visibilityRevealWhenLit = {},
		visibleByMonocle = {},
	}
end

CustomEntities.extend {
	name = "Roulette_HeadCircletTelepathy",
	template = CustomEntities.template.item "head_circlet_telepathy",
	components = {
		itemSlot = { name = ItemSlot.Type.ACTION },
	},
}
CustomEntities.extend {
	name = "Roulette_HeadMonocle",
	template = CustomEntities.template.item "head_monocle",
	components = {
		itemSlot = { name = ItemSlot.Type.ACTION },
	},
}
CustomEntities.extend {
	name = "Roulette_MiscMonkeyPaw",
	template = CustomEntities.template.item "misc_compass",
	components = {
		DynChar_dynamicItem = { texture = "mods/DynChar/gfx/misc_monkey_paw.png", width = 10, height = 11, offsetX = -5, offsetY = -7 },
		friendlyName = { name = "Monkey's Paw" },
		itemBlockDuplicatePickup = false,
		itemFreezeMonkeyLikes = false,
		itemGrantTileVision = false,
		itemKey = false,
		itemPerspectiveModifier = false,
		itemSlot = { name = ItemSlot.Type.ACTION },
		itemStack = false,
		itemStackMergeOnPickup = false,
		sprite = { texture = "mods/Roulette/gfx/misc_monkey_paw.png", width = 20, height = 26 },
	},
}
