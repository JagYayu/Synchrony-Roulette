--- @meta

local AbstractSelector = {}

function AbstractSelector.new(args) end

function AbstractSelector.setInvocationCacheEnabled(enabled) end

function AbstractSelector.isInvocationCacheEnabled() end

function AbstractSelector.invalidateAllCaches() end

function AbstractSelector.invalidateCache(eventType) end

return AbstractSelector
