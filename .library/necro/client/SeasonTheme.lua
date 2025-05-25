--- @meta

local SeasonTheme = {}

SeasonTheme.Type = {
	NONE = 0,
	HALLOWEEN = 1,
	CHRISTMAS = 2,
}

function SeasonTheme.isActive(season) end

function SeasonTheme.getCurrentSeason() end

return SeasonTheme
