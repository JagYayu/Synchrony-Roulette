local RouletteCommonEntities = require "Roulette.data.CommonEntities"
local RouletteGun = require "Roulette.Gun"
local RouletteJudge = require "Roulette.Judge"
local RouletteLocalization = require "Roulette.data.Localization"

local Action = require "necro.game.system.Action"
local CommonShrine = require "necro.game.data.object.CommonShrine"
local CustomEntities = require "necro.game.data.CustomEntities"
local Damage = require "necro.game.system.Damage"
local Move = require "necro.game.system.Move"
local StringUtilities = require "system.utils.StringUtilities"
local Utilities = require "system.utils.Utilities"

event.entitySchemaLoadNamedEntity.add("shopkeeper", "Shopkeeper", function(ev)
	RouletteCommonEntities.makeGambler(ev.entity)
	ev.entity.Roulette_gambler = { initiative = 3 }
	ev.entity.Roulette_aiGamblerDeprecated = { actionDelay = .4, actionDelayRandomize = false }
	ev.entity.Roulette_enemy = { skirmishSquareDistance = .75 }
	ev.entity.Roulette_rogueShopkeeper = {}
	ev.entity.Roulette_rogueHealthOverride = { health = 8 }
end)

event.entitySchemaLoadNamedEntity.add("shopkeeper5", "Shopkeeper5", function(ev)
	ev.entity.Roulette_rogueModeEntityReplaceOnLevelLoad = { type = "Shopkeeper" }
end)

event.entitySchemaLoadNamedEntity.add("shovelBasic", "ShovelBasic", function(ev)
	ev.entity.Roulette_rogueModeEntityReplaceOnLevelLoad = false
end)

event.entitySchemaLoadEntity.add("rogueModeLevelEntity", "finalize", function(ev)
	local e = ev.entity
	if e.Roulette_rogueModeEntityReplaceOnLevelLoad == nil
		and not e.attachment
		and not e.playableCharacter
		and not e.wallLight
		and not e.Roulette_rogueShopkeeper
		and not StringUtilities.startsWith(e.name, "Roulette_")
	then
		e.Roulette_rogueModeEntityReplaceOnLevelLoad = {}
	end
end)

-- register enemies
for _, entry in ipairs(require "Roulette.data.RogueEnemies".list) do
	event.entitySchemaLoadNamedEntity.add(nil, entry[1], function(ev)
		RouletteCommonEntities.makeGambler(ev.entity)

		ev.entity.Roulette_gamblerColor = { fade = 0 }
		ev.entity.Roulette_gamblerCursor = { type = "Roulette_CursorEnemy" }
		ev.entity.Roulette_gamblerMidJoinSound = {}
		ev.entity.Roulette_gamblerTeamVanilla = {}
		ev.entity.Roulette_rogueParticleHeal = {}
		ev.entity.Roulette_textOverlay = {}

		if ev.entity.beatDelay then
			ev.entity.Roulette_gamblerBeatDelay = {}
		end
		if ev.entity.boss or ev.entity.enemyPoolMiniboss then
			ev.entity.Roulette_gamblerVibrateEffect = {}
		else
			ev.entity.Roulette_gamblerCharmable = {}
		end
		if ev.entity.enemyPoolMiniboss then
			ev.entity.Roulette_enemyPoolMiniboss = {}
		end
		if ev.entity.enemyPoolNormal then
			ev.entity.Roulette_enemyPoolNormal = {}
		end
		if ev.entity.knockbackable then
			ev.entity.Roulette_gamblerBackToPreviousTileLaterOnKnockback = {}
		end

		for k, v in pairs(entry[2]) do
			ev.entity[k] = v
		end
	end)
end

