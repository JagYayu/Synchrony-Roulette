--- @meta

local SavefileXML = {}

function SavefileXML.toBoolean(value, default) end

function SavefileXML.mapSettings(layer, dataProvider) end

function SavefileXML.getData() end

function SavefileXML.getHash() end

function SavefileXML.getRemoteData() end

function SavefileXML.getRemoteHash() end

function SavefileXML.setAutoImportEnabled(enabled) end

function SavefileXML.isAutoImportEnabled() end

function SavefileXML.setFallbackImportEnabled(enabled) end

function SavefileXML.isFallbackImportEnabled() end

return SavefileXML
