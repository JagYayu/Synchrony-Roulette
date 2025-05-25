--- @meta

local PlatformStatistics = {}

function PlatformStatistics.isAvailable() end

function PlatformStatistics.isAchievementAutoUnlockEnabled() end

function PlatformStatistics.get(statID) end

function PlatformStatistics.set(statID, value) end

function PlatformStatistics.increase(statID, value) end

function PlatformStatistics.isAchieved(achievementID) end

function PlatformStatistics.achieve(achievementID) end

function PlatformStatistics.unachieve(achievementID) end

function PlatformStatistics.progress(achievementID, current, maximum) end

function PlatformStatistics.refresh() end

function PlatformStatistics.upload() end

return PlatformStatistics
