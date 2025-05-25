--- @meta

local Turn = {}

--- @alias Turn.ID integer

Turn.Progress = {
	PLAYER_ACTIONS = 1,
	ENEMY_ACTIONS = 3,
}

--- Returns the turn at which new actions should be inserted
function Turn.getTargetTurnID() end

--- Returns the turn up to which the game state should be simulated
function Turn.getSimulationTargetTurnID() end

--- @return integer
function Turn.getCurrentTurnID() end

function Turn.getActiveTurnID() end

function Turn.getTurnIDForTime(seconds) end

--- Returns the scaled time corresponding to the given turnID (accounts for tempo changes)
function Turn.getTurnTimestamp(turnID) end

--- Returns the raw time corresponding to the given turn (real-life time, ignores tempo changes)
function Turn.getRawTimestamp(turnID) end

function Turn.isLatestTurnReached() end

--- Processes up to the specified number of turns, or any number of turns (if 'limit' is nil), up to the specified target
--- turn (or the game's current target turn if 'target' is nil).
function Turn.process(target, limit) end

function Turn.getProgress() end

function Turn.increaseProgress() end

return Turn
