--- @meta

local Leaderboard = {}

Leaderboard.Status = {
	PENDING = 0,
	DONE = 1,
	FAILED = 2,
	MISSING = 3,
}

Leaderboard.SortMode = {
	INVALID = 0,
	DESCENDING = 1,
	ASCENDING = 2,
}

Leaderboard.DisplayMode = {
	INVALID = 0,
	SCORE = 1,
	SECONDS = 2,
	MILLISECONDS = 3,
}

Leaderboard.SubmissionMode = {
	PRESERVE = 0,
	OVERRIDE = 1,
}

function Leaderboard.getStatus() end

function Leaderboard.isAvailable() end

function Leaderboard.find(name) end

function Leaderboard.findOrCreate(name, sortMode, displayMode) end

function Leaderboard.createSubmission(score, updateMode, auxiliary, attachment) end

return Leaderboard
