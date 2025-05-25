--- @meta

local VideoPlayer = {}

VideoPlayer.Status = {
	LOADING = 0,
	PLAYING = 1,
	STOPPED = 2,
	ERROR = 3,
	UNAVAILABLE = 4,
}

function VideoPlayer.new(filename) end

return VideoPlayer
