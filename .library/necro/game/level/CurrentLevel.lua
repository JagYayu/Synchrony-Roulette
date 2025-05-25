--- @meta

local CurrentLevel = {}

--- @class Level.Info : Level.Base
--- @field modeID GameSession.Mode String ID of the game mode in which this level is being played
--- @field sequentialNumber integer Level visitation index. Starts at 1, increases by 1 on level change (any offset)
--- @field uniqueID integer Unique ID for snapshot equality tests. Starts at a random number, +1 per level transition
--- @field isLobby boolean Convenience attribute to indicate that this level represents the lobby

--- Returns true if the level is currently being loaded, or false if the level is currently being played.
function CurrentLevel.isLoading() end

--- The 1-indexed logical number of the current level within the whole run, starting at 1 and increasing with every
--- level, including across sub-run boundaries (Deathless wins or All-Characters changes).
--- Follows non-linear skips between levels (e.g. via the 'level' command).
function CurrentLevel.getNumber() end

--- The zone number of the current level. Starts at 1 and typically increments every 4 levels.
--- Reversed for certain characters, starting at 4 or 5 and counting down every 4 levels.
function CurrentLevel.getZone() end

--- The depth number of the current level. Starts at 1 for all chracters and typically increments every 4 levels.
function CurrentLevel.getDepth() end

--- The floor number of the current level within its zone. Starts at 1, increases by 1 every level, typically up to 4.
--- Upon entering a new zone, resets back to 1.
function CurrentLevel.getFloor() end

--- Returns the index of the current sub-run within a looping or multi-character run (Deathless, All-Chars).
function CurrentLevel.getLoopID() end

--- Returns a string representation of this level's zone and floor number.
function CurrentLevel.getName() end

--- Returns a color that can be used when displaying this level's name in the UI.
function CurrentLevel.getNameColor() end

--- Returns a table containing the level's current song info
function CurrentLevel.getMusic() end

--- Returns `true` if the current level represents a normal floor. Returns `false` for boss or special levels.
function CurrentLevel.isRegularFloor() end

--- Returns `true` if the current level represents a boss arena. Returns `false` for normal floors.
function CurrentLevel.isBoss() end

--- Returns the ID of the level's current boss.
function CurrentLevel.getBossType() end

--- Returns `true` if this level is the last one in the level sequence.
--- Completing it usually ends the run, but this can be overridden by certain modes (such as all-characters).
function CurrentLevel.isFinal() end

--- Returns `true` if this level is the last one in the run. Completing the final level counts as a victory.
function CurrentLevel.isRunFinal() end

--- Returns `true` if this level is the last one in the current loop. This is true even if the run continues in a new
--- loop after completing the current level.
function CurrentLevel.isLoopFinal() end

--- Returns a sequential 1-indexed number representing the order in which this current level was visited within the run.
--- Increases by 1 on each level change, even if the 'level' command or other arbitrary level changes are used.
function CurrentLevel.getSequentialNumber() end

--- Returns a fully unique number identifying a level across runs.
--- Initialized to a random integer at startup, increases by 1 for every level loaded or generated.
function CurrentLevel.getUniqueID() end

--- Returns `true` if this is the lobby level, `false` for any other level.
function CurrentLevel.isLobby() end

--- Returns `true` if this is a "safe" level (lobby or multi-char choice room), `false` for unsafe levels.
function CurrentLevel.isSafe() end

--- Returns `true` if this level was procedurally generated (e.g. All-Zones/Single-Zone mode, or bosses).
--- Returns `false` for levels loaded from a dungeon file.
function CurrentLevel.isProcedural() end

--- Returns the game mode table at the time this level was loaded.
--- @return GameSession.Mode.Data
function CurrentLevel.getMode() end

--- Returns the seed that was used to generate this level.
--- This is usually the same as RNG.getDungeonSeed(), but will differ during looped runs (deathless, story, etc).
--- @return integer
function CurrentLevel.getSeed() end

--- Returns a table containing information on how to spawn players for this level.
--- @return Level.PlayerOptions
function CurrentLevel.getPlayerOptions() end

--- Returns an optional table of run initialization parameters to be used when quick restarting.
--- If no such table is specified, this function returns `nil` and restarting behaves normally.
--- @return table?
function CurrentLevel.getRestartTarget() end

--- Deprecated! This field should no longer be used, as dungeon length can vary throughout the run.
function CurrentLevel.getDungeonLength() end

return CurrentLevel
