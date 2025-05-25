--- @meta

local GameSession = {}

--- @class GameSession.Mode.Data
--- 
--- @field id string Unique mode ID for networking and replays; is auto-prefixed with the mod's namespace
--- @field name? string Human-readable name, displayed in the "Custom mode" menu and in lobby metadata
--- @field visible? boolean Displays this mode in the "Custom mode" selector (default: true)
--- 
--- @field seedMode? GameSession.SeedMode Decides how this run should be seeded (default: RANDOM)
--- @field generatorOptions? LevelGenerator.Options Basic options table to pass to the level generator
--- @field selectFile? GameSession.Mode.Data.FileSelection Prompts the user to choose a file before starting this mode
--- 
--- @field multiCharEnabled? boolean Allow the multi-character modifiers to take effect in this mode (default: false)
--- @field progressionEnabled? boolean Enables persistent cross-run unlockable items from lobby NPCs (default: false)
--- @field progressionClearGrants? boolean Resets one-off unlockable bonuses from the Diamond Dealer (default: false)
--- @field progressionUnlockCharacters? boolean Unlocks new characters when reaching specific levels (default: false)
--- @field progressionPersistable? boolean Persists any unlocks obtained during this run (default: true)
--- @field statisticsEnabled? boolean Tracks statistics and grants achievements for this mode (default: false)
--- @field statisticsTrackHardcoreClears? boolean Increases All Zones completion stats for this mode (default: false)
--- @field statisticsIgnoreLeaderboardConditions? boolean Grants achievements even if leaderboards are disabled (default: false)
--- @field resetDiamonds? boolean Clears the player's diamond counter when starting this run (default: false)
--- @field diamondHoards? boolean Spawns diamond piles instead of gold piles upon beating a boss (default: false)
--- @field bossFlawlesses? boolean Spawns diamond piles instead of gold piles upon beating a boss (default: false)
--- @field depthPriceMultiplier? boolean Increases the price of shop items according to the depth (default: true)
--- @field bloodShopIgnoreRequirements? boolean Removes the forced Gold Weapon in Blood Shops (default: false)
--- @field resetPlayers? boolean Resets player inventories and health when entering a new level (default: false)
--- @field playerCollisions? boolean If set, overrides player collisions to be on or off in this mode
--- @field spawnLobbyReturnStairs? boolean Spawns a staircase to return to the lobby (default: false)
--- @field levelTransitionsEnabled? boolean Enters the next level when the level transition condition is met (default: true)
--- @field grantTrainingItems? boolean Grants training weapons when entering a level (default: false)
--- @field customLevelTweaks? boolean Applies a subset of procedural modifications when loading the level (default: false)
--- @field applyCustomRules? boolean Loads custom rules from the first level in the dungeon (default: false)
--- @field extraEnemiesPerFloor? integer Changes how many enemies can be culled on each floor (default: 0)
--- @field itemDepletionLimit? integer Allows a limited number of duplicate items to generate (default: 8)
--- 
--- @field enableHUD? boolean Toggles the visibility of the entire game HUD (default: true)
--- @field introText? boolean Shows an introductory world label on the first level of this run (default: false)
--- @field diamondCounter? boolean Shows the diamond counter in the top right corner of the HUD (default: true)
--- @field levelCounterHUD? boolean Shows the level counter in the bottom right corner of the HUD (default: true)
--- @field minimapHUD? boolean Shows the level's minimap on the HUD (default: true)
--- @field seedHUD? boolean Shows the run seed in the bottom right corner after finishing a run (default: true)
--- @field lowPercentHUD? boolean Shows the "Low Percent" indicator in the pause menu (default: true)
--- @field timerHUD? boolean Shows the speedrun timer in the bottom left corner of the HUD (default: false)
--- @field timerName? string Overrides the HUD label for the speedrun timer (default: "Speedrun")
--- @field timerNameScale? number Scale factor for the speedrun timer's HUD label (default: 1)
--- @field dynCharOverride? boolean If set, forces dynamic character sprites to be either always visible or invisible
--- 
--- @field cutscenes? boolean Plays story cutscenes during this run (default: false)
--- @field bossSplashes? boolean Shows a dismissable boss intro/announcement when entering a boss floor (default: true)
--- 
--- @field isLobby? boolean Designates this mode as a "lobby", disabling certain gameplay systems (default: false)
--- @field isLevelEditor? boolean Designates this mode as a level editor, overriding mouse inputs (default: false)
--- @field recordReplays? boolean If false, disables replays in this mode. If true, force-enables replay recording.
--- @field dailyChallenge? GameSession.Mode.Data.DailyChallenge Configures the mode as a Daily Challenge
--- @field disconnectOnReset? boolean Closes/disconnects from the server when returning to the lobby (default: false)
--- @field allowRestart? boolean Allows this session to be restarted (default: true)
--- @field autoMuteMusic? boolean If true, automatically mutes the music when unfocusing the window (default: false)
--- @field autoPause? boolean If false, the game does not pause automatically when pressing Escape (default: true)
--- @field autoSave? boolean If false, disables the auto-save feature for this game mode (default: true)
--- @field pauseOnAutoSave? boolean If false, the game is not paused when restoring a saved session (default: true)
--- @field checksumIgnoreArgs? boolean If true, ignores action arguments for input state checksums (default: false)
--- @field logSeed? boolean If false, disables logging the seed when starting a run (default: true)
--- @field snapshotRetentionCount? integer Overrides the number of snapshots to store for rollback (default: 32)

