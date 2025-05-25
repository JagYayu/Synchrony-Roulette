--- @meta

local ReplayControls = {}

function ReplayControls.isController() end

function ReplayControls.seekForward(distance) end

function ReplayControls.seekBackward(distance) end

function ReplayControls.skipLevel() end

function ReplayControls.setPlaybackSpeed(speed) end

function ReplayControls.getPlaybackSpeed() end

return ReplayControls
