--- @meta

local ConfusionComponents = {}

--- Status effect. While confused, directional actions performed by this entity are inverted.
--- @class Component.confusable
--- @field remainingTurns integer # `= 0` 
--- @field permanent boolean # `= false` 

--- Overrides this entity’s dig strength while it is confused.
--- @class Component.confusableDigStrength
--- @field strength Dig.Strength # `= dig.Strength.NONE` 

--- Overrides this entity’s AI while it is confused.
--- @class Component.confusableAIOverride
--- @field id Ai.Type # `= ai.Type.SEEK` 

--- @class Entity
--- @field confusable Component.confusable
--- @field confusableDigStrength Component.confusableDigStrength
--- @field confusableAIOverride Component.confusableAIOverride

return ConfusionComponents
