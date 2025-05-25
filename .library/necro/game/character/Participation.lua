--- @meta

local Participation = {}

--- Marks the specified player as an active participant. This happens automatically at the start of each level for all
--- non-spectating players, when a player leaves spectator mode and when late-joining.
--- @param playerID Player.ID Player to set the participation state of
function Participation.markPlayerAsParticipant(playerID) end

--- Marks the specified player as a non-participant.
--- @param playerID Player.ID Player to reset the participation state of
function Participation.unmarkPlayerAsParticipant(playerID) end

--- Checks if the player has spent any amount of time outside of spectator mode on the current level, making them an
--- active participant. Player ID 0 counts as having participated on every level.
--- @param playerID? Player.ID Player to check the participation state of (defaults to local player)
--- @return boolean result `true` for active players, `false` for disconnected players or spectators
function Participation.isLevelParticipant(playerID) end

--- Gets the number of levels this player has participated in within the current run (counting across All-Chars).
--- Player ID 0 counts as having participated on every level.
--- @param playerID? Player.ID Player to check the participation state of (defaults to local player)
--- @return integer levels Number of levels this player has participated in, or 0 for non-participants.
function Participation.getRunParticipation(playerID) end

--- Gets the number of levels this player has participated in within the current loop (e.g. one All-Chars character).
--- Player ID 0 counts as having participated on every level.
--- @param playerID? Player.ID Player to check the participation state of (defaults to local player)
--- @return integer levels Number of levels this player has participated in, or 0 for non-participants.
function Participation.getLoopParticipation(playerID) end

--- Gets the number of levels players could have participated in within this run (counting across All-Chars).
--- This includes the current level.
--- @return integer levels Number of levels players could have participated in within the current run
function Participation.getRunLevelCount() end

--- Gets the number of levels players could have participated in within the current loop (e.g. one All-Chars character).
--- This includes the current level.
--- @return integer levels Number of levels players could have participated in within the current loop
function Participation.getLoopLevelCount() end

--- Gets the proportion of levels this player has participated in within the current run (counting across All-Chars).
--- Player ID 0 counts as having participated on every level.
--- @param playerID? Player.ID Player to check the participation state of (defaults to local player)
--- @return integer levels Fraction of levels this player has participated in, or 0 for non-participants.
function Participation.getRunParticipationRatio(playerID) end

--- Gets the proportion of levels this player has participated in within the current loop (e.g. one All-Chars character).
--- Player ID 0 counts as having participated on every level.
--- @param playerID? Player.ID Player to check the participation state of (defaults to local player)
--- @return integer levels Fraction of levels this player has participated in, or 0 for non-participants.
function Participation.getLoopParticipationRatio(playerID) end

--- Returns the list of players who contributed to this level.
--- @return Player.ID[] playerIDs Player IDs of this level's participants
function Participation.getLevelParticipants() end

--- Returns the list of players who contributed to this run (optionally checking for a specific minimum required
--- participation threshold).
--- @param threshold? number Minimum fraction of levels that must have been completed within this run
--- @return Player.ID[] playerIDs Player IDs of this level's participants
function Participation.getRunParticipants(threshold) end

--- Returns the list of players who contributed to this loop (optionally checking for a specific minimum required
--- participation threshold).
--- @param threshold? number Minimum fraction of levels that must have been completed within this loop
--- @return Player.ID[] playerIDs Player IDs of this level's participants
function Participation.getLoopParticipants(threshold) end

--- Returns the maximum number of players active in any level during the run
--- @return integer
function Participation.getMaximumPlayerCount() end

return Participation
