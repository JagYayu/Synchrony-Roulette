--- @meta

local Tick = {}

function Tick.process() end

function Tick.milliseconds(millisecs) end

function Tick.seconds(seconds) end

function Tick.getDeltaTicks() end

function Tick.getFloatDeltaTicks() end

--- @return number deltaTime
function Tick.getDeltaTime() end

function Tick.invokeLater(func) end

function Tick.registerDelay(func, name) end

--- Creates a deferred wrapper around the specifed function. Each invocation will be deferred until later in the tick,
--- or can be delayed until a certain time has elapsed. In order to call a delayed function, the result of this call
--- must be stored in a global variable. This ensures that delay invocations can persist across mod reloads.
--- Returning `false` from within the function causes it to be re-queued for the next tick.
--- Calling the same delayed function multiple times removes any previous invocations.
--- @param func fun(args?:table):boolean?|table Function to wrap for deferred invocation
--- @return fun(args?:table,delay?:number) delayedFunc Wrapper function that invokes the passed function with a delay
function Tick.delay(func) end

function Tick.hasActiveDelay(name) end

return Tick
