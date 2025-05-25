local RouletteDelayEvents = {}
local RouletteUtility = require "Roulette.Utility"

local Delay = require "necro.game.system.Delay"
local EntitySelector = require "system.events.EntitySelector"
local LJBuffer = require "system.utils.serial.LJBuffer"
local Settings = require "necro.config.Settings"
local Snapshot = require "necro.game.system.Snapshot"
local Utilities = require "system.utils.Utilities"

SettingDelayEventParameterValidationCheck = Settings.shared.bool {
	id = "delayEventParameterValidationCheck",
	default = false,
	visibility = Settings.Visibility.HIDDEN,
}

local effectiveTimeScale

event.gameStateLevel.add(nil, "resetLevelVariables", function()
	effectiveTimeScale = nil
end)

SettingDelayTimeScale = Settings.shared.number {
	id = "delayTimeScale",
	name = "Global delay-event time scale",
	default = 1,
	minimum = 0,
	sliderMaximum = 2,
	step = .1,
	smoothStep = .01,
	setter = function()
		effectiveTimeScale = nil
	end,
	visibility = Settings.Visibility.HIDDEN,
}

TimeScales = Snapshot.runVariable {}

--- @type table<string, fun(entity: Entity, parameter: table)>
local sendFunctions = {}

--- @param name string
--- @return boolean
function RouletteDelayEvents.isValid(name)
	return not not sendFunctions[name]
end

local function getTimeScale()
	if not effectiveTimeScale then
		effectiveTimeScale = tonumber(SettingDelayTimeScale) or 1

		for _, scale in pairs(TimeScales) do
			effectiveTimeScale = effectiveTimeScale * scale
		end
	end

	return effectiveTimeScale
end

--- @param key any
--- @param scale number?
function RouletteDelayEvents.setTimeScale(key, scale)
	scale = tonumber(scale) or 1
	TimeScales[key] = (scale ~= 1) and scale or nil
	effectiveTimeScale = nil
end

--- @class DelayEvent.Parameter : table
--- @field delayTimeOverride number?
--- @field delayTimeScale number?

--- @param name string
--- @param entity Entity
--- @param parameter DelayEvent.Parameter?
function RouletteDelayEvents.send(name, entity, parameter)
	if not sendFunctions[name] then
		error(("delay event '%s' not found!"):format(name))
	end

	sendFunctions[name](entity, parameter or {})
end

RouletteDelayEvents.SlotIndex = 1
--- Increase this value if error occurs
RouletteDelayEvents.Slots = 1000
for i = 1, RouletteDelayEvents.Slots do
	_G[i] = false
end

RouletteDelayEvents.Key2SlotIndex = {}
function RouletteDelayEvents.allocSlot(key)
	local slot = RouletteDelayEvents.Key2SlotIndex[key]
	if not slot then
		local slotID = RouletteDelayEvents.SlotIndex
		if slotID > RouletteDelayEvents.Slots then
			error("Slot index exceed!", 3) -- see line:44
		end

		RouletteDelayEvents.SlotIndex = slotID + 1
		slot = slotID
		RouletteDelayEvents.Key2SlotIndex[key] = slot
	end
	return slot
end

local function applyDelayTime(delayTime, parameter)
	return (tonumber(parameter.delayTimeOverride) or delayTime) * (tonumber(parameter.delayTimeScale) or 1) * getTimeScale()
end

--- @class DelayEvents.RegisterOptional
--- @field eventBuilder? (fun(entity: Entity, parameter: table?): table)
--- @field eventTypeAlias? table[]
--- @field flags? Delay.Flags
--- @field selector? { new: fun(eventType: Event, param: string[], options: table?) }
--- @field selectorOptions? table

--- @param eventName string
--- @param orderKeys string[]
--- @param delayTimes number[]
--- @param optional? DelayEvents.RegisterOptional
--- @return fun(entity: Entity, parameter: table?) send
function RouletteDelayEvents.register(eventName, orderKeys, delayTimes, optional)
	optional = optional or {}
	local eventBuilder = optional.eventBuilder or function(entity, parameter)
		return {
			entity = entity,
			parameter = parameter,
		}
	end
	local selector = optional.selector or EntitySelector
	local eventTypeAlias = optional.eventTypeAlias or {}
	local flags = Utilities.mergeTables({
		immediate = true,
		processOnPlayerAction = false,
	}, optional.flags or {})

	if SettingDelayEventParameterValidationCheck then
		local builder = eventBuilder

		eventBuilder = function(entity, parameter)
			if not pcall(LJBuffer.encode, parameter) then
				error("Attempt to inject non-serializable fields into parameter of DelayEvent, this will desync!", 3)
			end

			return builder(entity, parameter)
		end
	end

	local firstSlotID
	local slotIDs = {}

	for index, delayTime in ipairs(delayTimes) do
		if type(delayTime) ~= "number" then
			error("number expected, got " .. type(delayTime), 2)
		end

		local slotID = RouletteDelayEvents.allocSlot(("%s:%d"):format(eventName, index))
		slotIDs[index] = slotID
		firstSlotID = firstSlotID or slotID

		local selectorOptions = optional.selectorOptions -- Utilities.mergeTables({ catchErrors = true }, optional.selectorOptions or RouletteUtility.emptyTable)
		local fire = selector.new(eventTypeAlias[index] or event[eventName .. index], orderKeys, selectorOptions).fire

		_G[slotID] = Delay.new(function(entity, parameter)
			fire(eventBuilder(entity, parameter), entity.name)

			local nextSlotID = slotIDs[index + 1]
			if nextSlotID then
				_G[nextSlotID](entity, parameter, applyDelayTime(delayTime, parameter))
			end
		end, flags)
	end

	if not firstSlotID then
		error("ERROR", 2)
	end

	local fire = selector.new(eventTypeAlias[0] or event[eventName], orderKeys).fire
	--- @param entity Entity
	--- @param parameter table
	local function send(entity, parameter)
		fire(eventBuilder(entity, parameter), entity.name)
		parameter = parameter or {}
		_G[firstSlotID](entity, parameter, applyDelayTime(delayTimes[1], parameter))
	end

	sendFunctions[eventName] = send
	return send
end

return RouletteDelayEvents
