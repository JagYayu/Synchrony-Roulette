--- @meta

local PersonalStats = {}

PersonalStats.Type = {
	DEPTH_CLEAR = "D",
	SPEEDRUN_TIME = "T",
	DEATHLESS_WINS = "W",
}

function PersonalStats.get(statType, characterType) end

function PersonalStats.set(statType, characterType, value) end

function PersonalStats.add(statType, characterType, value) end

function PersonalStats.increase(statType, characterType, value) end

function PersonalStats.decrease(statType, characterType, value) end

--- @param characterType Entity.Type
function PersonalStats.getShortSummary(characterType) end

return PersonalStats
