--- @meta

local CommonFilter = {}

--- @param filterName any
--- @param imageArgs any
--- @param extraArgs any
--- @param func any
--- @return function
function CommonFilter.register(filterName, imageArgs, extraArgs, func) end

function CommonFilter.checkStringArg(args, key) end

function CommonFilter.checkNumericArg(args, key) end

function CommonFilter.checkNumericArgs(args, keys) end

return CommonFilter
