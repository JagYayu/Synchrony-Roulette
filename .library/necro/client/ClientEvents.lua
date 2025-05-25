--- @meta

local ClientEvents = {}

function ClientEvents.fireEvent(eventTypeName, parameter) end

function ClientEvents.receiveMessage(messageType, message, playerID) end

return ClientEvents
