--- @meta

local Performance = {}

function Performance.isEnabled() end

function Performance.setEnabled(enabled) end

function Performance.collectGarbage(option, argument) end

function Performance.getMemoryUsage() end

function Performance.update() end

function Performance.warnEvent(eventTypeName, handlerName, time) end

function Performance.add(category, entry, time) end

function Performance.addTotal(category, time) end

function Performance.getPerformance(category) end

function Performance.getPerformanceSortedByTime(category) end

function Performance.getCategoryInvocationCount(category) end

function Performance.getCategoryTotal(category) end

function Performance.getFramerate() end

function Performance.getTotalFrameTime() end

function Performance.getTickTime() end

function Performance.getRenderTime() end

function Performance.getTargetTime() end

function Performance.getSystemRAM() end

function Performance.startLuaJITProfiler(mode, outfile) end

function Performance.stopLuaJITProfiler() end

function Performance.startLuaJITTraceDump(mode) end

function Performance.stopLuaJITTraceDump() end

function Performance.setJITEnabled(enabled) end

return Performance
