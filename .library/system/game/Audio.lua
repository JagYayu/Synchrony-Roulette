--- @meta

local Audio = {}

Audio.Filter = {
	NONE = 0,
	LOWPASS = 1,
	HIGHPASS = 2,
	BANDPASS = 3,
}

function Audio.isAvailable() end

function Audio.createStaticSource(soundName, async, port) end

function Audio.createStreamingSource(soundName) end

function Audio.getActiveSources() end

function Audio.getAsyncLoadPendingCount() end

function Audio.getAsyncLoadCapacity() end

function Audio.play(id, time) end

function Audio.pause(id) end

function Audio.stop(id) end

function Audio.isPlaying(id) end

function Audio.isPaused(id) end

function Audio.isStopped(id) end

function Audio.getLength(id) end

function Audio.setLoop(id, active, loopStart, loopEnd) end

function Audio.isLoopActive(id) end

function Audio.getLoopStart(id) end

function Audio.getLoopEnd(id) end

function Audio.setPlaybackTime(id, time) end

function Audio.getPlaybackTime(id) end

function Audio.setVolume(id, volume) end

function Audio.getVolume(id) end

function Audio.setPitch(id, pitch) end

function Audio.getPitch(id) end

function Audio.setPosition(id, x, y, z) end

function Audio.getPosition(id) end

function Audio.setAttenuation(id, attenuation) end

function Audio.getAttenuation(id) end

function Audio.setMinimumDistance(id, minimumDistance) end

function Audio.getMinimumDistance(id) end

function Audio.setFilter(id, filter) end

function Audio.getFilter(id) end

function Audio.setKeepAlive(id, keepAlive) end

function Audio.getKeepAlive(id) end

function Audio.resetAll() end

return Audio
