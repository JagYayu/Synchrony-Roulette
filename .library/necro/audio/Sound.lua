--- @meta

local Sound = {}

Sound.Suppression = {
	DEFAULT = 1,
	SEEK = 2,
	INSTANT_REPLAY = 4,
	GAME_STATE_RESET = 8,
	CUTSCENE = 16,
	REPLAY_SKIP = 32,
}

--- Each sound group can be played at most once per turn per deduplication ID
function Sound.setDeduplicationID(id) end

function Sound.getDeduplicationID() end

function Sound.scaleVolume(value) end

function Sound.stopLoopingSounds() end

function Sound.resetGameSounds() end

function Sound.play(soundGroupOrFile, x, y, soundData) end

function Sound.playFromEntity(soundGroup, entity, soundData) end

function Sound.playIfFocused(soundGroup, entity, soundData) end

function Sound.playFile(soundFile, x, y, soundData) end

function Sound.playUI(soundGroup, soundData) end

function Sound.setVolume(soundRefID, volume) end

function Sound.setPosition(soundRefID, x, y) end

function Sound.getAudioSource(soundRefID) end

function Sound.isPlaying(soundRefID) end

function Sound.getPlaybackTime(soundRefID) end

function Sound.stop(soundRefID) end

function Sound.startRollback() end

function Sound.stopRollback() end

function Sound.startSuppression(suppressionType) end

function Sound.stopSuppression(suppressionType) end

function Sound.setSoundVolume(vol) end

--- @return number
function Sound.getSoundVolume() end

function Sound.setAsyncLoadingEnabled(async) end

function Sound.isAsyncLoadingEnabled() end

function Sound.setFilter(filter) end

function Sound.getFilter() end

function Sound.getActiveSoundsForTurn(turnID) end

function Sound.updateListeners() end

function Sound.updateGroupVolumes() end

return Sound
