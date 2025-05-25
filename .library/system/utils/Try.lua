--- @meta

local Try = {}

--- pcall-like wrapper with automatic error logging
function Try.catch(func, ...) end

--- Passthrough wrapper for single return value
function Try.getOrNil(func, ...) end

return Try
