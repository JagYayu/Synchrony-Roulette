--- @meta

local SettingsStorage = {}

--- @class SettingsStorageData : SettingsArgs
--- @field layerSet table
--- @field layerVisibility table

function SettingsStorage.isValid(key) end

function SettingsStorage.set(key, value, layer) end

function SettingsStorage.get(key, layer) end

function SettingsStorage.getSerializedSettings(layer, excludeTransient) end

function SettingsStorage.overrideSerializedSettings(layer, values) end

function SettingsStorage.clearSettingsLayer(layer) end

function SettingsStorage.getFormattedValue(key, value) end

function SettingsStorage.getDefaultValue(key) end

function SettingsStorage.getName(key) end

function SettingsStorage.getDescription(key) end

function SettingsStorage.getType(key) end

function SettingsStorage.getOrder(key) end

function SettingsStorage.getEntryOrder(key) end

function SettingsStorage.getVisibility(key, layer) end

function SettingsStorage.getScope(key) end

function SettingsStorage.getTreeKey(key) end

function SettingsStorage.getEnableIf(key) end

function SettingsStorage.isTransient(key) end

function SettingsStorage.getFormatter(key) end

function SettingsStorage.getNumericParameters(key) end

function SettingsStorage.getMaxLength(key) end

function SettingsStorage.getChoice(key, index) end

function SettingsStorage.getChoiceIndex(key, value) end

function SettingsStorage.getChoiceCount(key) end

function SettingsStorage.getChoiceToggle(key) end

--- Returns a function or boolean indicating whether this setting is considered a cheat if modified
--- @param key string
--- @return Settings.CheatFlag
function SettingsStorage.getCheatFlag(key) end

function SettingsStorage.getAction(key) end

function SettingsStorage.serialize(key, value) end

function SettingsStorage.deserialize(key, value) end

function SettingsStorage.getDecisiveLayer(key) end

function SettingsStorage.isSettableInLayer(key, layer) end

function SettingsStorage.setCurrentScriptKeyPrefix(prefix) end

function SettingsStorage.register(parameters) end

function SettingsStorage.registerVirtual(parameters) end

function SettingsStorage.unregisterVirtual(id) end

function SettingsStorage.listKeys(prefix, layer) end

--- @param key string
--- @return Settings.Association
function SettingsStorage.getAssociation(key) end

--- @param key string
--- @return Settings.Cloud
function SettingsStorage.getCloudMode(key) end

function SettingsStorage.loadFromFile() end

function SettingsStorage.prettyPrint(serializedSettingsValues) end

function SettingsStorage.saveToFile(backup) end

return SettingsStorage
