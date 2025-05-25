--- @meta

local SpellTransmute = {}

--- Result of a transmutation.
--- * string: transmutation successful, contains entity type name to transmute into
--- * false: transmutation failed, item deleted
--- * nil: transmutation skipped, item unchanged
--- @alias SpellTransmute.Result Entity.Type|false|nil

--- Fired when an item is converted by a Transmute Spell.
--- Any handlers ordered after `convertItem` must assume that the item no longer matches the event handler's component
--- filters, as the conversion is immediate!
--- @class Event.SpellTransmute
--- @field item? Entity The item being transmuted
--- @field caster? Entity The entity (typically a player) performing the transmutation
--- @field spell? Entity Spellcast entity using which the transmutation is being performed
--- @field choiceArgs? ItemGeneration.ChoiceArguments Item generation parameters for this transmutation
--- @field target SpellTransmute.Result Transmutation target, determines what is done to the item entity
--- @field result SpellTransmute.Result Logical result of the transmutation, return value of `transmuteItem()`
--- @field suppressPickup boolean? If non-nil, changes the item to be pickup-suppressed (true) or unsuppressed (false)

--- Performs an item transmutation (Transmute Spell)
--- @param args Event.SpellTransmute
--- @return SpellTransmute.Result result
function SpellTransmute.transmuteItem(args) end

return SpellTransmute
