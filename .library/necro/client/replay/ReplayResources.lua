--- @meta

local ReplayResources = {}

function ReplayResources.reset() end

function ReplayResources.initialize() end

function ReplayResources.getPlaybackIndex() end

function ReplayResources.getPlaybackContext() end

function ReplayResources.isNextResourceReady() end

function ReplayResources.getTurnIDLimit() end

function ReplayResources.getRecordingContext() end

function ReplayResources.loadPendingResources(initial) end

return ReplayResources
