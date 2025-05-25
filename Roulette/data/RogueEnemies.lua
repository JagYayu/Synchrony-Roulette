local RouletteRogueAI = require "Roulette.RogueAI"

local Utilities = require "system.utils.Utilities"

local traitSillyDefaultComponent = {
	traits = {
		itemUsages = {
			"control",
			"health",
			"defensive",
			"tellFirst",
			"tellRest",
			"transmute",
			"offensive",
			"retreat",
			"steal",
		},
		chooseOpponent = RouletteRogueAI.Implements.ChooseOpponent.HostileHigherHealth,
		controlItemsCleanup = 3,
		defensiveItemThreshold = .34,
		healthItemThreshold = .5,
		offensiveItemMax = 5,
		retreatItemCleanup = 0,
	}
}
--- @param component Component.Roulette_aiGamblerRogue
local function silly(component)
	return Utilities.mergeTablesRecursive(Utilities.fastCopy(traitSillyDefaultComponent), component, 2)
end

local traitNormalDefaultComponent = {
	traits = {
		itemFilterLethal = true,
		itemUsages = {
			"control",
			"health",
			"defensive",
			"steal",
			"tellFirst",
			"tellRest",
			"transmute",
			"offensive",
			"retreat",
		},
		chooseOpponent = RouletteRogueAI.Implements.ChooseOpponent.HostileLowerHealth,
		controlItemsCleanup = 1,
		defensiveItemThreshold = .5,
		healthItemThreshold = .75,
		offensiveItemMax = 1,
		retreatItemCleanup = 2,
		stealItemMax = 2,
		tellFirstItemNoWaste = true,
	},
}
--- @param component Component.Roulette_aiGamblerRogue
local function normal(component)
	return Utilities.mergeTablesRecursive(Utilities.fastCopy(traitNormalDefaultComponent), component, 2)
end

local traitBetterDefaultComponent = {
	traits = {
		itemFilterLethal = true,
		itemUsages = {
			"steal",
			"control",
			"health",
			"defensive",
			"tellFirst",
			"tellRest",
			"retreat",
		},
		chooseOpponent = RouletteRogueAI.Implements.ChooseOpponent.HostileLowerHealth,
		chooseOpponentRealTeam = true,
		conjectureBullets = true,
		followItemUseLimit = true,
		controlItemsCleanup = 1,
		defensiveItemThreshold = 1,
		healthItemPreferMatch = true,
		healthItemThreshold = 1,
		retreatItemCleanup = 4,
		stealItemMax = 8,
		tellFirstItemNoWaste = true,
		tellRestItemNoWaste = true,
		gunShootUseOffensiveItemsAffirmative = true,
		gunShootUseTransmuteItems = true,
		gunShootUseOffensiveItems = true,
	},
}
--- @param component Component.Roulette_aiGamblerRogue
local function smarter(component)
	return Utilities.mergeTablesRecursive(Utilities.fastCopy(traitBetterDefaultComponent), component, 2)
end

--- @diagnostic disable: missing-fields

local aiApparition = silly { traits = { gunShoot = .33 } }
local aiBat = silly {
	traits = {
		chooseOpponent = RouletteRogueAI.Implements.ChooseOpponent.Random,
		gunShoot = 1,
	},
}
local aiGhost = silly { traits = { gunShoot = .49 } }
local aiMonkey = smarter { traits = { gunShoot = .5 } }
local aiSkeleton = silly { traits = { gunShoot = .49 } }
local aiSkeletonHeadless = silly {
	traits = {
		gunShoot = .49,
		defensiveItemThreshold = 2,
		healthItemThreshold = 2,
	}
}
local aiSlime = silly {
	traits = {
		gunShoot = -1,
	}
}
local aiZombie = silly {
	traits = {
		gunShoot = 1,
	}
}

