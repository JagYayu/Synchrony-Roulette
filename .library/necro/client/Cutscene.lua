--- @meta

local Cutscene = {}

Cutscene.DisplayMode = {
	NEVER = 1,
	SINGLE_PLAYER = 2,
	ALWAYS = 3,
}

Cutscene.Type = {
	SPLASH = 0,
	INTRO = 1,
	STORY = 2,
	CREDITS = 3,
}

function Cutscene.play(scene, delay) end

function Cutscene.playAll(scenes, delay) end

function Cutscene.skip(abort) end

function Cutscene.finish() end

function Cutscene.fadeOut() end

function Cutscene.isActive() end

function Cutscene.getName() end

function Cutscene.isPlaying() end

function Cutscene.isPending() end

function Cutscene.getPlaybackTime() end

function Cutscene.setPlaybackTime(time) end

function Cutscene.getFadeFactor() end

function Cutscene.isFinished() end

function Cutscene.getStartupCutscenes() end

function Cutscene.skipStartupCutscenes() end

function Cutscene.getLevelEnterCutscenes(characters, depthNumber, floorNumber, bossID) end

function Cutscene.getLevelLeaveCutscenes(final) end

return Cutscene
