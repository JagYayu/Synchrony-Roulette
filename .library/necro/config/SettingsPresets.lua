--- @meta

local SettingsPresets = {}

function SettingsPresets.openDirectory() end

function SettingsPresets.list() end

function SettingsPresets.getDisplayName(name) end

function SettingsPresets.getFileName(name) end

function SettingsPresets.getSettings(name) end

function SettingsPresets.reset(layer) end

function SettingsPresets.load(name, layer) end

function SettingsPresets.save(name, layer) end

function SettingsPresets.delete(name) end

return SettingsPresets
