--- @meta

local SpeedrunTimer = {}

function SpeedrunTimer.formatTime(time) end

--- @return number
function SpeedrunTimer.getTime() end

function SpeedrunTimer.isPaused() end

function SpeedrunTimer.pause() end

function SpeedrunTimer.unpause() end

function SpeedrunTimer.getCurrentLevelCompletionTime() end

function SpeedrunTimer.getCumulativeLevelTime() end

function SpeedrunTimer.completeLevel(turnID) end

function SpeedrunTimer.getDeterministicTime() end

function SpeedrunTimer.getCurrentLoopStartTime() end

return SpeedrunTimer