event.entitySchemaGenerate.add("generateSkeletonHeadless", "customEntities", function(ev)
	for _, entity in ipairs(ev.entityTypes) do
		if entity.name == "Skeleton2Headless" then
			local e = Utilities.fastCopy(entity)
			e.name = "Roulette_SkeletonHeadless"
			e.friendlyName = { name = "Skeleton (Headless)" }

			e.beatDelay = { interval = 1 }
			e.health = { maxHealth = 1 }
			e.sprite = { texture = "mods/Roulette/gfx/skeleton_headless.png", height = 28 }
			e.spriteSheet = { frameX = 1 }
			e.normalAnimation = false
			e.tellAnimation = false

			ev.entityTypes[#ev.entityTypes + 1] = e
			return
		end
	end
end)

event.entitySchemaGenerate.add("generateGhoulHallucination", "customEntities", function(ev)
	for _, entity in ipairs(ev.entityTypes) do
		if entity.name == "GhoulHallucination" then
			local e = Utilities.fastCopy(entity)
			e.name = "Roulette_GhoulHallucination"

			e.killable = {}
			e.soundDeath = { sound = "generalHit" }
			e.tween = {}

			ev.entityTypes[#ev.entityTypes + 1] = e
			return
		end
	end
end)

--- @diagnostic disable: missing-fields

CustomEntities.register {
	name = "Roulette_CursorEnemy",

	Roulette_cursor = {},
	Roulette_cursorInteract = {},

	movable = { moveType = Move.Type.SLIDE },
	position = {},
	positionalSprite = { offsetY = 12 },
	rowOrder = { z = -24 },
	sprite = { texture = "mods/Roulette/gfx/cursor.png" },
	tween = { duration = .097 },
	visibility = {},
}

local definitionJudge = {
	name = "Roulette_RogueRoomJudge",

	Roulette_cameraRectFixed = {},
	Roulette_haunted = {},
	Roulette_judge = {
		x = 0,
		y = 0,
		winCondition = RouletteJudge.WinCondition.TeamWork,
	},
	Roulette_judgeAllocItems = {
		bonus = 0,
		itemCounts = {
			{ 1, 2 },
			{ 1, 3 },
			{ 2, 3 },
			{ 2, 4 },
			{ 3, 4 },
			{ 3, 6 },
			{ 4, 6 },
		},
		teamBased = true,
	},
	Roulette_judgeFlyawayNextRound = {},
	Roulette_judgeGun = { type = "Roulette_GunRogue" },
	Roulette_judgeNewRoundInitiatorTurn = {},
	Roulette_judgeRandomizeGamblerOrders = {},
	Roulette_judgeRogue = {},
	Roulette_judgeRogueGamblerOrders = {},

	random = {},
	position = {},
	positionalSprite = {},
	sprite = { texture = "mods/Roulette/gfx/room.png" },
	visibility = {},
	visibilityAlwaysHidden = {},
}
CustomEntities.register(definitionJudge)
CustomEntities.register(definitionJudge, {
	name = "Roulette_RogueRoomJudgeShop",

	Roulette_haunted = false,
})

CustomEntities.register {
	name = "Roulette_GunRogue",

	Roulette_gun = {},
	Roulette_gunBurntParticle = {},
	Roulette_gunChamberSound = {},
	Roulette_gunHintLabelOnCursor = { text = "%s damage\nUse on enemy or self" },
	Roulette_gunReloadAmounts = {
		bulletBlank = RouletteGun.Bullet.UncertainBlank,
		bulletLive = RouletteGun.Bullet.UncertainLive,
		list = {
			{ 2, 3 },
			{ 2, 4 },
			{ 2, 5 },
			{ 3, 5 },
			{ 4, 6 },
			{ 4, 7 },
			{ 4, 8 },
		},
		livePctMin = .25,
		livePctMax = .75,
	},
	Roulette_gunReloadFlyaway = {},
	Roulette_gunReloadFlyawayOverlayText = {},
	Roulette_gunReloadSound = {},
	Roulette_gunShotParticle = {},
	Roulette_gunStatusBurnt = {},
	Roulette_gunStatusDamageCombo = {},
	Roulette_gunStatusDamageDouble = {},
	Roulette_gunShotSound = {},
	Roulette_itemUseNoDeletion = {},
	Roulette_itemUseUpdateAI = {},
	Roulette_selectable = {},

	facingMirrorX = {
		directions = {
			[Action.Direction.RIGHT] = -1,
			[Action.Direction.UP_RIGHT] = -1,
			[Action.Direction.UP_LEFT] = 1,
			[Action.Direction.LEFT] = 1,
			[Action.Direction.DOWN_LEFT] = 1,
			[Action.Direction.DOWN_RIGHT] = -1,
		}
	},
	hoverEffect = {},
	hoverEffectAlwaysEnabled = {},
	innateAttack = {
		damage = 1,
		type = Damage.Flag.BYPASS_INVINCIBILITY,
		swipe = "Roulette_gun",
	},
	lightSource = {},
	lightSourceRadial = {
		innerRadius = 768,
		outerRadius = 2468,
	},
	position = {},
	positionalSprite = { offsetY = -12 },
	setFacingOnMove = {},
	random = {},
	rowOrder = { z = -24 },
	sprite = { texture = "ext/items/weapon_blunderbuss.png", width = 25, height = 36 },
	shadow = {},
	shadowPosition = {},
	tween = {},
	visibility = {},
	visionRaycast = {},
}

CustomEntities.register {
	name = "Roulette_ItemBatMinibossFangs",
	Roulette_itemCharge = { charged = 999 },
	Roulette_itemGamblerHealOnKill = { mustBeHostile = false },
	item = {},
	itemSlot = { name = "misc" },
}
CustomEntities.register {
	name = "Roulette_ShadowSource",
	lightSource = {},
	shadowSource = { radius = 1535 },
	position = {},
}

CommonShrine.registerShrine("DelayEventTimeScaler", {
	Roulette_shrineOfTime = {
		scales = { 1, .67, .33 },
		flyaways = { RouletteLocalization.TimeShrine_1, RouletteLocalization.TimeShrine_2, RouletteLocalization.TimeShrine_3 },
	},
	editorHidden = {},
	friendlyName = { name = "" },
	persistent = {},
	priceTag = false,
	priceTagCostCurrency = false,
	priceTagLabel = false,
	priceTagShopkeeperProximity = false,
	priceTagShopliftable = false,
	sprite = { texture = "ext/level/shrine_rhythm.png" },
	lightSource = {},
	lightSourceRadial = { outerRadius = 768 },
})

CustomEntities.extend {
	name = "Roulette_Transmogrifier",
	template = CustomEntities.template.enemy "transmogrifier",
	components = {
		Roulette_secretShopkeeper = {},
		secretShopkeeper = false,
	},
}
