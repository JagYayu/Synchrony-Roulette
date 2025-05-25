local config = require "necro.config.Config"
local controls = require "necro.config.Controls"
local settingsStorage = require "necro.config.SettingsStorage"
local enum = require "system.utils.Enum"
local stringUtils = require "system.utils.StringUtilities"

local prefix = (enum.string{}).extend("")

local function isBound(bind)
	return type(bind) == "string" and bind ~= "None" and bind ~= "none"
end

local function isValidDefaultBinding(key)
	return isBound(key.default) or (type(key.default) == "table" and isBound(key.default[1]))
end

local function isModPrefixed(key)
	return type(key.enumName) == "string" and stringUtils.startsWith(key.enumName, prefix)
end

local function button(index, btn) return (string.format("pad%d_%s", index, btn)) end
local function lt(index) return button(index, config.osPS and 17 or "axis10") end
local function rt(index) return button(index, config.osPS and 18 or "axis12") end
local function combo(index, b1, b2) return controls.formatMultiKey { button(index, b1), (button(index, b2)) } end

local function isAlreadyInUse(bind)
	local result = controls.lookUpMappedKey(bind)
	if result then
		for _, entry in ipairs(result) do
			if entry.type == "action" then
				return entry
			end
		end
	end
	return false
end

local function tryBindUnusedKey(inputID, key, bind)
	if not isAlreadyInUse(bind) then
		controls.setKeyBind(inputID, key.type, key.id, 1, bind)
		return bind
	end
end

local function tryBindSpell(index, inputID, key)
	-- Bind spells to LT/RT
	if key.type == "action" and key.enumName:lower():find("spell%d") then
		return tryBindUnusedKey(inputID, key, lt(index)) or tryBindUnusedKey(inputID, key, rt(index))
	end
end

local function tryBindGenericAction(index, inputID, key)
	-- Bind other actions to right stick motion
	return tryBindUnusedKey(inputID, key, button(index, "axis5"))
	    or tryBindUnusedKey(inputID, key, button(index, "axis6"))
	    or tryBindUnusedKey(inputID, key, button(index, "axis7"))
	    or tryBindUnusedKey(inputID, key, button(index, "axis8"))
	    or tryBindUnusedKey(inputID, key, combo(index, "axis5", "axis7"))
	    or tryBindUnusedKey(inputID, key, combo(index, "axis6", "axis7"))
	    or tryBindUnusedKey(inputID, key, combo(index, "axis5", "axis8"))
	    or tryBindUnusedKey(inputID, key, combo(index, "axis6", "axis8"))
end

local function initButtonBinder()
	if config.osDesktop then
		return
	end

	local legacyInputMaps = settingsStorage.get("input.legacyInputMaps")
	if type(legacyInputMaps) ~= "table" then
		return
	end

	local function processKey(key)
		if key.custom and key.type == "action" and isModPrefixed(key) and isValidDefaultBinding(key) then
			for index, inputID in ipairs(legacyInputMaps) do
				if controls.getKeyBinds(inputID, key.type, key.id) == nil then
					local bind = tryBindSpell(index, inputID, key) or tryBindGenericAction(index, inputID, key)
					if bind and index == 1 then
						log.info("Auto-binding '%s' to '%s'", key.name or key.enumName, bind)
					end
				end
			end
		end
	end

	for _, key in ipairs(controls.getBindableKeys()) do
		pcall(processKey, key)
	end
end

event.contentLoad.add("initButtonBinder", {order = "progression", sequence = 1}, initButtonBinder)
