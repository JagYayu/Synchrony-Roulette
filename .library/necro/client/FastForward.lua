--- @meta

local FastForward = {}

function FastForward.reset() end

function FastForward.begin(id) end

function FastForward.complete() end

function FastForward.cancel() end

function FastForward.isActive() end

function FastForward.isQueueComplete() end

function FastForward.isProcessingQueue() end

function FastForward.isSkipModeActive() end

return FastForward