--- @type table<string, Entity | table<string, false>>
local z1 = {
	Bat = {
		Roulette_aiGamblerRogue = aiBat,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gamblerCurrency = { amount = 4 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "HolyWater" } },
	},
	Bat2 = {
		Roulette_aiGamblerRogue = aiBat,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gamblerCurrency = { amount = 4 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "HolyWater" } },
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Ghost = {
		Roulette_aiGamblerRogue = aiGhost,
		Roulette_enemyPoolZ1 = {},
		Roulette_gamblerCurrency = { amount = 7 },
		Roulette_gamblerGhostStasis = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Monkey = {
		Roulette_aiGamblerRogue = aiMonkey,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 7 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_MonkeyPaw" } },
		Roulette_gamblerEndTurnStealItems = {},
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueBeatDelayOverride = { interval = 2 },
	},
	Monkey2 = {
		Roulette_aiGamblerRogue = aiMonkey,
		Roulette_enemyPoolZ1 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 7 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_MonkeyPaw" } },
		Roulette_gamblerEndTurnStealItems = {},
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueBeatDelayOverride = { interval = 2 },
	},
	Skeleton = {
		Roulette_aiGamblerRogue = aiSkeleton,
		Roulette_enemyPool = { weight = 25 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gambler = { itemDistributionMultiplier = .5 },
		Roulette_gamblerCurrency = { amount = 5 },
		Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
		Roulette_rogueHealthOverride = { health = 2 },
		Roulette_rogueLowHealthConvert = { targetTypes = { [1] = "Roulette_SkeletonHeadless" } },
		Roulette_rogueLowHealthLockMaximum = {},
	},
	Roulette_SkeletonHeadless = {
		Roulette_aiGamblerRogue = aiSkeletonHeadless,
		Roulette_enemy = {},
		Roulette_gambler = { itemDistributionMultiplier = .5 },
		Roulette_gamblerCurrency = {},
		Roulette_gamblerVibrateEffect = false,
	},
	Skeleton2 = {
		Roulette_aiGamblerRogue = aiSkeleton,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gambler = { itemDistributionMultiplier = .5 },
		Roulette_gamblerCurrency = { amount = 5 },
		Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
		Roulette_rogueHealthOverride = { health = 3 },
		Roulette_rogueLowHealthLockMaximum = {},
	},
	Skeleton2Headless = {
		Roulette_aiGamblerRogue = aiSkeletonHeadless,
		Roulette_enemy = {},
		Roulette_gamblerCurrency = {},
		Roulette_rogueLowHealthLockMaximum = {},
		Roulette_gamblerVibrateEffect = false,
	},
	Skeleton3 = {
		Roulette_aiGamblerRogue = aiSkeleton,
		Roulette_enemyPool = { weight = 75 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gambler = { initiative = 1, itemDistributionMultiplier = .5 },
		Roulette_gamblerCurrency = { amount = 5 },
		Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
		Roulette_rogueLowHealthLockMaximum = {},
	},
	Skeleton3Headless = {
		Roulette_aiGamblerRogue = aiSkeletonHeadless,
		Roulette_enemy = {},
		Roulette_gamblerCurrency = {},
		Roulette_rogueLowHealthLockMaximum = {},
		Roulette_gamblerVibrateEffect = false,
	},
	Slime = {
		Roulette_aiGamblerRogue = aiSlime,
		Roulette_enemyPool = { weight = 50 },
		Roulette_gamblerCurrency = { amount = 2 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Food1", "Food2", "Food3", "Food4" } },
		Roulette_enemyPoolZ1 = {},
	},
	Slime2 = {
		Roulette_aiGamblerRogue = aiSlime,
		Roulette_enemyPool = { weight = 75 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gamblerCurrency = { amount = 2 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Food1", "Food2", "Food3", "Food4" } },
		Roulette_rogueBeatDelayOverride = { interval = 1 },
	},
	Slime3 = {
		Roulette_aiGamblerRogue = aiSlime,
		Roulette_enemyPool = { weight = 75 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gamblerCurrency = { amount = 2 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Food1", "Food2", "Food3", "Food4" } },
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Wraith = {
		Roulette_aiGamblerRogue = aiApparition,
		Roulette_apparition = {},
		Roulette_enemyPoolZ1 = {},
		Roulette_gamblerCurrency = { amount = 1 },
		Roulette_gamblerEndGameDelete = {},
	},
	Zombie = {
		Roulette_aiGamblerRogue = aiZombie,
		Roulette_enemyPoolZ1 = {},
		Roulette_gamblerCurrency = { amount = 5 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Drum" } },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
}

local aiArmadillo = normal {
	traits = {
		defensiveItemThreshold = 0,
		gunShot = .49,
		itemUsages = {
			"defensive",
			"health",
			"steal",
			"control",
			"tellFirst",
			"tellRest",
			"transmute",
			"offensive",
			"retreat",
		},
	}
}
local aiArmoredskeleton = aiSkeleton
local aiClone = silly { type = RouletteRogueAI.Type.Clone }
local aiGolem = silly { traits = { gunShot = .25 } }
local aiMushroom = normal { traits = { gunShot = .33 } }
local aiSkeletonmage = smarter { traits = { gunShot = .5 } }

local deathDropSkeletonmage = {
	chance = .2,
	entityTypes = {
		"Roulette_TomeFreeze",
		"Roulette_TomeShield",
		"Roulette_TomeTransmute",
		"Roulette_TomeFireball",
		"Roulette_TomeConvertBlankShell",
		"Roulette_TomeConvertLiveShell",
		"Roulette_TomeCharm",
		"Roulette_TomeSilence",
	},
}

--- @type table<string, Entity | table<string, false>>
local z2 = {
	Armadillo = {
		Roulette_aiGamblerRogue = aiArmadillo,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 5 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "ScrollShield" } },
		Roulette_gamblerShieldOnTakeDamage = {},
		Roulette_gamblerStunOnTakeDamage = {},
		Roulette_rogueHealthOverride = { health = 2 },
		Roulette_rogueBeatDelayOverride = { interval = 2 },
	},
	Armadillo2 = {
		Roulette_aiGamblerRogue = aiArmadillo,
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 5 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "ScrollShield" } },
		Roulette_gamblerShieldOnTakeDamage = {},
		Roulette_gamblerStunOnTakeDamage = {},
		Roulette_rogueHealthOverride = { health = 3 },
		Roulette_rogueBeatDelayOverride = { interval = 2 },
	},
	Armoredskeleton = {
		Roulette_aiGamblerRogue = aiArmoredskeleton,
		Roulette_enemyPool = { weight = 25 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 7 },
		Roulette_gamblerConvertOnTakeDamage = { targetType = "Skeleton" },
		Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Armoredskeleton2 = {
		Roulette_aiGamblerRogue = aiArmoredskeleton,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 7 },
		Roulette_gamblerConvertOnTakeDamage = { targetType = "Skeleton2" },
		Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Armoredskeleton3 = {
		Roulette_aiGamblerRogue = aiArmoredskeleton,
		Roulette_enemyPool = { weight = 75 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerConvertOnTakeDamage = { targetType = "Skeleton3" },
		Roulette_gamblerCurrency = { amount = 7 },
		Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
	},
	Clone = {
		Roulette_aiGamblerRogue = aiClone,
		Roulette_enemyPoolZ2 = {},
		Roulette_gambler = { initiative = -1 },
		Roulette_gamblerCurrency = { amount = 1 },
		Roulette_gamblerDeathDrop = { entityTypes = { "Roulette_ScrollDuplicate" } },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueHealthOverride = { health = 0 },
	},
	Golem = {
		Roulette_aiGamblerRogue = aiGolem,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_rogueBeatDelayOverride = { interval = 3 },
		Roulette_rogueHealthOverride = { health = 5 },
	},
	Golem2 = {
		Roulette_aiGamblerRogue = aiGolem,
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_rogueBeatDelayOverride = { interval = 3 },
		Roulette_rogueHealthOverride = { health = 6 },
	},
	Mushroom = {
		Roulette_aiGamblerRogue = aiMushroom,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 6 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_CursedPotion" } },
		Roulette_gamblerNewRoundHeal = {},
		Roulette_rogueBeatDelayOverride = { interval = 2 },
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Mushroom2 = {
		Roulette_aiGamblerRogue = aiMushroom,
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 6 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_CursedPotion" } },
		Roulette_gamblerNewRoundHeal = {},
		Roulette_rogueBeatDelayOverride = { interval = 2 },
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Skeletonmage = {
		Roulette_aiGamblerRogue = aiSkeletonmage,
		Roulette_enemyPool = { weight = 25 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_gamblerDeathDrop = deathDropSkeletonmage,
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_gamblerNewRoundBonusItems = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Skeletonmage2 = {
		Roulette_aiGamblerRogue = aiSkeletonmage,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_gamblerDeathDrop = deathDropSkeletonmage,
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_gamblerNewRoundBonusItems = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Skeletonmage3 = {
		Roulette_aiGamblerRogue = aiSkeletonmage,
		Roulette_enemyPool = { weight = 75 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_gamblerDeathDrop = deathDropSkeletonmage,
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_gamblerNewRoundBonusItems = {},
	},
	Wight = {
		Roulette_aiGamblerRogue = aiApparition,
		Roulette_apparition = {},
		Roulette_enemyPoolZ2 = {},
		Roulette_gamblerCurrency = { amount = 2 },
		Roulette_gamblerEndGameDelete = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
}

local aiBeetle = aiSkeleton
local aiGoblin = normal {
	traits = { gunShoot = .66 }
}
local aiElemental = normal { traits = { gunShot = .49 } }
local aiHellhound = normal {
	traits = {
		gunShoot = 1,
		conjectureBullets = true,
	}
}
local aiShovemonster = aiApparition
local aiYeti = aiHellhound

--- @type table<string, Entity | table<string, false>>
local z3 = {
	Beetle = {
		Roulette_aiGamblerRogue = aiBeetle,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_ScrollFireball" } },
		Roulette_gamblerShell = {},
		Roulette_gamblerShellBurnGun = {},
		Roulette_gamblerCurrency = { amount = 8 },
	},
	Beetle2 = {
		Roulette_aiGamblerRogue = aiBeetle,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "ScrollFreezeEnemies" } },
		Roulette_gamblerShell = {},
		Roulette_gamblerShellFreezeAttacker = {},
		Roulette_gamblerCurrency = { amount = 8 },
	},
	Goblin = {
		Roulette_aiGamblerRogue = aiGoblin,
		Roulette_enemyPool = { weight = 33 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "BloodDrum" } },
		Roulette_gamblerTurnBasedStasis = {},
		Roulette_gamblerInnateDamageUp = {},
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Goblin2 = {
		Roulette_aiGamblerRogue = aiGoblin,
		Roulette_enemyPool = { weight = 67 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "BloodDrum" } },
		Roulette_gamblerTurnBasedStasis = {},
		Roulette_gamblerInnateDamageUp = {},
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Fireelemental = {
		Roulette_aiGamblerRogue = aiElemental,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerBurnGunOnDeath = {},
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_ScrollFireball" } },
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Ghast = {
		Roulette_aiGamblerRogue = aiApparition,
		Roulette_apparition = {},
		Roulette_enemyPoolZ3 = {},
		Roulette_gamblerCurrency = { amount = 3 },
		Roulette_gamblerEndGameDelete = {},
		Roulette_gamblerStatusShield = { turns = 1.5 },
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Hellhound = {
		Roulette_aiGamblerRogue = aiHellhound,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gamblerBurnGunOnDeath = {},
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_ScrollFireball" } },
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Iceelemental = {
		Roulette_aiGamblerRogue = aiElemental,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "ScrollFreezeEnemies" } },
		Roulette_gamblerFreezeAttackerOnDeath = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Shovemonster = {
		Roulette_aiGamblerRogue = aiShovemonster,
		Roulette_enemyPool = { weight = 33 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 4 },
		Roulette_gamblerInnateArmor = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Shovemonster2 = {
		Roulette_aiGamblerRogue = aiShovemonster,
		Roulette_enemyPool = { weight = 67 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 4 },
		Roulette_gamblerInnateArmor = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Slime4 = {
		Roulette_aiGamblerRogue = aiSlime,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gamblerCurrency = { amount = 3 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Food1", "Food2", "Food3", "Food4" } },
		Roulette_gamblerFreezeAttackerOnDeath = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Slime5 = {
		Roulette_aiGamblerRogue = aiSlime,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gamblerBurnGunOnDeath = {},
		Roulette_gamblerCurrency = { amount = 3 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Food1", "Food2", "Food3", "Food4" } },
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Skeletonknight = {
		Roulette_aiGamblerRogue = aiSkeleton,
		Roulette_enemyPool = { weight = 25 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gamblerConvertOnTakeDamage = { targetType = "Skeleton" },
		Roulette_gamblerCurrency = { amount = 9 },
		Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Skeletonknight2 = {
		Roulette_aiGamblerRogue = aiSkeleton,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gamblerConvertOnTakeDamage = { targetType = "Skeleton2" },
		Roulette_gamblerCurrency = { amount = 9 },
		Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Skeletonknight3 = {
		Roulette_aiGamblerRogue = aiSkeleton,
		Roulette_enemyPool = { weight = 75 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerConvertOnTakeDamage = { targetType = "Skeleton3" },
		Roulette_gamblerCurrency = { amount = 9 },
		Roulette_gamblerLowHealthDeathOnTakePiercingDamage = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Yeti = {
		Roulette_aiGamblerRogue = aiYeti,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ3 = {},
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "ScrollFreezeEnemies" } },
		Roulette_gamblerFreezeAttackerOnDeath = {},
		Roulette_rogueHealthOverride = { health = 2 },
		Roulette_rogueBeatDelayOverride = { interval = 2 },
	},
}

local aiBlademaster = aiSkeletonmage
local aiGoblinBomber = normal {
	traits = {
		gunShoot = .66,
		itemUsages = {
			"tellFirst",
			"bomb",
			"tellRest",
			"health",
			"defensive",
			"control",
			"transmute",
			"offensive",
			"retreat",
			"steal",
		},
	},
}
local aiHarpy = smarter {
	traits = {
		gunShoot = .49,
		retreatItemCleanup = 1,
	},
}
local aiLich = aiBlademaster
local aiTroll = smarter { traits = { gunShoot = .66, } }
local aiWarlock = smarter {
	type = RouletteRogueAI.Type.Warlock,
	traits = {
		chooseOpponent = RouletteRogueAI.Implements.ChooseOpponent.AllieLowerHealth,
		gunShoot = .67,
	}
}

local deathDropLich = {
	chance = .15,
	entityTypes = {
		"ScrollFreeze",
		"ScrollShield",
		"ScrollTransmute",
		"Roulette_ScrollFireball",
		"Roulette_ScrollConvertBlankShell",
		"Roulette_ScrollConvertLiveShell",
		"Roulette_ScrollCharm",
		"Roulette_ScrollSilence",
	},
}

--- @type table<string, Entity | table<string, false>>
local z4 = {
	Bat4 = {
		Roulette_aiGamblerRogue = aiBat,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 6 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "HolyWater" } },
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Blademaster = {
		Roulette_aiGamblerRogue = aiBlademaster,
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Drum" } },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_gamblerParry = {},
		Roulette_rogueHealthOverride = { health = 3 },
		Roulette_rogueModeParryFlyawayOverride = {},
	},
	Blademaster2 = {
		Roulette_aiGamblerRogue = aiBlademaster,
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Drum" } },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_gamblerParry = {},
		Roulette_rogueHealthOverride = { health = 4 },
		Roulette_rogueModeParryFlyawayOverride = {},
	},
	Ghoul = {
		Roulette_aiGamblerRogue = aiApparition,
		Roulette_apparition = {},
		Roulette_enemyPoolZ4 = {},
		Roulette_gamblerCurrency = { amount = 4 },
		Roulette_gamblerEndGameDelete = {},
		Roulette_gamblerGhoul = {},
		Roulette_gamblerMidJoinTurnDelay = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	GhoulHallucination = {
		Roulette_aiGamblerRogue = aiApparition,
		Roulette_gamblerNoItemAllocation = {},
	},
	GoblinBomber = {
		Roulette_aiGamblerRogue = aiGoblinBomber,
		Roulette_enemyPoolZ4 = {},
		Roulette_gamblerCurrency = { amount = 25 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_Bomb" } },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_gamblerNewRoundBonusItem = {},
		Roulette_rogueBeatDelayOverride = { interval = 2 },
		Roulette_rogueHealthOverride = { health = 3 },
		Roulette_rogueModeSuppressCastOnDeath = {},
	},
	Golem3 = {
		Roulette_aiGamblerRogue = aiGolem,
		Roulette_enemyPoolZ4 = {},
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerGolemOoze = {},
		Roulette_rogueHealthOverride = { health = 6 },
	},
	Golem3Gooless = {
		Roulette_aiGamblerRogue = aiGolem,
		Roulette_gamblerCurrency = {},
		Roulette_gamblerGolemOoze = false,
	},
	Harpy = {
		Roulette_aiGamblerRogue = aiHarpy,
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 3, extraActions = 1 },
		Roulette_gamblerCurrency = { amount = 9 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_HeartTransplant" } },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Lich = {
		Roulette_aiGamblerRogue = aiLich,
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = deathDropLich,
		Roulette_gamblerNecromancer = {},
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_gamblerNewRoundBonusItems = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Lich2 = {
		Roulette_aiGamblerRogue = aiLich,
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = deathDropLich,
		Roulette_gamblerNecromancer = { targetType = "Skeleton2" },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_gamblerNewRoundBonusItems = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Lich3 = {
		Roulette_aiGamblerRogue = aiLich,
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = deathDropLich,
		Roulette_gamblerNecromancer = { targetType = "Skeleton3" },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_gamblerNewRoundBonusItems = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Monkey3 = {
		Roulette_aiGamblerRogue = aiMonkey,
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 9 },
		Roulette_gamblerDeathDrop = { chance = .2, entityTypes = { "Roulette_MonkeyPaw" } },
		Roulette_gamblerEndTurnStealItems = { amount = 2 },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueBeatDelayOverride = { interval = 2 },
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Monkey4 = {
		Roulette_aiGamblerRogue = aiMonkey,
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 9 },
		Roulette_gamblerDeathDrop = { chance = .2, entityTypes = { "Roulette_MonkeyPaw" } },
		Roulette_gamblerEndTurnStealItems = { amount = 2 },
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueBeatDelayOverride = { interval = 2 },
		Roulette_rogueHealthOverride = { health = 3 },
	},
	Sarcophagus = {
		Roulette_enemyPool = { weight = 10 },
		Roulette_enemyPoolNormal = {},
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = -1 },
		Roulette_gamblerBeatDelay = { autoReset = false },
		Roulette_gamblerCharmable = false,
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_TomeCharm" } },
		Roulette_gamblerNoItemAllocation = {},
		Roulette_gamblerSpawner = {},
		Roulette_gamblerRigid = {},
		Roulette_gamblerVibrateEffect = false,
		Roulette_rogueBeatDelayOverride = { interval = 3 },
		Roulette_rogueHealthOverride = { health = 4 },
	},
	Sarcophagus2 = {
		Roulette_enemyPool = { weight = 15 },
		Roulette_enemyPoolNormal = {},
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = -1 },
		Roulette_gamblerBeatDelay = { autoReset = false },
		Roulette_gamblerCharmable = false,
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_TomeCharm" } },
		Roulette_gamblerNoItemAllocation = {},
		Roulette_gamblerRigid = {},
		Roulette_gamblerSpawner = { entityType = "Skeleton2" },
		Roulette_gamblerVibrateEffect = false,
		Roulette_rogueBeatDelayOverride = { interval = 3 },
		Roulette_rogueHealthOverride = { health = 4 },
	},
	Sarcophagus3 = {
		Roulette_enemyPool = { weight = 25 },
		Roulette_enemyPoolNormal = {},
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = -1 },
		Roulette_gamblerBeatDelay = { autoReset = false },
		Roulette_gamblerCharmable = false,
		Roulette_gamblerCurrency = { amount = 10 },
		Roulette_gamblerDeathDrop = { chance = .1, entityTypes = { "Roulette_TomeCharm" } },
		Roulette_gamblerNoItemAllocation = {},
		Roulette_gamblerRigid = {},
		Roulette_gamblerSpawner = { entityType = "Skeleton3" },
		Roulette_gamblerVibrateEffect = false,
		Roulette_rogueBeatDelayOverride = { interval = 3 },
		Roulette_rogueHealthOverride = { health = 4 },
	},
	Warlock = {
		Roulette_aiGamblerRogue = aiWarlock,
		Roulette_enemyPoolZ4 = {},
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_gamblerDeathDrop = { chance = .15, entityTypes = { "Roulette_FoodCookie" } },
		Roulette_gamblerHealer = {},
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Warlock2 = {
		Roulette_aiGamblerRogue = aiWarlock,
		Roulette_enemyPoolZ4 = {},
		Roulette_gamblerCurrency = { amount = 8 },
		Roulette_gamblerDeathDrop = { chance = .15, entityTypes = { "Roulette_FoodCookie" } },
		Roulette_gamblerHealer = {},
		Roulette_gamblerNecromancyRevivable = {},
		Roulette_rogueHealthOverride = { health = 3 },
	},
}

local aiBanshee = aiSkeletonmage
local aiBatMiniboss = smarter {
	traits = {
		chooseOpponent = RouletteRogueAI.Implements.ChooseOpponent.Random,
		gunShoot = 1,
	},
}
local aiDragon = smarter { traits = { gunShoot = .75 } }
local aiMinotaur = smarter { traits = { gunShoot = 1 } }
local aiNightmare = smarter { traits = { gunShoot = .49 } }
local aiMommy = aiSkeletonmage
local aiMummy = normal { traits = { gunShoot = .75 } }
local aiOgre = aiMinotaur

--- @type table<string, Entity | table<string, false>>
local minibosses = {
	Banshee = {
		Roulette_aiGamblerRogue = aiBanshee,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 30 },
		Roulette_gamblerSilencer = {},
		Roulette_gamblerStatusSilence = false,
	},
	Banshee2 = {
		Roulette_aiGamblerRogue = aiBanshee,
		Roulette_enemyPoolZ3 = {},
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 3 },
		Roulette_gamblerCurrency = { amount = 35 },
		Roulette_gamblerSilencer = {},
		Roulette_gamblerStatusSilence = false,
	},
	BatMiniboss = {
		Roulette_aiGamblerRogue = aiBatMiniboss,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 20 },
		Roulette_gamblerStartGameBonusItem = {},
		Roulette_rogueBeatDelayOverride = { interval = 0 },
		Roulette_rogueHealthOverride = { health = 3 },
	},
	BatMiniboss2 = {
		Roulette_aiGamblerRogue = aiBatMiniboss,
		Roulette_enemyPoolZ2 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 25 },
		Roulette_gamblerStartGameBonusItem = {},
		Roulette_rogueBeatDelayOverride = { interval = 0 },
		Roulette_rogueHealthOverride = { health = 4 },
	},
	Dragon = {
		Roulette_aiGamblerRogue = aiDragon,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 25 },
		Roulette_rogueHealthOverride = { health = 5 },
	},
	Dragon2 = {
		Roulette_aiGamblerRogue = aiDragon,
		Roulette_enemyPoolZ2 = {},
		Roulette_enemyPoolZ3 = {},
		Roulette_dragon = { key = "red" },
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 35 },
		Roulette_rogueHealthOverride = { health = 5 },
	},
	Dragon3 = {
		Roulette_aiGamblerRogue = aiDragon,
		Roulette_enemyPoolZ3 = {},
		Roulette_enemyPoolZ4 = {},
		Roulette_dragon = { key = "blue" },
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 35 },
		Roulette_rogueHealthOverride = { health = 5 },
	},
	Minotaur = {
		Roulette_aiGamblerRogue = aiMinotaur,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ1 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 25 },
	},
	Minotaur2 = {
		Roulette_aiGamblerRogue = aiMinotaur,
		Roulette_enemyPoolZ2 = {},
		Roulette_gambler = { initiative = 3 },
		Roulette_gamblerCurrency = { amount = 30 },
	},
	Mommy = {
		Roulette_aiGamblerRogue = aiMommy,
		Roulette_enemyPool = { weight = 150 },
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 40 },
		Roulette_gamblerMommy = {},
		Roulette_rogueBeatDelayOverride = { interval = 2 },
	},
	Mummy = {
		Roulette_aiGamblerRogue = aiMummy,
		Roulette_rogueHealthOverride = { health = 2 },
	},
	Nightmare = {
		Roulette_aiGamblerRogue = aiNightmare,
		Roulette_enemyPool = { weight = 50 },
		Roulette_enemyPoolZ2 = {},
		Roulette_gambler = { initiative = 1 },
		Roulette_gamblerCurrency = { amount = 30 },
		Roulette_gamblerNightmare = {},
		Roulette_rogueHealthOverride = { health = 4 },
	},
	Nightmare2 = {
		Roulette_aiGamblerRogue = aiNightmare,
		Roulette_enemyPoolZ3 = {},
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 3 },
		Roulette_gamblerCurrency = { amount = 35 },
		Roulette_gamblerNightmare = {},
		Roulette_rogueHealthOverride = { health = 6 },
	},
	Ogre = {
		Roulette_aiGamblerRogue = aiOgre,
		Roulette_enemyPool = { weight = 150 },
		Roulette_enemyPoolZ4 = {},
		Roulette_gambler = { initiative = 2 },
		Roulette_gamblerCurrency = { amount = 40 },
		Roulette_gamblerOgre = {},
		Roulette_rogueHealthOverride = { health = 7 },
		Roulette_rogueBeatDelayOverride = { interval = 2 },
	},
}

--- @type table<string, Entity | table<string, false>>
local bosses = {}

local specials = {
	Bat3 = {},
	Slime6 = {},
}

return {
	list = require "system.utils.Utilities".flatten(Utilities.mergeTables(z1,
		Utilities.mergeTables(z2,
			Utilities.mergeTables(z3,
				Utilities.mergeTables(z4,
					Utilities.mergeTables(minibosses,
						Utilities.mergeTables(bosses, specials)))))))
}
