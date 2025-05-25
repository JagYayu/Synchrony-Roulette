--- @meta

local SettingsMenu = {}

function SettingsMenu.getLabelParts(key, args) end

function SettingsMenu.getLabel(key, args) end

function SettingsMenu.advancedSettingsVisible() end

function SettingsMenu.increment(key, args) end

function SettingsMenu.decrement(key, args) end

function SettingsMenu.createEntry(key, args) end

function SettingsMenu.createResetEntry(key, args) end

function SettingsMenu.createCustomRulesMenuEntry(showOverridable) end

function SettingsMenu.getMenuArgs(args) end

function SettingsMenu.open(args) end

function SettingsMenu.openDropdown(key, args) end

function SettingsMenu.hasVisibleEntries(prefix, layer, visibility) end

function SettingsMenu.createDynamicFooter(args) end

return SettingsMenu
