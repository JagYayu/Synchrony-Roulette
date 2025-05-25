--- @meta

local Replay = {}

Replay.SaveTrigger = {
	--- Game session was completed successfully (last dungeon level completed)
	WIN = 1,
	--- Game session loss condition is met (typically on player death)
	LOSS = 2,
	--- Game session was reset (quick restart, return to lobby, disconnect)
	RESET = 3,
	--- Game session was resynchronized (a mod was loaded/unloaded mid-run, or a game setting was changed)
	RESYNC = 4,
	--- Replay was saved manually from the run summary screen
	MANUAL = 5,
}

Replay.SaveMode = {
	NEVER = 1,
	WINS_ONLY = 2,
	ALWAYS = 3,
}

function Replay.listCategories() end

function Replay.list(category) end

function Replay.generateFilename(parameters) end

function Replay.loadFromMemory(replayData, filename) end

function Replay.load(filename) end

function Replay.save(filename) end

function Replay.autoSave(trigger) end

function Replay.getCurrentSavedReplayFile() end

function Replay.openDirectory() end

return Replay
