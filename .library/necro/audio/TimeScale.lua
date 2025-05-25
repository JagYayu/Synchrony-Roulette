--- @meta

local TimeScale = {}

function TimeScale.getTimeAndScale(rawTime) end

function TimeScale.getRawTimeForScaledTime(scaledTime) end

function TimeScale.addRegion(startTime, duration, scale, fadeInTime, fadeOutTime) end

function TimeScale.addInfiniteRegion(startTime, scale, fadeInTime) end

function TimeScale.removeRegion(regionID) end

function TimeScale.makeRegionInfinite(regionID) end

function TimeScale.isValidRegion(regionID) end

function TimeScale.getRegionIDs() end

function TimeScale.getRegion(regionID) end

function TimeScale.getScalePoints() end

function TimeScale.reset() end

return TimeScale
