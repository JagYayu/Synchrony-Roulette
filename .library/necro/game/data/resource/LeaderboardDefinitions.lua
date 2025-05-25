--- @meta

local LeaderboardDefinitions = {}

--- @class LeaderboardDefinition.Run
--- @field context LeaderboardContext Parameters within which the run was performed
--- @field targets table Contains a list of targets for mapping this run to a specific set of leaderboards

LeaderboardDefinitions.TagType = {
	--- DLC game content (base ND, Amplified, Synchrony)
	DLC = 1,
	--- Primary game mode (all-zones/all-zones-seeded/daily - corresponds to GameSession.Mode)
	GAME_MODE = 2,
	--- Seasonally rotating identifier (e.g. daily challenge index)
	SEASON = 3,
	--- Performance scoring criterion for procedural runs (speed/score)
	SCORE_MODE = 4,
	--- Primary character
	CHARACTER = 5,
	--- Local/online co-op indicators
	MULTIPLAYER = 6,
	--- Primary extra mode (Deathless > NoReturn > Hard > Phasing > Randomizer > Mystery)
	EXTRA_MODE = 7,
	--- Custom music (except on Bard)
	CUSTOM_MUSIC = 8,
	--- Gameplay trait: no items collected
	LOW_PERCENT = 9,
	--- Gameplay trait: item duplication performed
	GOLD_DUPLICATION = 10,
	--- Deployment mode (dev/prod suffix)
	DEPLOYMENT = 11,
}

