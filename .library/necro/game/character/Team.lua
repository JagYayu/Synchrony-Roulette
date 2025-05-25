--- @meta

local Team = {}

Team.Id = {
	--- Entities on team "NONE" are hostile towards all other entities (including other entities from team "NONE")
	NONE = 0,
	--- Team used by playable characters
	PLAYER = 1,
	--- Team used by enemies
	ENEMY = 2,
	--- Team used temporarily when a player inflicts friendly fire damage upon another player in co-op mode
	FRIENDLY_FIRE = 3,
}

function Team.getTeam(entityOrTeamID) end

function Team.setTeam(entity, teamID) end

function Team.isHostile(entityOrTeamID1, entityOrTeamID2) end

return Team
