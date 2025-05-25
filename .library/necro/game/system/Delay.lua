--- @meta

local Delay = {}

--- @class Delay.Flags
--- @field processOnPlayerAction boolean? Force the delay to occur earlier than planned when the affected player acts
--- @field processOnLevelComplete boolean? Force the delay to occur earlier than planned when the level ends
--- @field timeout number? Forces the host to create an action if a remote client is unresponsive
--- @field lazy boolean? Allow the delay to occur later than planned if no turns occur (do not create a DELAY turn)
--- @field immediate boolean? Executes 0-duration delays instantly instead of on frame (default for delay.register)
--- @field unique boolean? Only allows up to one instance of the specified delay to exist for an entity at any time

--- Registers a function that can be called from within gameplay code, delaying its effects until some time has elapsed.
--- Always associated with an entity. If the entity despawns prior to the delay's expiration, the delay is canceled.
--- If a delay of 0 is passed to the resulting invocation function, the callback is executed immediately.
--- Must be called at load time.
--- @param name string Unique name that identifies the delayed function, which can later be referenced to cancel it
--- @param func fun(entity:Entity,parameter?:any) Callback function to execute after the delay expires
--- @param flags? Delay.Flags Attributes that alter how the delay is processed
--- @return fun(entity:Entity,delayTime:number,parameter?:any) delayFunc Function to invoke the callback with a delay
function Delay.register(name, func, flags) end

--- Registers a function that can be called from within gameplay code, delaying its effects until some time has elapsed.
--- Always associated with an entity. If the entity despawns prior to the delay's expiration, the delay is canceled.
--- A unique identifier for this delay is generated automatically.
--- If a delay of 0 is passed to the resulting invocation function, the callback is executed later in the same turn.
--- Must be called at load time.
--- @param func fun(entity:Entity,parameter?:any) Callback function to execute after the delay expires
--- @param flags? Delay.Flags Attributes that alter how the delay is processed
--- @return fun(entity:Entity,parameter?:any,delayTime?:number) delayFunc Function to invoke the callback with a delay
function Delay.new(func, flags) end

--- Cancels any pending delay with the given name on the given entity.
--- @param entity Entity The entity to cancel the delay for
--- @param name string The name of the delay to cancel (as passed to `delay.register()`)
function Delay.cancel(entity, name) end

--- Changes the target time of any pending delay with the given name on the given entity.
--- @param entity Entity The entity to cancel the delay for
--- @param name string The name of the delay to cancel (as passed to `delay.register()`)
--- @param delayTime number The new relative delay at which the pending action should execute
function Delay.reschedule(entity, name, delayTime) end

--- Instantly executes all pending delays matching an optional condition.
--- Calling this function is usually not necessary or recommended; it should only be used if the game's time-based delay
--- mechanism needs to be bypassed.
--- @param condition? fun(table):boolean Predicate under which to preemptively process pending delays (default: always)
function Delay.processPreemptively(condition) end

function Delay.processImmediateDelays() end

return Delay
