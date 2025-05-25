--- @meta

local ItemConversionComponents = {}

--- Allows this item to be converted by spells.
--- @class Component.itemTransmutable

--- Forces a specific result when this item transmuted.
--- @class Component.itemTransmutableFixedOutcome
--- @field target string # `= ""` 

--- @class Entity
--- @field itemTransmutable Component.itemTransmutable
--- @field itemTransmutableFixedOutcome Component.itemTransmutableFixedOutcome

return ItemConversionComponents
