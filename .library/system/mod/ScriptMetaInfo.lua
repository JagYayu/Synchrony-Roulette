--- @meta

local ScriptMetaInfo = {}

function ScriptMetaInfo.uniqueIndex(counterName) end

function ScriptMetaInfo.uniqueIdentifier(counterName) end

function ScriptMetaInfo.prefixedUniqueIdentifier(counterName) end

function ScriptMetaInfo.getLoadingScript() end

function ScriptMetaInfo.getScriptFileName(scriptName) end

function ScriptMetaInfo.getLoadingMod() end

function ScriptMetaInfo.getNamespace() end

function ScriptMetaInfo.getLoadingModPriority() end

function ScriptMetaInfo.getLoadingModDisplayName() end

function ScriptMetaInfo.prefixWithNamespace(name, separator) end

function ScriptMetaInfo.validateAndPrefix(name) end

return ScriptMetaInfo
