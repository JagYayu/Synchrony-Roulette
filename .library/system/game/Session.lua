--- @meta

local Session = {}

function Session.isHeadless() end

function Session.getVersion() end

--- Creates a new session with the specified table of parameters, which can be read via `session.getLaunchParameter()`
function Session.duplicate(parameters) end

function Session.sendMessageToParent(message) end

function Session.receiveMessageFromParent() end

--- If this session was launched via `session.duplicate()`, this function can be used to obtain launch parameters.
function Session.getLaunchParameter(parameter) end

function Session.getDuplicateIndex() end

function Session.isDuplicate() end

function Session.getCommandLineArguments() end

function Session.hasCommandLineSwitch(name) end

function Session.getOperatingSystem() end

function Session.getArchitecture() end

function Session.getLuaJITVersion() end

function Session.getLuaJITStatus() end

function Session.reset() end

function Session.exit() end

return Session
