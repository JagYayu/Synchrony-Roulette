--- @meta

local RhythmMode = {}

RhythmMode.Type = {
	REGULAR = 0,
	NO_BEAT = 1,
	DOUBLE_TEMPO = 2,
	IRREGULAR = 3,
}

function RhythmMode.getMode() end

return RhythmMode
