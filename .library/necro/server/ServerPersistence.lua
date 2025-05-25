--- @meta

local ServerPersistence = {}

function ServerPersistence.listSessions() end

function ServerPersistence.isValidSession(sessionName, cloud) end

function ServerPersistence.loadSession(sessionName, cloud) end

function ServerPersistence.saveSessionToMemory() end

function ServerPersistence.saveSession(sessionName, cloud) end

function ServerPersistence.saveSessionAsync(sessionName) end

function ServerPersistence.deleteSession(sessionName, cloud) end

function ServerPersistence.copySession(sourceName, destinationName) end

return ServerPersistence
