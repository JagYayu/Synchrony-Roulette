--- @meta

local ExtraModeComponents = {}

--- Grants an item to this entity if No Return mode is active.
--- @class Component.extraModeNoReturnInnateItem
--- @field type string # `= ""` 

--- Grants an item to this entity if Phasing mode is active.
--- @class Component.extraModePhasingInnateItem
--- @field type string # `= ""` 

--- Modifies this entity’s z-order if Phasing mode is active.
--- @class Component.extraModePhasingRowOrder
--- @field z integer # `= 10` 

--- Grants some items to this entity if Dancepad mode is active.
--- @class Component.extraModeDancepadGrantItems
--- @field types table # 

--- Overrides `beatDelay.interval` when converting to this entity type if Randomizer mode is active.
--- This is used to reproduce 2.59 quirks, and is not recommended for use in mods.
--- @class Component.randomizerBeatIntervalFix
--- @field interval integer # `= 0` The value beatDelay.interval is set to when converting into this entity type. 0 = preserve old interval.

--- Prevents this item from being added to the starting inventory in Ensemble Mode.
--- @class Component.extraModeEnsembleExcludeInitialItems
--- @field types table # 

--- @class Entity
--- @field extraModeNoReturnInnateItem Component.extraModeNoReturnInnateItem
--- @field extraModePhasingInnateItem Component.extraModePhasingInnateItem
--- @field extraModePhasingRowOrder Component.extraModePhasingRowOrder
--- @field extraModeDancepadGrantItems Component.extraModeDancepadGrantItems
--- @field randomizerBeatIntervalFix Component.randomizerBeatIntervalFix
--- @field extraModeEnsembleExcludeInitialItems Component.extraModeEnsembleExcludeInitialItems

return ExtraModeComponents
