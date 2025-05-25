local RouletteCoreEntities = require "Roulette.data.CommonEntities"
local RouletteGambler = require "Roulette.Gambler"
local RouletteGame = require "Roulette.Game"
local RouletteLobbyEntities = {}

local Action = require "necro.game.system.Action"
local CustomEntities = require "necro.game.data.CustomEntities"
local Collision = require "necro.game.tile.Collision"
local Color = require "system.utils.Color"
local CommonShrine = require "necro.game.data.object.CommonShrine"
local Damage = require "necro.game.system.Damage"
local Utilities = require "system.utils.Utilities"

function RouletteLobbyEntities.registerGamblerShrine(name, extras)
	local components = Utilities.mergeTablesRecursive({
		Roulette_cameraRectRaycast = {},
		Roulette_judge = {},
		Roulette_judgeAllocItems = {},
		Roulette_judgeAutoStart = {},
		Roulette_judgeEndTeleport = {},
		Roulette_judgeFlyawayEndGame = {},
		Roulette_judgeFlyawayNextRound = {},
		Roulette_judgeGun = {},
		Roulette_judgeHintLabelOnCursor = {},
		Roulette_judgeRandomizeGamblerOrders = {},

		random = {},
		sprite = { texture = "mods/Roulette/gfx/shrine_gambler.png" },
	}, extras, 2)

	RouletteGambler.addShrineHandler(name)
	return CommonShrine.registerShrine(name, components)
end

local red = Color.rgb(0xff, 0x69, 0x61)
local blue = Color.rgb(0x87, 0xce, 0xfa)
RouletteLobbyEntities.registerGamblerShrine("Gambler", {
	Roulette_judge = {
		locations = {
			{ -3, 3, red },
			{ 3,  3, blue },
		},
	},

	friendlyName = { name = "Shrine of Gambler (Small)" },
})

local green = Color.rgb(0x90, 0xee, 0x90)
local yellow = Color.rgb(0xff, 0xff, 0xe0)
RouletteLobbyEntities.registerGamblerShrine("Gambler2", {
	Roulette_judge = {
		locations = {
			{ -3, 3, red },
			{ 3,  3, blue },
			{ -3, 0, green },
			{ 3,  0, yellow },
		},
	},

	friendlyName = { name = "Shrine of Gambler" },
})

local orange = Color.rgb(0xff, 0xa5, 0x00)
local purple = Color.rgb(0x80, 0x00, 0x80)
local brown = Color.rgb(0xa5, 0x2a, 0x2a)
local gray = Color.rgb(0x80, 0x80, 0x80)
RouletteLobbyEntities.registerGamblerShrine("Gambler3", {
	Roulette_judge = {
		locations = {
			{ -3, 6, red },
			{ 3,  6, blue },
			{ 0,  3, green },
			{ 0,  9, yellow },
			{ -3, 3, orange },
			{ 3,  3, purple },
			{ -3, 9, brown },
			{ 3,  9, gray },
		},
		y = 6,
	},

	friendlyName = { name = "Shrine of Gambler (Large)" },
})

RouletteLobbyEntities.registerGamblerShrine("Gambler4", {
	Roulette_judge = {
		locations = {
			{ -3, 3, red },
			{ 3,  3, blue },
		},
	},
	Roulette_judgeAutoStart = { startMinimumGamblers = 1 },
	Roulette_judgeFillBots = { type = "Roulette_Necrodancer" },

	friendlyName = { name = "Shrine of Gambler (Bots, Small)" },
})

RouletteLobbyEntities.registerGamblerShrine("Gambler5", {
	Roulette_judge = {
		locations = {
			{ -3, 3, red },
			{ 3,  3, blue },
			{ -3, 0, green },
			{ 3,  0, yellow },
		},
	},
	Roulette_judgeAutoStart = { startMinimumGamblers = 1 },
	Roulette_judgeFillBots = { type = "Roulette_Necrodancer" },

	friendlyName = { name = "Shrine of Gambler (Bots)" },
})

--- @diagnostic disable
CustomEntities.extend {
	name = "Roulette_Necrodancer",
	template = CustomEntities.template.enemy "necrodancer",
	components = {
		Roulette_aiGamblerDeprecated = {},
		Roulette_gamblerEndGameCast = { spell = "SpellcastDisappearLeprechaun" },
		Roulette_gamblerVibrateEffect = false,

		facingMirrorX = {
			directions = {
				[1] = 1,
				[2] = 1,
				[4] = -1,
				[5] = -1,
				[6] = -1,
				[8] = 1,
			}
		},
		friendlyName = { name = "Dealer" },

		beatDelay = false,
		innateSpellcasts = false,
		necrodancer = false,
		provokable = false,
		provokableConvert = false,
		voiceProvoke = false,
	},
	modifier = RouletteCoreEntities.makeGambler,
}

CustomEntities.register {
	name = "Roulette_Gun",

	Roulette_selectable = {},
	Roulette_gun = {},
	Roulette_gunChamberSound = {},
	Roulette_gunHintLabelOnCursor = {},
	Roulette_gunReloadAmounts = {},
	Roulette_gunReloadFlyaway = {},
	Roulette_gunReloadFlyawayOverlayText = {},
	Roulette_gunReloadSound = {},
	Roulette_gunShotParticle = {},
	Roulette_gunStatusDamageCombo = {},
	Roulette_gunStatusDamageDouble = {},
	Roulette_gunShotSound = {},
	Roulette_itemUseNoDeletion = {},
	Roulette_itemUseUpdateAI = {},

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
	position = {},
	positionalSprite = { offsetY = -12 },
	random = {},
	rowOrder = { z = -24 },
	setFacingOnMove = {},
	sprite = { texture = "ext/items/weapon_blunderbuss.png", width = 25, height = 36 },
	shadow = {},
	shadowPosition = {},
	tween = {},
	visibility = {},
}

CustomEntities.register {
	name = "Roulette_Lobby",

	Roulette_lobby = {},

	gameObject = {},
	position = {},
}

CustomEntities.register {
	name = "Roulette_Barrier",

	Roulette_convertOnLevelLoad = { entityType = "Roulette_BarrierBaked" },

	collision = { mask = Collision.Type.PREBOSS },
	position = {},
	positionalSprite = {},
	sprite = { texture = "mods/Roulette/gfx/barrier.png" },
	visibility = {},
	visibilityAlwaysVisible = {},
}

CustomEntities.register {
	name = "Roulette_BarrierBaked",
	collision = { mask = Collision.Type.PREBOSS },
	position = {},
}

CustomEntities.register {
	name = "Roulette_TriggerRogueMode",
	editorHidden = {},
	lightSource = {},
	lightSourceRadial = { innerRadius = 320, outerRadius = 768 },
	position = {},
	positionalSprite = { offsetY = 12 },
	rowOrder = { z = -995 },
	sprite = { texture = "ext/level/stairs.png" },
	worldLabel = { text = "All Zones Gambling" },
	worldLabelTextPool = { key = "mod.Roulette.label.triggerRogue" },
	trap = {},
	trapClientTrigger = {},
	trapConfirmation = {},
	trapStartRun = { mode = RouletteGame.RogueMode },
	visibility = {},
}

return RouletteLobbyEntities