--- @class GameSession.Mode.Data.FileSelection
--- @field paths string[] Supplies a list of resource paths to allow selecting files from, merging their entries
--- @field title? string Menu header to be displayed for the file choice dialog
--- @field filter? fun(name:string):string? Called for each file to prettify its name or exclude it from the choice list

--- @class GameSession.Mode.Data.DailyChallenge
--- @field seedModifier integer Value to add to the base seed, for generating different runs across daily variants
--- @field singlePlayer boolean If true, forces this run to be performed in single-player
--- @field character string Forces the player to be a specific character for the daily run
--- @field mods string[] Forces specific mods to be loaded for the daily run
--- @field settings table Overrides all game settings for the duration of the daily run

--- @class GameSession.Transition
--- @field steps function[] List of callbacks to execute before generating the level
--- @field finishFunc function Final callback to execute the state change
--- @field runOptions LevelGenerator.Options Global options for parametrizing the level generator
--- @field levelOptions LevelGenerator.Options Level-specific options for parametrizing the level generator
--- @field generationAsyncState any Continuation data for asynchronous level generation
--- @field runState RunState Stores the run state for level generation
--- @field levelNumber integer The level number to generate
--- @field levelIndex integer The level number to store the generated level in and change to
--- @field uniqueID integer Unique numeric identifier for this level transition
--- @field delay number|nil The target delay for performing the transition, which includes level generation time
--- @field minimumDelay number|nil The minimum delay to wait after completing the resource upload before transitioning
--- @field targetTime number|nil The target timestamp for performing the level transition
--- @field sequenceSync boolean If true, initializes and awaits a sequence sync before generating the level
--- @field resourceSync boolean If true, waits for the resources to be uploaded before changing the game state
--- @field skipCutscenes boolean If true, prevents run-start cutscenes from being played
--- @field collectGarbage boolean If true, runs the garbage collector during level generation
--- @field canceled boolean Set to true when the transition was cancelled

--- @enum GameSession.Mode
GameSession.Mode = {
	AllZones = "AllZones",
	AllZonesSeeded = "AllZonesSeeded",
	CryptArena_libLevelGen_CryptArena = "CryptArena_libLevelGen_CryptArena",
	CryptArena_libLevelGen_CryptArena_seeded = "CryptArena_libLevelGen_CryptArena_seeded",
	CustomDungeon = "CustomDungeon",
	DailyChallenge = "DailyChallenge",
	DailyChallengeAmplified = "DailyChallengeAmplified",
	DailyChallengeAmplifiedSynchrony = "DailyChallengeAmplifiedSynchrony",
	DailyChallengeSynchrony = "DailyChallengeSynchrony",
	Lobby = "Lobby",
	NecroEdit_LevelEditor = "NecroEdit_LevelEditor",
	SingleZone = "SingleZone",
	Test = "Test",
	Training = "Training",
	Tutorial = "Tutorial",
	Void = "Void",
}

--- @enum GameSession.SeedMode
GameSession.SeedMode = {
	NONE = 0,
	RANDOM = 1,
	MANUAL = 2,
	OPTIONAL = 3,
}

--- @return LevelGenerator.Options
function GameSession.getDungeonOptions() end

function GameSession.getCurrentModeID() end

--- @return GameSession.Mode.Data
function GameSession.getCurrentMode() end

function GameSession.isLevelAvailable(levelNumber) end

--- @param modeData GameSession.Mode.Data
--- @return string
function GameSession.registerMode(modeData) end

function GameSession.getLevelCount() end

function GameSession.isRestartAllowed() end

function GameSession.start(options, delay) end

function GameSession.restart(delay) end

function GameSession.nextLevel(delay) end

function GameSession.goToLevel(levelNumber, delay) end

function GameSession.hasPendingTransition() end

function GameSession.cancelPendingTransitions(force) end

return GameSession
