--- @meta

local LeaderboardContext = {}

--- @class LeaderboardContext.Mod
--- @field name string Name of the mod being loaded
--- @field version string Version number of the packaged mod being loaded
--- @field public package boolean True if the mod was loaded via package, false for unpackaged mods (with live reloading)
--- @field hash? string Hash of the packaged mod being loaded, or nil for unpackaged mods

--- @class LeaderboardContext.Completion
--- @field depth integer Depth at which the run was finished (e.g. '2' for 2-3 on Cadence, but '4' on Aria w/ AMP)
--- @field zone integer Zone in which the run was finished ('2' for 2-3 on both Cadence and Aria)
--- @field floor integer Floor number at which the run was finished (e.g. '3' for 2-3 on Cadence)
--- @field level integer Sequential level number at which the run was finished, including deathless re-runs
--- @field score number Numeric score for this run, as of its completion
--- @field duration number Timestamp on the speedrun timer, as of its completion
--- @field winCount integer 0-indexed sub-run at which the run was finished (deathless win count, multi-character modes)
--- @field victory boolean If true, the run was finished successfully
--- @field killerName? string Name of the damage source that killed the local player
--- @field killerID? integer Unique ID of the damage source that killed the local player
--- @field killerType? string Entity type name that killed the local player
--- @field loopStart? integer Sequential level number at which the run's current loop started; nil for single-loop runs

--- @class LeaderboardContext.AutoSave
--- @field timestampSave integer UNIX timestamp at which the session was saved
--- @field timestampLoad integer UNIX timestamp at which the saved session was restored

--- @class LeaderboardContext
--- @field timestampStart integer UNIX timestamp at which the run started
--- @field timestampFinish integer UNIX timestamp at which the run ended
--- @field gameMode GameSession.Mode Game mode used for this session
--- @field seasonIndex? integer Seasonal run index (e.g. daily challenge day, ranked seasons); nil on regular runs
--- @field characters string[] List of characters that were played throughout this run
--- @field lowPercent boolean If true, this run was completed without picking up any items or using any shrines
--- @field goldDuplication boolean If true, this run made use of "Courage Duping" to gain more gold than intended
--- @field completion LeaderboardContext.Completion Contains data on how the run ended
--- @field customRules table<string,any>[] List of all custom rules setups throughout the run
--- @field mods LeaderboardContext.Mod[][] List of all mod setups used throughout the run
--- @field onlineMultiplayer boolean If this run has ever been opened to the network, this value is set to 'true'
--- @field minimumPlayers integer Minimum number of players present at any point during the run (including co-op)
--- @field maximumPlayers integer Maximum number of players present at any point during the run (including co-op)
--- @field spectatorCount integer Maximum number of spectators present throughout the run
--- @field participation number Proportion of levels this player actively played in (i.e. not spectating)
--- @field autoSaves LeaderboardContext.AutoSave[] Tracks how often and when this run was saved/restored
--- @field debugConsoleUsed boolean Indicates that console commands were used during this run
--- @field allowLobby boolean If true, this leaderboard context represents multiple boards when viewed in the lobby
--- @field ignoreFailures boolean If true, ignores failure conditions and displays all potentially matching leaderboards
--- @field checkCustomizations boolean If true, this context is used for checking for customizations
--- @field final boolean If true, this leaderboard context decides the run's final state

--- @class LeaderboardContext.Target
--- @field id string Identifier of the leaderboard
--- @field name string Localized name of the leaderboard
--- @field rankingMode LeaderboardContext.RankingMode Scoring/ranking mode for this leaderboard
--- @field tagSet table<integer,boolean> Set of tags applicable to this leaderboard
--- @field noPeeking? boolean If true, disallows viewing replays on this leaderboard
--- @field season? table Seasonal run identifier for this leaderboard

LeaderboardContext.RankingMode = {
	UNKNOWN = 0,
	SPEED = 1,
	SCORE = 2,
	WIN_COUNT = 3,
	SURVIVED_ROUNDS = 4,
}

function LeaderboardContext.update() end

--- Returns the leaderboard context for the current mode/settings, independent of the run. Works in the lobby.
--- @return LeaderboardContext
function LeaderboardContext.getModeContext() end

--- @return LeaderboardContext
function LeaderboardContext.getCustomizationContext() end

function LeaderboardContext.isLeaderboardAvailableForCurrentMode(rankingMode) end

function LeaderboardContext.updateModeContext() end

--- Returns the leaderboard context at the start of this run
--- @return LeaderboardContext
function LeaderboardContext.getInitialRunContext() end

--- Returns the leaderboard context for the current point in the run
--- @return LeaderboardContext
function LeaderboardContext.getCurrentRunContext() end

--- Returns the leaderboard context for the current loop (single sub-run within deathless or multi-character runs)
--- @return LeaderboardContext
function LeaderboardContext.getLoopContext() end

--- Returns the leaderboard context for the end of the run
--- @return LeaderboardContext
function LeaderboardContext.getFinalRunContext() end

--- Returns the list of leaderboards this run is allowed to submit to
--- @param context LeaderboardContext
--- @return LeaderboardContext.Target[]
--- @return string failureMessage Localized string describing why leaderboards are unavailable for this run
function LeaderboardContext.getTargets(context) end

function LeaderboardContext.isDisabledByModifications() end

return LeaderboardContext
