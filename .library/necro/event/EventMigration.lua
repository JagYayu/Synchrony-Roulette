--- @meta

local EventMigration = {}

--- @class EventHandlerRegistration
--- @field event string Event type name
--- @field name string Event handler name
--- @field key table|string Event type order/filter data
--- @field orderKey string Extracted order key of the event handler
--- @field func function Handler function
--- @field override boolean False for normal registrations, true for overrides
--- @field script string Name of the script the event handler is registered in

--- @param registration EventHandlerRegistration
function EventMigration.apply(registration) end

function EventMigration.hasMigration(eventTypeName) end

return EventMigration
