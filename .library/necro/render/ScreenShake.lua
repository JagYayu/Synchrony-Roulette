--- @meta

local ScreenShake = {}

function ScreenShake.createAtPosition(x, y, duration, intensity, range) end

function ScreenShake.createOnEntity(entity, duration, intensity, range) end

--- @return number
function ScreenShake.getIntensityAtPosition(x, y) end

function ScreenShake.setFactor(factor) end

function ScreenShake.getFactor() end

return ScreenShake
