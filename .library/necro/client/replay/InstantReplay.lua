--- @meta

local InstantReplay = {}

InstantReplay.Perspective = {
	PLAYER = 1,
	ALTERNATING = 2,
	ENEMY = 3,
}

function InstantReplay.start(firstTurnID, lastTurnID, playerID, perspectiveTargetID) end

function InstantReplay.stop(skipSimulation) end

function InstantReplay.isActive() end

function InstantReplay.getTargetTime() end

function InstantReplay.getTargetTurnID() end

function InstantReplay.setTargetPlayerID(playerID) end

function InstantReplay.getTargetPlayerID() end

function InstantReplay.setPerspectiveOverrideEntityID(entityID) end

function InstantReplay.getPerspectiveOverrideEntityID() end

function InstantReplay.isSettingEnabled() end

function InstantReplay.getPerspectiveSetting() end

function InstantReplay.resumeAfterInterruption() end

return InstantReplay
