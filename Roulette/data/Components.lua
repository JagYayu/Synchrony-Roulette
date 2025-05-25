local RouletteGame = require "Roulette.Game"
local RouletteGun = require "Roulette.Gun"
local RouletteJudge = require "Roulette.Judge"
local RouletteRogueAI = require "Roulette.RogueAI"

local Action = require "necro.game.system.Action"
local AI = require "necro.game.enemy.ai.AI"
local Collision = require "necro.game.tile.Collision"
local Color = require "system.utils.Color"
local Components = require "necro.game.data.Components"
local Currency = require "necro.game.item.Currency"
local Damage = require "necro.game.system.Damage"
local ItemSlot = require "necro.game.item.ItemSlot"
local OutlineFilter = require "necro.render.filter.OutlineFilter"
local Utilities = require "system.utils.Utilities"

local const, field, depend = Components.constant, Components.field, Components.dependency

local Roulette_judgeAllocItems_itemCounts = {
	{ 1, 2 },
	{ 1, 3 },
	{ 2, 3 },
	{ 2, 4 },
	{ 2, 5 },
}
local Roulette_itemUseTransmuteBullet_map = {
	[RouletteGun.Bullet.Blank] = RouletteGun.Bullet.Live,
	[RouletteGun.Bullet.Live] = RouletteGun.Bullet.Blank,
}
local Roulette_gamblerNecromancy_attributes = {
	Roulette_gambler = {},
	beatDelay = { counter = 1 },
	health = { health = 1 },
}
local Roulette_gamblerNecromancy_resetFields = {
	beatDelay = { "interval" },
	health = { "maxHealth" },
}
local Roulette_gamblerSpawner_attributes = {
	Roulette_gambler = { turnDelay = 1 },
	Roulette_gamblerCurrency = { amount = 0 },
}
local Roulette_gunReloadAmounts_list = {
	{ 2, 3 },
	{ 3, 5 },
	{ 4, 6 },
	{ 4, 8 },
}
local Roulette_gunReloadFlyaway_format = ("%%s %s, %%s %s"):format(
	RouletteGun.Bullet.data[RouletteGun.Bullet.Live].name,
	RouletteGun.Bullet.data[RouletteGun.Bullet.Blank].name)
local Roulette_rogueShopkeeper_attributes = { Roulette_selectable = { suppressed = true }, itemStack = { quantity = 1 } }
local Roulette_rogueShopkeeper_placementsInitial = { { -1, 0 }, { 1, 0 } }

local defaultFlyawayParameters = {
	delay = 1,
	duration = 2,
}

