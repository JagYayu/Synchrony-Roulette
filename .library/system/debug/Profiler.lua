--- @meta

local Profiler = {}

function Profiler.clearLog() end

function Profiler.getLog() end

function Profiler.isLogLimitReached() end

function Profiler.start() end

function Profiler.stop() end

function Profiler.isActive() end

function Profiler.setTickAttribute(key, value) end

function Profiler.setTickLogThreshold(thresholdTime) end

function Profiler.pushSampleContext(context) end

function Profiler.popSampleContext() end

return Profiler