LeaderboardDefinitions.Tag = {
	Character = {
  ALL_CHARACTERS_13 = 20,
  ALL_CHARACTERS_16 = 21,
  ALL_CHARACTERS_9 = 19,
  ENSEMBLE = 22,
  MIXED = 17,
  SINGLE_CHARACTER = 16,
  STORY_MODE = 18,
  -- <metatable> = {
  --   __index = {
  --     builtInMax = 22,
  --     builtInMin = 16,
  --     data = {
  --       [16] = {
  --         key = <function 1>,
  --         label = <function 2>,
  --         tagType = 5
  --       },
  --       [17] = {
  --         tagType = 5
  --       },
  --       [18] = {
  --         key = "Story Mode",
  --         label = "Story Mode",
  --         tagType = 5
  --       },
  --       [19] = {
  --         key = "All Chars",
  --         label = "All chars",
  --         tagType = 5
  --       },
  --       [20] = {
  --         key = "All Chars DLC",
  --         label = "All chars AMP",
  --         tagType = 5
  --       },
  --       [21] = {
  --         key = "All Chars AMPSYNC",
  --         label = "All chars SYNC",
  --         tagType = 5
  --       },
  --       [22] = {
  --         key = "Ensemble",
  --         label = "Ensemble",
  --         tagType = 5
  --       },
  --       <metatable> = {
  --         __index = <function 3>
  --       }
  --     },
  --     extend = <function 4>,
  --     indices = {
  --       [16] = 1,
  --       [17] = 2,
  --       [18] = 3,
  --       [19] = 4,
  --       [20] = 5,
  --       [21] = 6,
  --       [22] = 7
  --     },
  --     keyList = { "SINGLE_CHARACTER", "MIXED", "STORY_MODE", "ALL_CHARACTERS_9", "ALL_CHARACTERS_13", "ALL_CHARACTERS_16", "ENSEMBLE" },
  --     names = {
  --       [16] = "SINGLE_CHARACTER",
  --       [17] = "MIXED",
  --       [18] = "STORY_MODE",
  --       [19] = "ALL_CHARACTERS_9",
  --       [20] = "ALL_CHARACTERS_13",
  --       [21] = "ALL_CHARACTERS_16",
  --       [22] = "ENSEMBLE"
  --     },
  --     prettyNames = {
  --       [16] = "Single Character",
  --       [17] = "Mixed",
  --       [18] = "Story Mode",
  --       [19] = "All Characters 9",
  --       [20] = "All Characters 13",
  --       [21] = "All Characters 16",
  --       [22] = "Ensemble"
  --     },
  --     valueList = { 16, 17, 18, 19, 20, 21, 22 }
  --   },
  --   __newindex = <function 5>
  -- }
},
	GameMode = {
  ALL_ZONES = 5,
  ALL_ZONES_SEEDED = 6,
  ARENA = 8,
  ARENA_SEEDED = 9,
  DAILY_CHALLENGE = 7,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 9,
  --    builtInMin = 5,
  --    data = {
  --      [5] = {
  --        label = "All Zones",
  --        mode = "AllZones",
  --        tagType = 2
  --      },
  --      [6] = {
  --        label = "All Zones Seeded",
  --        mode = "AllZonesSeeded",
  --        tagType = 2
  --      },
  --      [7] = {
  --        label = "Daily Challenge",
  --        mode = {
  --          DailyChallenge = true,
  --          DailyChallengeAmplified = true,
  --          DailyChallengeAmplifiedSynchrony = true,
  --          DailyChallengeSynchrony = true
  --        },
  --        tagType = 2
  --      },
  --      [8] = {
  --        key = "ARENA",
  --        label = "Arena",
  --        mode = "Sync_ArenaDeathless",
  --        tagType = 2
  --      },
  --      [9] = {
  --        key = "ARENA SEEDED",
  --        label = "Arena Seeded",
  --        mode = "Sync_ArenaDeathlessSeeded",
  --        tagType = 2
  --      },
  --      <metatable> = {
  --        __index = <function 1>
  --      }
  --    },
  --    extend = <function 2>,
  --    indices = {
  --      [5] = 1,
  --      [6] = 2,
  --      [7] = 3,
  --      [8] = 4,
  --      [9] = 5
  --    },
  --    keyList = { "ALL_ZONES", "ALL_ZONES_SEEDED", "DAILY_CHALLENGE", "ARENA", "ARENA_SEEDED" },
  --    names = {
  --      [5] = "ALL_ZONES",
  --      [6] = "ALL_ZONES_SEEDED",
  --      [7] = "DAILY_CHALLENGE",
  --      [8] = "ARENA",
  --      [9] = "ARENA_SEEDED"
  --    },
  --    prettyNames = {
  --      [5] = "All Zones",
  --      [6] = "All Zones Seeded",
  --      [7] = "Daily Challenge",
  --      [8] = "Arena",
  --      [9] = "Arena Seeded"
  --    },
  --    valueList = { 5, 6, 7, 8, 9 }
  --  },
  --  __newindex = <function 3>
  --}
},
	DLC = {
  AMPLIFIED = 2,
  AMPLIFIED_SYNCHRONY = 4,
  BASE = 1,
  SYNCHRONY = 3,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 4,
  --    builtInMin = 1,
  --    data = { {
  --        tagType = 1
  --      }, {
  --        key = "DLC",
  --        tagType = 1
  --      }, {
  --        key = "SYNC",
  --        tagType = 1
  --      }, {
  --        key = "DLC SYNC",
  --        tagType = 1
  --      },
  --      <metatable> = {
  --        __index = <function 1>
  --      }
  --    },
  --    extend = <function 2>,
  --    indices = { 1, 2, 3, 4 },
  --    keyList = { "BASE", "AMPLIFIED", "SYNCHRONY", "AMPLIFIED_SYNCHRONY" },
  --    names = { "BASE", "AMPLIFIED", "SYNCHRONY", "AMPLIFIED_SYNCHRONY" },
  --    prettyNames = { "Base", "Amplified", "Synchrony", "Amplified Synchrony" },
  --    valueList = { 1, 2, 3, 4 }
  --  },
  --  __newindex = <function 3>
  --}
},
	Multiplayer = {
  COOP_2P = 24,
  COOP_3P = 25,
  COOP_4P = 26,
  COOP_8P = 27,
  SINGLE_PLAYER = 23,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 27,
  --    builtInMin = 23,
  --    data = {
  --      [23] = {
  --        maxPlayers = 1,
  --        tagType = 6
  --      },
  --      [24] = {
  --        key = "CO-OP",
  --        label = "2p",
  --        maxPlayers = 2,
  --        tagType = 6
  --      },
  --      [25] = {
  --        key = "CO-OP3",
  --        label = "3p",
  --        maxPlayers = 3,
  --        tagType = 6
  --      },
  --      [26] = {
  --        key = "CO-OP4",
  --        label = "4p",
  --        maxPlayers = 4,
  --        tagType = 6
  --      },
  --      [27] = {
  --        key = "CO-OP8",
  --        label = "Co-op",
  --        tagType = 6
  --      },
  --      <metatable> = {
  --        __index = <function 1>
  --      }
  --    },
  --    extend = <function 2>,
  --    indices = {
  --      [23] = 1,
  --      [24] = 2,
  --      [25] = 3,
  --      [26] = 4,
  --      [27] = 5
  --    },
  --    keyList = { "SINGLE_PLAYER", "COOP_2P", "COOP_3P", "COOP_4P", "COOP_8P" },
  --    names = {
  --      [23] = "SINGLE_PLAYER",
  --      [24] = "COOP_2P",
  --      [25] = "COOP_3P",
  --      [26] = "COOP_4P",
  --      [27] = "COOP_8P"
  --    },
  --    prettyNames = {
  --      [23] = "Single Player",
  --      [24] = "Coop 2p",
  --      [25] = "Coop 3p",
  --      [26] = "Coop 4p",
  --      [27] = "Coop 8p"
  --    },
  --    valueList = { 23, 24, 25, 26, 27 }
  --  },
  --  __newindex = <function 3>
  --}
},
	CustomMusic = {
  CUSTOM_MUSIC = 35,
  DEFAULT_MUSIC = 34,
  DOUBLE_TEMPO = 37,
  NO_BEAT_MODE = 36,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 37,
  --    builtInMin = 34,
  --    data = {
  --      [34] = {
  --        tagType = 8
  --      },
  --      [35] = {
  --        key = "CUSTOM MUSIC",
  --        label = "Custom music",
  --        tagType = 8
  --      },
  --      [36] = {
  --        key = "NO BEAT",
  --        label = "No Beat",
  --        tagType = 8
  --      },
  --      [37] = {
  --        key = "DOUBLE TEMPO",
  --        label = <function 1>,
  --        tagType = 8
  --      },
  --      <metatable> = {
  --        __index = <function 2>
  --      }
  --    },
  --    extend = <function 3>,
  --    indices = {
  --      [34] = 1,
  --      [35] = 2,
  --      [36] = 3,
  --      [37] = 4
  --    },
  --    keyList = { "DEFAULT_MUSIC", "CUSTOM_MUSIC", "NO_BEAT_MODE", "DOUBLE_TEMPO" },
  --    names = {
  --      [34] = "DEFAULT_MUSIC",
  --      [35] = "CUSTOM_MUSIC",
  --      [36] = "NO_BEAT_MODE",
  --      [37] = "DOUBLE_TEMPO"
  --    },
  --    prettyNames = {
  --      [34] = "Default Music",
  --      [35] = "Custom Music",
  --      [36] = "No Beat Mode",
  --      [37] = "Double Tempo"
  --    },
  --    valueList = { 34, 35, 36, 37 }
  --  },
  --  __newindex = <function 4>
  --}
},
	Season = {
  DAILY_CHALLENGE = 11,
  NONE = 10,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 11,
  --    builtInMin = 10,
  --    data = {
  --      [10] = {
  --        tagType = 3
  --      },
  --      [11] = {
  --        key = <function 1>,
  --        label = <function 2>,
  --        noPeeking = <function 3>,
  --        rankingMode = 2,
  --        season = <function 4>,
  --        tagType = 3
  --      },
  --      <metatable> = {
  --        __index = <function 5>
  --      }
  --    },
  --    extend = <function 6>,
  --    indices = {
  --      [10] = 1,
  --      [11] = 2
  --    },
  --    keyList = { "NONE", "DAILY_CHALLENGE" },
  --    names = {
  --      [10] = "NONE",
  --      [11] = "DAILY_CHALLENGE"
  --    },
  --    prettyNames = {
  --      [10] = "None",
  --      [11] = "Daily Challenge"
  --    },
  --    valueList = { 10, 11 }
  --  },
  --  __newindex = <function 7>
  --}
},
	ExtraMode = {
  DEATHLESS = 28,
  HARD = 30,
  MYSTERY = 33,
  NO_RETURN = 29,
  PHASING = 31,
  RANDOMIZER = 32,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 33,
  --    builtInMin = 28,
  --    data = {
  --      [28] = {
  --        key = "DEATHLESS",
  --        label = "Deathless",
  --        setting = "gameplay.modifiers.deathless",
  --        tagType = 7
  --      },
  --      [29] = {
  --        key = "NO RETURN",
  --        label = "No Return",
  --        setting = "gameplay.modifiers.noReturn",
  --        tagType = 7
  --      },
  --      [30] = {
  --        key = "HARD",
  --        label = "Hard",
  --        setting = "gameplay.modifiers.hard",
  --        tagType = 7
  --      },
  --      [31] = {
  --        key = "PHASING",
  --        label = "Phasing",
  --        setting = "gameplay.modifiers.phasing",
  --        tagType = 7
  --      },
  --      [32] = {
  --        key = "RANDOMIZER",
  --        label = "Randomizer",
  --        setting = "gameplay.modifiers.randomizer",
  --        tagType = 7
  --      },
  --      [33] = {
  --        key = "MYSTERY",
  --        label = "Mystery",
  --        setting = "gameplay.modifiers.mystery",
  --        tagType = 7
  --      },
  --      <metatable> = {
  --        __index = <function 1>
  --      }
  --    },
  --    extend = <function 2>,
  --    indices = {
  --      [28] = 1,
  --      [29] = 2,
  --      [30] = 3,
  --      [31] = 4,
  --      [32] = 5,
  --      [33] = 6
  --    },
  --    keyList = { "DEATHLESS", "NO_RETURN", "HARD", "PHASING", "RANDOMIZER", "MYSTERY" },
  --    names = {
  --      [28] = "DEATHLESS",
  --      [29] = "NO_RETURN",
  --      [30] = "HARD",
  --      [31] = "PHASING",
  --      [32] = "RANDOMIZER",
  --      [33] = "MYSTERY"
  --    },
  --    prettyNames = {
  --      [28] = "Deathless",
  --      [29] = "No Return",
  --      [30] = "Hard",
  --      [31] = "Phasing",
  --      [32] = "Randomizer",
  --      [33] = "Mystery"
  --    },
  --    valueList = { 28, 29, 30, 31, 32, 33 }
  --  },
  --  __newindex = <function 3>
  --}
},
	Deployment = {
  DEVELOPMENT = 44,
  NONE = 43,
  PRODUCTION = 45,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 45,
  --    builtInMin = 43,
  --    data = {
  --      [43] = {
  --        tagType = 11
  --      },
  --      [44] = {
  --        key = "_DEV",
  --        keySpace = false,
  --        label = "(DEV)",
  --        tagType = 11
  --      },
  --      [45] = {
  --        key = "_PROD",
  --        keySpace = false,
  --        tagType = 11
  --      },
  --      <metatable> = {
  --        __index = <function 1>
  --      }
  --    },
  --    extend = <function 2>,
  --    indices = {
  --      [43] = 1,
  --      [44] = 2,
  --      [45] = 3
  --    },
  --    keyList = { "NONE", "DEVELOPMENT", "PRODUCTION" },
  --    names = {
  --      [43] = "NONE",
  --      [44] = "DEVELOPMENT",
  --      [45] = "PRODUCTION"
  --    },
  --    prettyNames = {
  --      [43] = "None",
  --      [44] = "Development",
  --      [45] = "Production"
  --    },
  --    valueList = { 43, 44, 45 }
  --  },
  --  __newindex = <function 3>
  --}
},
	GoldDuplication = {
  DUPING = 42,
  NORMAL = 41,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 42,
  --    builtInMin = 41,
  --    data = {
  --      [41] = {
  --        tagType = 10
  --      },
  --      [42] = {
  --        key = "DUPING",
  --        label = "Duping",
  --        tagType = 10
  --      },
  --      <metatable> = {
  --        __index = <function 1>
  --      }
  --    },
  --    extend = <function 2>,
  --    indices = {
  --      [41] = 1,
  --      [42] = 2
  --    },
  --    keyList = { "NORMAL", "DUPING" },
  --    names = {
  --      [41] = "NORMAL",
  --      [42] = "DUPING"
  --    },
  --    prettyNames = {
  --      [41] = "Normal",
  --      [42] = "Duping"
  --    },
  --    valueList = { 41, 42 }
  --  },
  --  __newindex = <function 3>
  --}
},
	LowPercent = {
  LOW_PERCENT = 39,
  NORMAL = 38,
  ZERO_PERCENT = 40,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 40,
  --    builtInMin = 38,
  --    data = {
  --      [38] = {
  --        tagType = 9
  --      },
  --      [39] = {
  --        key = "LOW",
  --        label = "Low%",
  --        tagType = 9
  --      },
  --      [40] = {
  --        key = "ZERO",
  --        label = "0%",
  --        tagType = 9
  --      },
  --      <metatable> = {
  --        __index = <function 1>
  --      }
  --    },
  --    extend = <function 2>,
  --    indices = {
  --      [38] = 1,
  --      [39] = 2,
  --      [40] = 3
  --    },
  --    keyList = { "NORMAL", "LOW_PERCENT", "ZERO_PERCENT" },
  --    names = {
  --      [38] = "NORMAL",
  --      [39] = "LOW_PERCENT",
  --      [40] = "ZERO_PERCENT"
  --    },
  --    prettyNames = {
  --      [38] = "Normal",
  --      [39] = "Low Percent",
  --      [40] = "Zero Percent"
  --    },
  --    valueList = { 38, 39, 40 }
  --  },
  --  __newindex = <function 3>
  --}
},
	ScoreMode = {
  SCORE = 13,
  SPEED = 12,
  SURVIVED_ROUNDS = 15,
  WIN_COUNT = 14,
  --<metatable> = {
  --  __index = {
  --    builtInMax = 15,
  --    builtInMin = 12,
  --    data = {
  --      [12] = {
  --        key = <function 1>,
  --        label = "Speedrun",
  --        rankingMode = 1,
  --        tagType = 4
  --      },
  --      [13] = {
  --        key = <function 2>,
  --        rankingMode = 2,
  --        tagType = 4
  --      },
  --      [14] = {
  --        key = "HARDCORE",
  --        rankingMode = 3,
  --        tagType = 4
  --      },
  --      [15] = {
  --        rankingMode = 4,
  --        tagType = 4
  --      },
  --      <metatable> = {
  --        __index = <function 3>
  --      }
  --    },
  --    extend = <function 4>,
  --    indices = {
  --      [12] = 1,
  --      [13] = 2,
  --      [14] = 3,
  --      [15] = 4
  --    },
  --    keyList = { "SPEED", "SCORE", "WIN_COUNT", "SURVIVED_ROUNDS" },
  --    names = {
  --      [12] = "SPEED",
  --      [13] = "SCORE",
  --      [14] = "WIN_COUNT",
  --      [15] = "SURVIVED_ROUNDS"
  --    },
  --    prettyNames = {
  --      [12] = "Speed",
  --      [13] = "Score",
  --      [14] = "Win Count",
  --      [15] = "Survived Rounds"
  --    },
  --    valueList = { 12, 13, 14, 15 }
  --  },
  --  __newindex = <function 5>
  --}
},
}

--- Validates the given run's leaderboard eligibility
--- @param context LeaderboardContext
function LeaderboardDefinitions.getApplicableTagLists(context) end

--- @param context LeaderboardContext Context of the run for which leaderboards are being queried
--- @param tagSet table Set of tags specific to this leaderboard
--- @return LeaderboardContext.Target
function LeaderboardDefinitions.getLeaderboardTarget(context, tagSet) end

return LeaderboardDefinitions
