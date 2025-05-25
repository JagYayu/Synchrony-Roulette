--- @meta

local Timer = {}

function Timer.new() end

function Timer.newPausable() end

function Timer.newScalable() end

--- @return number
function Timer.getGlobalTime() end

function Timer.seconds(seconds) end

function Timer.milliseconds(milliseconds) end

function Timer.microseconds(microseconds) end

function Timer.toSeconds(seconds) end

function Timer.toMilliseconds(seconds) end

function Timer.toMicroseconds(seconds) end

function Timer.sleep(seconds) end

return Timer
