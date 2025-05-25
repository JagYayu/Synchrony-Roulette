--- @meta

local LevelLoop = {}

--- Marks this run as an individually submittable loop within a multi-char or deathless session
function LevelLoop.begin() end

function LevelLoop.complete(args) end

function LevelLoop.getVictoryLoopID() end

function LevelLoop.reset(args) end

return LevelLoop
