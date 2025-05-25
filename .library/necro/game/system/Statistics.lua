--- @meta

local Statistics = {}

Statistics.Receiver = {
	ENTITY = 1,
	ATTACKER = 2,
	VICTIM = 4,
	NEAREST_PLAYER = 8,
	ALL_PLAYERS = 16,
}

function Statistics.getReceiver(args) end

function Statistics.getUserStat(statID) end

function Statistics.isEnabled() end

function Statistics.isPersistable() end

function Statistics.disqualify(playerID) end

function Statistics.add(playerID, statID, value) end

function Statistics.setMax(playerID, statID, value) end

--- Immediately increases a specific stat outside of a run (typically used for meta-achievements that are obtained by
--- completing a range of other achievements)
function Statistics.metaSet(statID, value) end

--- Immediately sets a specific stat outside of a run (including value decreases). Only used for debugging purposes
function Statistics.metaOverride(statID, value) end

function Statistics.commit(persist) end

function Statistics.register(name, data) end

return Statistics
