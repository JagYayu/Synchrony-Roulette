--- @meta

local StackTrace = {}

function StackTrace.generate(level) end

function StackTrace.formatFrame(info) end

function StackTrace.format(trace) end

function StackTrace.traceback(message, level) end

return StackTrace
