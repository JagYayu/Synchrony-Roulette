local Sound = require "necro.audio.Sound"
local SoundGroups = require "necro.audio.SoundGroups"

SoundGroups.register {
	Roulette_gamblerMidJoin = {
		sounds = { "mods/Roulette/sfx/gambler_join.ogg" },
		volume = 2,
	},
	Roulette_gunChamber = {
		sounds = { "mods/Roulette/sfx/shotgun_cycle.ogg" },
		volume = .3,
		pitch = .5,
	},
	Roulette_gunReload = {
		sounds = { "mods/Roulette/sfx/shotgun_reload.ogg" },
		volume = .4,
	},
	Roulette_gunShot = {
		sounds = { "mods/Roulette/sfx/gun_shot.ogg" },
		volume = .4,
	},
	Roulette_matchStart = {
		sounds = { "mods/Roulette/sfx/match_start.ogg" },
		volume = 2,
	},
	Roulette_necromancySkeleton = {
		sounds = { "mods/Roulette/sfx/skeleton_rise.ogg" },
		volume = 2,
	},
	Roulette_plasmaCannonChamber = {
		sounds = { "mods/Roulette/sfx/plasma_cannon_cycle.ogg" },
		volume = 1.5,
	},
	Roulette_spellCharm = {
		sounds = { "mods/Roulette/sfx/sfx_charmspell_activate.ogg" },
		volume = .5,
	},
}
