--- @meta

local DailyChallenge = {}

function DailyChallenge.getCurrentIndex() end

function DailyChallenge.getTimestampForIndex(index) end

function DailyChallenge.getNextAvailableIndex(modeID) end

function DailyChallenge.prompt(modeID, cancelCallback) end

function DailyChallenge.isAvailable(modeID) end

return DailyChallenge
