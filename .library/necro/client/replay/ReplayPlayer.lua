--- @meta

local ReplayPlayer = {}

function ReplayPlayer.getReplayData() end

function ReplayPlayer.isReady() end

function ReplayPlayer.isActive() end

function ReplayPlayer.isLingering() end

function ReplayPlayer.isLevelTransitionPending() end

function ReplayPlayer.isAutoStartPending() end

function ReplayPlayer.prepareAutoStart() end

function ReplayPlayer.getLevelCount() end

function ReplayPlayer.isTargetLevelReached() end

function ReplayPlayer.getNextLevel() end

function ReplayPlayer.hasAutoSkip() end

function ReplayPlayer.getAutoSkipTargetLevel() end

return ReplayPlayer
