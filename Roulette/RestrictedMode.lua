local RouletteMenu = require "Roulette.Menu"
local RouletteRestrictedMode = {}

local GameMod = require "necro.game.data.resource.GameMod"
local Settings = require "necro.config.Settings"
local SettingsStorage = require "necro.config.SettingsStorage"
local Translation = require "necro.config.i18n.Translation"

local restrictedByDefault = not GameMod.isPermissive()

SettingRestrictedMode = Settings.entitySchema.bool {
	id = "restricted",
	name = "Restricted Mode",
	default = restrictedByDefault,
	tag = Settings.Tag.ENTITY_SCHEMA,
	visibility = restrictedByDefault and Settings.Visibility.HIDDEN,
}

function RouletteRestrictedMode.isActive()
	return SettingRestrictedMode
end

for _, name in ipairs {
	"Roulette_Gun",
	"Roulette_GunRogue",
} do
	event.entitySchemaLoadNamedEntity.add(nil, {
		key = name,
		sequence = 7e7,
	}, function(ev)
		if not SettingRestrictedMode then
			return
		end

		if ev.entity.Roulette_gunChamberSound then
			ev.entity.Roulette_gunChamberSound.sound = "Roulette_plasmaCannonChamber"
		end
		if ev.entity.Roulette_gunReloadSound then
			ev.entity.Roulette_gunReloadSound.sound = "blunderbussReload"
		end
		if ev.entity.Roulette_gunShotParticle then
			ev.entity.Roulette_gunShotParticle.textureBlank = "mods/Roulette/gfx/plasma_cannon_particle_shell_green.png"
			ev.entity.Roulette_gunShotParticle.textureLive = "mods/Roulette/gfx/plasma_cannon_particle_shell_red.png"
		end
		ev.entity.Roulette_plasmaCannon = {}
		if ev.entity.innateAttack then
			ev.entity.innateAttack.swipe = "Roulette_plasmaCannon"
		end
		ev.entity.sprite = { texture = "mods/Roulette/gfx/plasma_cannon.png", width = 25, height = 37 }
		ev.entity.spriteSheet = {}
	end)
end

for _, name in ipairs {
	"Roulette_ShrineOfGambler",
	"Roulette_ShrineOfGambler2",
	"Roulette_ShrineOfGambler3",
	"Roulette_ShrineOfGambler4",
	"Roulette_ShrineOfGambler5",
} do
	event.entitySchemaLoadNamedEntity.add(nil, {
		key = name,
		sequence = 7e7,
	}, function(ev)
		if not SettingRestrictedMode then
			return
		end

		ev.entity.sprite = { texture = "mods/Roulette/gfx/shrine_gambler_2.png", width = 35, height = 52 }
	end)
end

event.entitySchemaLoadNamedEntity.add(nil, {
	key = "RingCourage",
	sequence = 7e7,
}, function(ev)
	if not SettingRestrictedMode then
		return
	end

	if ev.entity.Roulette_hintLabel then
		ev.entity.Roulette_hintLabel.text = "Self-Shot protection"
	end
end)

RouletteRestrictedMode.Language2StandardTutorialFile = {
	[Translation.Language.BUILT_IN] = "guide_standard_restricted",
	[Translation.Language.SIMPLIFIED_CHINESE] = "guide_standard_zh_cn_restricted",
	[Translation.Language.TRADITIONAL_CHINESE] = "guide_standard_zh_tw_restricted",
}

event.menu.add(nil, {
	key = RouletteMenu.TutorialStandard,
	sequence = -7e7,
}, function(ev)
	if not SettingRestrictedMode then
		return
	end

	ev.Roulette_filename = RouletteRestrictedMode.Language2StandardTutorialFile[Translation.getSessionTranslation()]
		or RouletteRestrictedMode.Language2StandardTutorialFile[Translation.Language.BUILT_IN]
end)

return RouletteRestrictedMode