--- @diagnostic disable: duplicate-doc-field
Components.register {
	Roulette_aiGamblerDeprecated                       = {
		--- A list of bullet types that can be sure.
		field.table("memoryBullets"),
		--- A set of items with component `Roulette_itemTagUseOncePerTurn`.
		field.table("usedItems"),
		const.enum("overrideVanillaAI", AI.Type, AI.Type.IDLE),
		const.float("actionDelay", .7),
		const.bool("actionDelayRandomize", true),
		depend("random"),
	},
	--- @class Component.Roulette_aiGamblerRogue
	--- @field traits Component.Roulette_aiGamblerRogue.traits
	Roulette_aiGamblerRogue                            = {
		const.enum("type", RouletteRogueAI.Type, RouletteRogueAI.Type.Standard),
		--- @type Component.Roulette_aiGamblerRogue.traits
		const.table("traits"),
		field.entityID("opponent"),
		field.table("memoryBullets"),
	},
	Roulette_apparition                                = {},
	Roulette_cameraRectFixed                           = {
		const.float("offsetX", 0),
		const.float("offsetY", -1.5),
		const.float("radius", 6),
	},
	Roulette_cameraRectRaycast                         = {
		field.float("x"),
		field.float("y"),
		field.float("w"),
		field.float("h"),
	},
	Roulette_coinMultiplier                            = {
		field.int("trick", 1),
		field.int("violence", 1),
		const.table("trickMultipliers", { 1, 2, 2, 3 }),
		field.int("violence", 1),
		const.table("violenceMultipliers", { 1, 1.5, 2, 2.5, 3 }),
	},
	Roulette_convertOnLevelLoad                        = {
		const.string("entityType"),
		const.table("targetGameModes", Utilities.listToSet { RouletteGame.FreeMode, RouletteGame.RogueMode, RouletteGame.RogueModeSeeded }),
	},
	Roulette_cursor                                    = {
		field.bool("active"),
		field.entityID("owner"),
		field.entityID("selected"),
	},
	Roulette_cursorFlyaway                             = {
		const.localizedString("failedSilence", "Silenced (ban items)"),
	},
	Roulette_cursorInteract                            = {},
	Roulette_cursorCollectGold                         = {},
	Roulette_cursorSlotLabel                           = {
		const.localizedString("text", "Interact"),
	},
	Roulette_cursorSound                               = {
		const.table("sounds", {
			cancel = "UIBack",
			select = "UIStart",
			use = "UIStart",
			failed = "error",
		}),
	},
	--- Specific to dragons
	Roulette_dragon                                    = {
		field.bool("rage"),
		field.int("state"),
		const.string("key"),
	},
	Roulette_enemy                                     = {
		field.int("initialX"),
		field.int("initialY"),
		const.float("skirmishSquareDistance", 7),
		const.float("moveToInitialPositionDelay", .2),
	},
	Roulette_enemyPool                                 = {
		const.int("weight", 100),
	},
	Roulette_enemyPoolNormal                           = {},
	Roulette_enemyPoolMiniboss                         = {},
	Roulette_enemyPoolZ1                               = {
		depend("Roulette_enemy"),
		depend("Roulette_enemyPool"),
	},
	Roulette_enemyPoolZ2                               = {
		depend("Roulette_enemy"),
		depend("Roulette_enemyPool"),
	},
	Roulette_enemyPoolZ3                               = {
		depend("Roulette_enemy"),
		depend("Roulette_enemyPool"),
	},
	Roulette_enemyPoolZ4                               = {
		depend("Roulette_enemy"),
		depend("Roulette_enemyPool"),
	},
	Roulette_gambler                                   = {
		field.int("initiative"),
		field.int("team"),
		field.bool("turn"),
		field.int("turnDelay"),
		--- After shooting a bullet, system will check whether to skip current turn. If this value is greater than 0, the turn continues.
		field.int("extraActions"),
		--- @warn While entity is associated with a judgeEntity(J), you need to set `judge` field to the J, and the `J.Roulette_judge.gamblers` should also contain id of this entity.
		field.entityID("judge"),
		field.entityID("cursor"),
		const.float("placementRange", 1.5),
		const.float("itemDistributionMultiplier", 1),
		const.float("skipTurnDelayTimeScale", .2),
	},
	Roulette_gamblerBagRingSwapLimit                   = {
		field.bool("limited"),
		depend("Roulette_gambler"),
	},
	Roulette_gamblerBeatDelay                          = {
		const.bool("autoCountdown", true),
		const.bool("autoReset", true),
		depend("beatDelay"),
	},
	Roulette_gamblerBeginTurnHop                       = {},
	Roulette_gamblerBeginTurnStealItems                = {
		const.int("amount", 1),
		const.string("sound", "monkeyGrab"),
	},
	Roulette_gamblerBackToPreviousTileLaterOnKnockback = {
		const.float("delay", .75),
		depend("Roulette_gambler"),
	},
	Roulette_gamblerBurnGunOnDeath                     = {
		const.float("multiplier", 2),
	},
	Roulette_categoryArmor                             = {},
	Roulette_categoryBaseItem                          = {},
	Roulette_categoryCharm                             = {},
	Roulette_categoryRing                              = {},
	Roulette_categoryRogueItem                         = {},
	Roulette_gamblerCharmable                          = {
		field.int("turns"),
		field.int("team"),
		field.int("color", Color.WHITE),
	},
	Roulette_gamblerColor                              = {
		field.int("color", Color.WHITE),
		const.float("fade", 1 / 3),
	},
	Roulette_gamblerConvertOnTakeDamage                = {
		const.string("targetType"),
		const.bool("shielding", true),
		const.enum("requiredDamageFlag", Damage.Flag, Damage.Flag.BYPASS_INVINCIBILITY),
		const.enum("excludedDamageFlag", Damage.Flag, Damage.Flag.mask(Damage.Flag.BYPASS_ARMOR, Damage.Flag.SELF_DAMAGE)),
	},
	Roulette_gamblerCurrency                           = {
		const.string("currencyType", Currency.Type.GOLD),
		field.int("amount"),
	},
	Roulette_gamblerCursor                             = {
		const.string("type", "Roulette_Cursor"),
		const.table("attributes"),
	},
	Roulette_gamblerDeathDrop                          = {
		const.float("chance", 1),
		const.table("entityTypes"),
	},
	--- Escape from a match by shooting a designated bullet at self.
	Roulette_gamblerDisengage                          = {
		field.bool("success"),
		field.bool("blank"),
		field.bool("live"),
	},
	Roulette_gamblerEndGameCast                        = {
		const.string("spell"),
	},
	Roulette_gamblerEndGameDelete                      = {},
	Roulette_gamblerEndTurnStealItems                  = {
		const.int("amount", 1),
		const.string("sound", "monkeyGrab"),
	},
	Roulette_gamblerFreezeAttackerOnDeath              = {
		const.int("turns", 2),
	},
	Roulette_gamblerFreezeParticle                     = {
		const.string("texture", "mods/Roulette/gfx/particle_flake.png"),
		const.int("baseParticleCount", 7),
		const.int("particleCount", 14),
		const.float("duration", 1.568),
		const.float("minDelay", 0),
		const.float("maxDelay", .1),
		const.float("fadeDelay", 0.417),
		const.float("fadeTime", .9),
		const.float("minOpacity", 0.7),
		const.float("maxSize", 3),
		const.float("spread", 11.3),
		const.float("velocity", 150),
		const.float("offsetY", 2.4),
		const.float("offsetZ", 24),
		const.float("gravity", 180),
		const.float("explosiveness", 3),
		const.float("bounciness", 0.1),
	},
	Roulette_gamblerGhostStasis                        = {
		depend("Roulette_selectable"),
		depend("stasis"),
	},
	Roulette_gamblerGhoul                              = {},
	Roulette_gamblerGolemOoze                          = {
		const.int("shrinkTurns", 2),
	},
	Roulette_gamblerGunShotConfuseVictim               = {},
	Roulette_gamblerHealer                             = {},
	Roulette_gamblerHintLabelOnCursor                  = {},
	Roulette_gamblerInnateArmor                        = {
		const.int("defense", 1),
		const.enum("requiredDamageFlag", Damage.Flag, Damage.Flag.BYPASS_INVINCIBILITY),
		const.enum("excludedDamageFlag", Damage.Flag, Damage.Flag.mask(Damage.Flag.BYPASS_ARMOR, Damage.Flag.SELF_DAMAGE)),
	},
	Roulette_gamblerInnateDamageUp                     = {
		const.int("damage", 1),
	},
	Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
	Roulette_gamblerLuck                               = {
		field.float("chance", 0),
	},
	Roulette_gamblerNewRoundBonusItem                  = {
		const.string("entityType", "Roulette_Bomb"),
	},
	Roulette_gamblerNewRoundBonusItems                 = {
		const.int("amount", 1),
	},
	Roulette_gamblerNewRoundHeal                       = {
		const.int("health", 1),
	},
	Roulette_gamblerMidJoinSound                       = {
		const.string("sound", "Roulette_gamblerMidJoin"),
	},
	Roulette_gamblerMidJoinTurnDelay                   = {
		const.int("value", 0),
	},
	Roulette_gamblerMommy                              = {},
	Roulette_gamblerNecromancer                        = {
		const.string("flyaway", "Necromancy!"),
		const.string("sound", "Roulette_necromancySkeleton"),
		const.string("targetType", "Skeleton"),
		const.table("attributes", Roulette_gamblerNecromancy_attributes),
		const.table("resetFields", Roulette_gamblerNecromancy_resetFields),
	},
	Roulette_gamblerNecromancyRevivable                = {},
	Roulette_gamblerNightmare                          = {
		field.entityID("shadowSource"),
		const.string("shadowSourceType", "Roulette_ShadowSource"),
	},
	Roulette_gamblerNoItemAllocation                   = {},
	Roulette_gamblerOgre                               = {
		field.bool("state"),
	},
	Roulette_gamblerOverrideItemWeights                = {
		const.table("mapping"),
	},
	Roulette_gamblerParry                              = {
		field.bool("active"),
		const.int("damageUp", 1),
		const.localizedString("flyawayCounterAttack", "Counterattack ready!"),
	},
	--- Gambler with this component always skip turns by default.
	Roulette_gamblerRigid                              = {},
	--- Specific to `Beetle`, `Beetle2`, would set `provokable.active` to true
	Roulette_gamblerShell                              = {
		const.enum("requiredDamageFlag", Damage.Flag, Damage.Flag.BYPASS_INVINCIBILITY),
		const.enum("excludedDamageFlag", Damage.Flag, Damage.Flag.BYPASS_ARMOR),
		depend("provokable"),
	},
	Roulette_gamblerShellBurnGun                       = {
		const.int("multiplier", 2),
	},
	Roulette_gamblerShellFreezeAttacker                = {
		const.int("turns", 2),
	},
	Roulette_gamblerShieldOnTakeDamage                 = {
		const.float("turns", 1.5),
		const.enum("requiredDamageFlag", Damage.Flag, Damage.Flag.BYPASS_INVINCIBILITY),
		const.enum("excludedDamageFlag", Damage.Flag, Damage.Flag.mask(Damage.Flag.BYPASS_ARMOR, Damage.Flag.SELF_DAMAGE)),
		depend("Roulette_gamblerStatusShield"),
	},
	Roulette_gamblerSilencer                           = {
		field.table("affecters"),
		depend("provokable"),
	},
	Roulette_gamblerSleepingGoblin                     = {},
	--- Specific to `Sarcophagus`
	Roulette_gamblerSpawner                            = {
		field.bool("active", true),
		--- Auto reset `beatDelay.counter`
		const.bool("beatDelayReset", true),
		field.entityID("entity"),
		const.string("entityType", "Skeleton"),
		const.table("attributes", Roulette_gamblerSpawner_attributes),
		const.string("sound", "sarcophagusSpawn"),
	},
	Roulette_gamblerStartGameBonusItem                 = {
		const.string("itemType", "Roulette_ItemBatMinibossFangs"),
		const.table("components", { "Roulette_itemGamblerHealOnKill" }),
	},
	Roulette_gamblerStartGameNoBeatDelayReset          = {},
	Roulette_gamblerStatusFear                         = {
		field.int("turns"),
		const.int("maxTurns", 3),
	},
	Roulette_gamblerStatusFreeze                       = {
		field.int("turns"),
	},
	Roulette_gamblerStatusShield                       = {
		--- `Roulette_gamblerStatusShield.turns` allows decimals, there would be a shield blinking effect while the value between 0~1
		field.float("turns"),
	},
	Roulette_gamblerStatusShrink                       = {
		field.int("turns"),
		const.float("spriteSizeMultiplier", .6),
		const.float("voicePitchMultiplier", 1.25),
	},
	Roulette_gamblerStatusSilence                      = {
		field.int("turns"),
	},
	Roulette_gamblerStunOnTakeDamage                   = {
		field.int("value", 1),
		const.int("max", 2),
	},
	Roulette_gamblerTeamVanilla                        = {
		depend("team"),
	},
	Roulette_gamblerTextBeginTurn                      = {
		const.localizedString("text", "Your turn"),
		const.localizedString("format", "%s's turn"),
		const.float("duration", 3),
		const.table("parameters", defaultFlyawayParameters),
	},
	Roulette_gamblerTextEndTurn                        = {
		const.localizedString("text", "Turn end"),
		const.float("duration", 2),
		const.table("parameters", defaultFlyawayParameters),
	},
	Roulette_gamblerTroll                              = {},
	Roulette_gamblerTurnBasedStasis                    = {},
	Roulette_gamblerVibrateEffect                      = {
		field.bool("active"),
		const.float("x", 1),
		const.float("period", 0.05),
	},
	Roulette_gun                                       = {
		field.entityID("gambler"),
		field.entityID("judge"),
		field.table("bullets"),
		field.int("damageMultiplier", 1),
	},
	Roulette_gunBurntParticle                          = {
		const.string("texture", "mods/Roulette/gfx/particle_flame.png"),
		const.int("particleCount", 17),
		const.float("duration", 1.568),
		const.float("minDelay", 0),
		const.float("maxDelay", .1),
		const.float("fadeDelay", 0.417),
		const.float("fadeTime", .9),
		const.float("minOpacity", 0.7),
		const.float("maxSize", 3),
		const.float("spread", 11.3),
		const.float("velocity", 190),
		const.float("offsetY", 2.4),
		const.float("offsetZ", 24),
		const.float("gravity", 240),
		const.float("explosiveness", 3),
		const.float("bounciness", 0.1),
	},
	Roulette_gunChamberSound                           = {
		const.string("sound", "Roulette_gunChamber"),
		const.table("soundData"),
	},
	Roulette_gunHintLabelOnCursor                      = {
		const.localizedString("text", "%s damage\nUse on opponent or self"),
		const.float("offsetY", -26),
	},
	Roulette_gunReloadAmounts                          = {
		const.table("list", Roulette_gunReloadAmounts_list),
		const.enum("bulletBlank", RouletteGun.Bullet, RouletteGun.Bullet.Blank),
		const.enum("bulletLive", RouletteGun.Bullet, RouletteGun.Bullet.Live),
		const.float("livePctMin", 1 / 3),
		const.float("livePctMax", 2 / 3),
	},
	Roulette_gunReloadFlyaway                          = {
		const.localizedString("format", Roulette_gunReloadFlyaway_format),
		const.table("parameters", defaultFlyawayParameters),
	},
	Roulette_gunReloadFlyawayOverlayText               = {
		const.float("duration", 3),
		depend("Roulette_gunReloadFlyaway"),
	},
	Roulette_gunReloadSound                            = {
		const.float("deltaTime", .18),
		const.string("sound", "Roulette_gunReload"),
		const.table("soundData"),
	},
	Roulette_gunShotParticle                           = {
		const.string("textureBlank", "mods/Roulette/gfx/particle_shell_green.png"),
		const.string("textureLive", "mods/Roulette/gfx/particle_shell_red.png"),
		const.float("velocity", 90),
	},
	Roulette_gunShotSound                              = {
		const.string("sound", "Roulette_gunShot"),
		const.table("soundData"),
	},
	--- This component also controls `sprite.color`
	Roulette_gunStatusBurnt                            = {
		field.float("multiplier", 1),
	},
	Roulette_gunStatusDamageCombo                      = {
		field.int("combo"),
		const.table("damages", { 2, 4, 6 }),
	},
	Roulette_gunStatusDamageDouble                     = {
		field.bool("active"),
	},
	Roulette_haunted                                   = {
		const.float("chance", .1),
		const.float("delayMin", .3),
		const.float("delayMax", 7.7),
	},
	Roulette_hintLabel                                 = {
		const.localizedString("text"),
		const.float("offsetY", -26),
	},
	Roulette_hintLabelOnCursor                         = {},
	Roulette_hintLabelVanilla                          = {
		depend("Roulette_hintLabel"),
		depend("itemHintLabel"),
	},
	Roulette_item                                      = {
		field.float("pickupTime"),
	},
	Roulette_itemAddGamblerExtraActions                = {
		const.int("extraActions", 1),
	},
	Roulette_itemAddGamblerInitiative                  = {
		const.int("value", 1),
	},
	Roulette_itemAddGamblerLuck                        = {
		const.float("chance", .3),
	},
	--- consider `Roulette_itemCharge` as durability.
	Roulette_itemArmor                                 = {
		const.enum("bypassFlags", Damage.Flag, Damage.Flag.BYPASS_ARMOR),
		const.int("bypassDamage", -1),
		const.int("damageReduction", 1),
		const.int("maximumDamageTaken", 32747),
		depend("Roulette_itemCharge"),
	},
	--- Body armors use this component instead of `Roulette_itemArmor`.
	Roulette_itemArmorProtective                       = {
		depend("Roulette_itemCharge"),
	},
	Roulette_itemCharge                                = {
		field.int("charged", 1),
		const.bool("rechargePerRound", false),
	},
	Roulette_itemChargeRenderOutline                   = {
		const.enum("mode", OutlineFilter.Mode, OutlineFilter.Mode.BASIC),
		const.int("color", Color.rgb(183, 183, 183)),
		depend("Roulette_itemCharge"),
	},
	--- Specific to `CharmGluttony`, over heal +1 extra action to gambler.
	Roulette_itemCharmFood                             = {
		const.localizedString("flyaway", "Gluttony!\nGain extra action! (%s)"),
		depend("Roulette_itemCharge"),
	},
	--- Specific to `CharmFrost`.
	Roulette_itemCharmFrost                            = {
		depend("Roulette_itemCharge"),
	},
	Roulette_itemCharmRisk                             = {
		depend("Roulette_itemGamblerDamageUpLowHealth"),
	},
	Roulette_itemExcludedFromAllocator                 = {},
	Roulette_itemHalveFireDamage                       = {},
	Roulette_itemGamblerBanDamageUpItems               = {},
	Roulette_itemGamblerDamageUpFirstRound             = {
		const.int("damage", 1),
		depend("Roulette_itemCharge"),
	},
	Roulette_itemGamblerDamageUpLowHealth              = {
		const.int("damage", 1),
	},
	Roulette_itemGamblerEndTurnDamage                  = {
		const.int("requiredHealth", 2),
		const.int("damage", 1),
		const.enum("type", Damage.Flag, Damage.Flag.mask(Damage.Type.INDIRECT, Damage.Flag.BYPASS_INVINCIBILITY)),
		const.localizedString("flyaway", "Pain!"),
		const.string("sound", "ringofpain"),
	},
	Roulette_itemGamblerHealOnKill                     = {
		const.int("health", 1),
		const.bool("mustBeHostile", true),
		depend("Roulette_itemCharge"),
	},
	Roulette_itemGamblerImmuneFreezing                 = {},
	Roulette_itemGamblerMoreDamageUpItems              = {},
	Roulette_itemGamblerMoreHealthItems                = {},
	Roulette_itemGamblerProtection                     = {
		const.localizedString("flyaway", "Protected!"),
	},
	Roulette_itemGamblerShielding                      = {
		const.float("turns", 3.5),
		depend("Roulette_itemCharge"),
	},
	Roulette_itemGamblerSuicideProtection              = {
		const.localizedString("flyaway", "Courage!"),
		const.string("sound", "courage"),
		depend("Roulette_itemCharge"),
	},
	Roulette_itemGamblerSuppressingDamage              = {},
	Roulette_itemGameModeAvailable                     = {},
	Roulette_itemGenGamblersRequired                   = {
		const.int("minimum", 3),
		const.int("weightOverride", 0),
	},
	Roulette_itemGenGunBulletsRequired                 = {
		const.int("minimum", 2),
		const.int("weightOverride", 0),
	},
	Roulette_itemGenRoundLimit                         = {
		const.int("minimum"),
		const.int("maximum"),
		const.int("weightOverride", 0),
	},
	Roulette_itemMana                                  = {},
	Roulette_itemMoreGolds                             = {},
	Roulette_itemPiercing                              = {},
	Roulette_itemPool                                  = {
		const.int("weight"),
	},
	--- tnh this is not a tag component but we won't change his name :(
	Roulette_itemTagAIUseLimit                         = {
		const.string("key"),
		const.int("times", 1),
	},
	Roulette_itemTagBomb                               = {},
	Roulette_itemTagControl                            = {},
	Roulette_itemTagOffensive                          = {},
	Roulette_itemTagDefensive                          = {},
	Roulette_itemTagFood                               = {},
	Roulette_itemTagHeal                               = {},
	Roulette_itemTagMisc                               = {},
	Roulette_itemTagOneUsePerTurn                      = {},
	--- beer
	Roulette_itemTagRetreat                            = {},
	Roulette_itemTagSteal                              = {},
	Roulette_itemTagTellFirstBullet                    = {},
	Roulette_itemTagTellRestBullet                     = {},
	Roulette_itemTagTransmute                          = {},
	Roulette_itemTagTransmuteLast                      = {},
	Roulette_itemUseAddGamblerExtraActions             = {
		const.int("value", 1),
		const.localizedString("flyaway", "Gain extra action! (%s)"),
	},
	Roulette_itemUseAddGunDamageCombo                  = {},
	Roulette_itemUseAllowTargetOpponentItem            = {},
	Roulette_itemUseBurnGun                            = {
		const.float("multiplier", 2),
	},
	Roulette_itemUseCastSpellOnTarget                  = {
		const.string("spell"),
		const.enum("direction", Action.Direction, Action.Direction.NONE),
		const.table("params"),
	},
	Roulette_itemUseCharmGambler                       = {
		const.int("turns", 2),
	},
	--- It would damage gambler instantly instead of using delay since v2 to prevent a weird bug which is really hard to debugging.
	Roulette_itemUseConditionalDamageLater             = {
		field.bool("active"),
		const.float("chance", .5),
		const.float("delay", .4),
		const.int("damage", 3),
		const.enum("type", Damage.Flag, Damage.Type.BLOOD),
	},
	Roulette_itemUseConvertBullets                     = {
		const.enum("bullet", RouletteGun.Bullet),
	},
	Roulette_itemUseConvertLastBullet                  = {
		const.enum("bullet", RouletteGun.Bullet),
	},
	Roulette_itemUseDamageUser                         = {
		const.int("damage", 1),
		const.enum("type", Damage.Flag, Damage.Type.BLOOD),
	},
	Roulette_itemUseDuplicate                          = {},
	Roulette_itemUseHeal                               = {
		const.int("health", 1),
	},
	Roulette_itemUseNoDeletion                         = {},
	Roulette_itemUseOnAlly                             = {},
	Roulette_itemUseOnEnemy                            = {},
	Roulette_itemUseOnGun                              = {},
	--- @deprecated
	Roulette_itemUseOnItem                             = {},
	Roulette_itemUseOnSelf                             = {},
	Roulette_itemUseOnSelfItem                         = {},
	Roulette_itemUseOnOpponent                         = {
		const.bool("canBeAlly", false),
	},
	Roulette_itemUseOnOpponentItem                     = {
		const.bool("canBeAlly", false),
		depend("Roulette_itemUseAllowTargetOpponentItem"),
	},
	Roulette_itemUseParticle                           = {
		--- one of following string: "target" / "user" / "entity".
		const.string("evTarget", "target"),
		const.string("type"),
		const.string("texture"),
		const.int("particleCount"),
		const.float("duration"),
		const.float("maxDelay"),
		const.float("fadeDelay"),
		const.float("fadeTime"),
		const.float("minOpacity"),
		const.float("radius"),
		const.float("zVelocity"),
		const.float("gravity"),
	},
	Roulette_itemUseRemoveGunBullet                    = {
		const.int("index", 1),
	},
	Roulette_itemUseSetGamblerDisengage                = {
		field.bool("activation"),
		--- Supposed to be `blank` or `live`
		const.string("field"),
		const.int("gold"),
		const.float("opacityInactive", .5),
		const.localizedString("flyawayInactive", "Activate during your turn"),
		const.string("soundFail", "error"),
		const.localizedString("flyawayActivated", "Already activated"),
		const.string("soundActivated", "spellGeneral"),
		const.localizedString("flyawayPoor", "Not enough golds"),
		const.localizedString("flyawaySuccess"),
	},
	Roulette_itemUseSetGamblersFear                    = {},
	Roulette_itemUseSetGamblerFreeze                   = {
		const.int("turns", 2),
	},
	Roulette_itemUseSetGamblerShield                   = {
		const.float("turns", 1),
		--- Add this additional turns to ally behind of user.
		const.float("allyBuff", .25),
	},
	Roulette_itemUseSetGamblerSilence                  = {
		const.int("turns", 3),
	},
	Roulette_itemUseSetGamblersFreeze                  = {
		const.int("turns", 2),
	},
	Roulette_itemUseSetGunDamageDouble                 = {},
	Roulette_itemUseSkipTurn                           = {},
	Roulette_itemUseSteal                              = {},
	Roulette_itemUseTellGunBullet                      = {
		const.table("indices", { 1 }),
	},
	Roulette_itemUseTellGunBulletFlyaway               = {
		const.bool("focusedOnly", true),
		const.localizedString("fallback"),
		const.localizedString("format"),
		const.table("texts"),
		const.table("parameters", defaultFlyawayParameters),
	},
	Roulette_itemUseSound                              = {
		const.string("sound"),
	},
	Roulette_itemUseTransmuteBullet                    = {
		const.int("count", 1),
		--- @depreciated
		const.table("map", Roulette_itemUseTransmuteBullet_map),
	},
	Roulette_itemUseUpdateAI                           = {},
	Roulette_itemUseUserHop                            = {},
	Roulette_itemUseVocalize                           = {
		const.string("suffix"),
	},
	Roulette_judge                                     = {
		--- Game has started, or was processing next turn/round.
		--- Depreciate: `field.bool("started")`. Use `RouletteJudge.hasStarted(entity.Roulette_judge)` instead!
		field.enum("flags", RouletteJudge.Flag),
		--- Turn number.
		field.int("turn"),
		--- Round number.
		field.int("round"),
		--- Gambler entity ids.
		field.table("gamblers"),
		--- Gambler entity id in current turn.
		field.int("gamblerIndex"),
		--- Gambler positions.
		const.table("locations"),
		--- Gun entity id.
		field.entityID("gun"),
		--- center position x, used for gun.
		const.int("x", 0),
		--- center position y, used for gun.
		const.int("y", 3),
		const.enum("winCondition", RouletteJudge.WinCondition, RouletteJudge.WinCondition.LastOneStand),
	},
	Roulette_judgeAllocItems                           = {
		field.int("generationIndex"),
		const.bool("teamBased"),
		--- Item bonuses for defensive position in first round.
		const.int("bonus", 1),
		const.table("itemCounts", Roulette_judgeAllocItems_itemCounts),
		const.enum("placementMask", Collision.Type, Collision.Group.ITEM_PLACEMENT),
	},
	Roulette_judgeAutoStart                            = {
		const.int("startMinimumGamblers", 2),
	},
	Roulette_judgeEndTeleport                          = {},
	Roulette_judgeFillBots                             = {
		const.string("type"),
	},
	Roulette_judgeFlyawayEndGame                       = {
		const.localizedString("format", "Winner: %s"),
		const.table("parameters", defaultFlyawayParameters),
	},
	Roulette_judgeFlyawayNextRound                     = {
		const.localizedString("format", "Round %s"),
		const.table("parameters", defaultFlyawayParameters),
	},
	Roulette_judgeGun                                  = {
		const.string("type", "Roulette_Gun"),
		const.table("attributes"),
	},
	Roulette_judgeHintLabelOnCursor                    = {
		const.localizedString("format", "Round %s\n%s's turn"),
		const.float("offsetY", -26),
	},
	Roulette_judgeNewRoundInitiatorTurn                = {},
	Roulette_judgeRandomizeGamblerOrders               = {},
	Roulette_judgeRogue                                = {
		const.string("soundStart", "Roulette_matchStart"),
	},
	Roulette_judgeRogueGamblerOrders                   = {},
	Roulette_lobby                                     = {},
	--- Tag component, used for gun visual in restricted mode.
	Roulette_plasmaCannon                              = {},
	Roulette_ring                                      = {
		field.bool("equipped", false),
	},
	Roulette_rogueBag                                  = {
		field.bool("opened"),
		const.int("gridWidth", 3),
		const.table("itemComponents", { "Roulette_rogueItemSlot" }),
		depend("item"),
	},
	Roulette_rogueBeatDelayOverride                    = {
		const.int("interval", 1),
		depend("beatDelay"),
	},
	Roulette_rogueCharmNazar                           = {},
	Roulette_rogueHealthOverride                       = {
		const.int("health"),
		depend("health"),
	},
	Roulette_rogueItemArmor                            = {
		field.int("durability"),
		const.int("maximumDurability"),
		const.string("texture", "mods/Roulette/gfx/durability.png"),
	},
	Roulette_rogueItemPoolChest                        = {
		const.int("weight"),
		const.string("chestType", "ChestPurple"),
	},
	Roulette_rogueItemPoolShop                         = {
		const.bool("advanced"),
		const.int("weight"),
		const.int("basePrice"),
	},
	Roulette_rogueItemSlot                             = {
		const.string("slotName", ItemSlot.Type.ACTION),
	},
	Roulette_rogueLowHealthConvert                     = {
		const.table("targetTypes"),
	},
	Roulette_rogueLowHealthLockMaximum                 = {
		const.int("health", 1),
		depend("health"),
	},
	Roulette_rogueModeSuppressCastOnDeath              = {
		depend("castOnDeath")
	},
	Roulette_rogueModeEntityReplaceOnLevelLoad         = {
		const.string("type"),
	},
	Roulette_rogueModeParryFlyawayOverride             = {
		const.localizedString("text", "Dodge!"),
	},
	Roulette_rogueParticleHeal                         = {
		const.string("texture", "ext/particles/TEMP_particle_heal.png"),
		const.int("particleCount", 25),
		const.float("duration", 2.25),
		const.float("maxDelay", 0.75),
		const.float("fadeDelay", 1),
		const.float("fadeTime", 0.5),
		const.float("minOpacity", 0.6),
		const.float("radius", 12),
		const.float("zVelocity", 75),
		const.float("gravity", -1.8),
	},
	Roulette_rogueShopkeeper                           = {
		field.int("generationIndex"),
		const.float("priceMultiplier", 2),
		field.float("priceMultiplierIncrement", 0),
		const.float("advancedExtraMultiplier", 3),
		field.table("placements"),
		const.table("placementsInitial", Roulette_rogueShopkeeper_placementsInitial),
		const.table("attributes", Roulette_rogueShopkeeper_attributes),
		const.string("spawnJudge", "Roulette_RogueRoomJudgeShop"),
	},
	Roulette_secretShopkeeper                          = {
		const.int("tileX"),
		const.int("tileY"),
	},
	Roulette_selectable                                = {
		field.bool("suppressed"),
		field.entityID("belonging"),
		depend("Roulette_smartCursorTarget"),
	},
	Roulette_shrineOfTime                              = {
		const.string("key", "ShrineOfTime"),
		const.table("scales"),
		const.table("flyaways"),
		field.int("level", 1),
	},
	Roulette_smartCursorTarget                         = {},
	Roulette_spellcastInflictGamblerStatusFreeze       = {
		const.int("turns", 1),
	},
	Roulette_spellcastInflictGamblerStatusShield       = {
		const.int("turns", 1),
	},
	Roulette_spellcastSkipCasterGamblerTurn            = {},
	Roulette_spellcastTargetHostileGamblers            = {},
	Roulette_stealable                                 = {},
	Roulette_textOverlay                               = {
		field.float("lifetime"),
		field.string("text"),
		field.table("lines"),
	},
	Roulette_visibilityHideItemHintLabel               = {
		field.bool("hide"),
	},
	Roulette_visibilityHideItemStackQuantityLabel      = {
		field.bool("hide"),
	},
}
