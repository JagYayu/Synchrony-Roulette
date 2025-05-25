--- @meta

local Errors = {}

function Errors.hasError() end

function Errors.hasLoadTimeErrors() end

function Errors.hasOnlyExecutionErrors() end

function Errors.update() end

function Errors.addExecutionError(scriptName, eventType, funcName, errorText) end

function Errors.clearExecutionErrors() end

function Errors.getErrorMods() end

function Errors.openScriptEditor(script, line) end

function Errors.collectErrors() end

return Errors
