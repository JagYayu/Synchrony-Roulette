--- @meta

local ReplayRecorder = {}

function ReplayRecorder.start() end

function ReplayRecorder.getDuration() end

function ReplayRecorder.beginLevel() end

function ReplayRecorder.finishLevel(inputs) end

function ReplayRecorder.getReplayData() end

function ReplayRecorder.serializeLiveReplay(autoSkip) end

function ReplayRecorder.finalize() end

function ReplayRecorder.stop() end

function ReplayRecorder.isActive() end

function ReplayRecorder.getPlayerCount() end

return ReplayRecorder
