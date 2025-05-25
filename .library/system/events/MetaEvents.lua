--- @meta

local MetaEvents = {}

--- Installs a meta-event listener for multiple event types. It will only be fired once, even if multiple events are
--- changed at the same time. Its invocation is guaranteed to happen after all event updates have been performed.
function MetaEvents.listenMultiple(handlerName, eventTypeNames, func) end

--- Installs a meta-event listener for any event type starting with the specified prefix. It will only be fired once,
--- even if multiple events are changed at the same time. Its invocation is guaranteed to happen after all event updates
--- have been performed.
function MetaEvents.listenPrefixed(handlerName, eventTypePrefix, func) end

return MetaEvents
