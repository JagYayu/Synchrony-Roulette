--- @meta

local Music = {}

Music.FocusMuteMode = {
	ALWAYS = 1,
	IN_GAME_ONLY = 2,
	MENUS_ONLY = 3,
	NEVER = 4,
}

function Music.updateMusicTime() end

function Music.parseBeatmap(rawBeatmap, maxTime) end

function Music.getBeatmap() end

function Music.getOriginalBeatmap() end

function Music.getFocusMuteVolume() end

function Music.reloadLayers() end

function Music.setMusic(params, crossfade) end

function Music.getParameters() end

function Music.stopMusic() end

function Music.fadeIn(time) end

function Music.fadeOut(time) end

function Music.isFadingIn() end

function Music.isFadingOut() end

function Music.setMusicVolume(vol) end

function Music.getMusicVolume() end

function Music.getLayerCount() end

function Music.getLayerData(layerIndex) end

function Music.getLayerType(layerIndex) end

function Music.setLayerVolume(layerIndex, volume) end

function Music.getLayerVolume(layerIndex) end

function Music.setLayerTimeOffset(layerIndex, timeOffset) end

function Music.getLayerTimeOffset(layerIndex) end

function Music.setFilter(filter) end

function Music.getFilter() end

function Music.setLayerFilter(layerIndex, filter) end

function Music.getMusicTime() end

function Music.setMusicTime(time, soft) end

function Music.getRawTime() end

function Music.getEffectivePitch() end

function Music.getClockDrift() end

function Music.getMusicLength() end

function Music.isSongEndReached() end

function Music.isMusicLooping() end

function Music.isActive() end

function Music.isPaused() end

function Music.ignoreSkip() end

function Music.pauseMusic() end

function Music.resumeMusic() end

return Music
