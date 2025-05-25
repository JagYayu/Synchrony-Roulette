--- @meta

local Events = {}

function Events.getModificationCount(eventType) end

function Events.getRegisteredFunctions(eventType) end

function Events.registerSelector(eventTypeKey, selector) end

function Events.getSelector(eventTypeKey) end

function Events.getSelectors() end

function Events.hasDuplicateHandlers() end

function Events.getDuplicateHandlers() end

function Events.hasInvalidHandlers() end

--- Returns a placeholder selection parameter that matches all handlers registered for an event.
function Events.getAllHandlersPlaceholder() end

function Events.getInvalidHandlers() end

function Events.getEventTypes() end

return Events
