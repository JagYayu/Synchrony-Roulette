--- @meta

local SpellCheckComponents = {}

--- Fires the `spellCheck` event before this spell is cast. If `ev.suppressed` is set, the cast is cancelled.
--- All components used in the `spellCheck` event should declare this as a dependency.
--- @class Component.spellCheck

--- Checks that this spell hasn’t been cast more than a given number of times this run.
--- @class Component.spellCheckLimitPerRun
--- @field limit integer # `= 1` 
--- @field key string # `= ""` 

--- Checks whether the caster was visible last beat (requires `pastVisibility` on the caster).
--- @class Component.spellCheckWasVisible
--- @field value boolean # `= true` 

--- Checks whether the caster is revealed.
--- @class Component.spellCheckRevealed
--- @field value boolean # `= true` 

--- Checks whether the caster is provoked.
--- @class Component.spellCheckProvoked
--- @field value boolean # `= true` 

--- Checks whether the caster is descending.
--- @class Component.spellCheckDescent
--- @field value boolean # `= true` 

--- Checks whether the caster has a given component.
--- @class Component.spellCheckComponent
--- @field name string # `= ""` 
--- @field value boolean # `= true` 

--- Checks whether the current floor is a boss floor.
--- @class Component.spellCheckBossFloor
--- @field value boolean # `= true` 

--- Checks whether the current floor is "safe" (lobby, char select).
--- @class Component.spellCheckSafeLevel
--- @field value boolean # `= true` 

--- Checks whether the cast tile has a given tileInfo flag.
--- @class Component.spellCheckTileInfo
--- @field flag string # `= ""` 
--- @field value boolean # `= true` 

--- Checks whether the caster’s holder’s tile has a given collision mask.
--- If the caster doesn’t have a holder, check the caster’s tile instead.
--- @class Component.spellCheckHolderCollision
--- @field mask integer # `= 0` 
--- @field value boolean # `= true` 

--- @class Component.spellCheckTargetCount
--- @field attackFlags Attack.Flag # `= attack.Flag.CHARACTER` 
--- @field min integer # `= 0` 
--- @field max integer # `= -1` 

--- Checks whether the caster has any item in the given slot.
--- @class Component.spellCheckEmptySlot
--- @field slot string # `= ""` 
--- @field value boolean # `= true` 

--- Checks whether the caster has an item with the given component.
--- @class Component.spellCheckHasItem
--- @field component string # `= ""` 
--- @field value boolean # `= true` 

--- Checks whether the caster is affected by the given status effect.
--- @class Component.spellCheckStatusEffect
--- @field name string # `= ""` 
--- @field value boolean # `= true` 

--- Checks how much gold the caster has.
--- @class Component.spellCheckCurrency
--- @field currencyType string # `= "gold"` 
--- @field min integer # `= 0` 
--- @field max integer # `= -1` 

--- Checks how much health the caster has.
--- @class Component.spellCheckHealth
--- @field min integer # `= 0` 
--- @field max integer # `= -1` 

--- Specific to the Mommy.
--- @class Component.spellCheckSpawnPrep

--- Prevents this spell from recursively casting itself and causing a stack overflow.
--- @class Component.spellCheckLimitRecursionDepth
--- @field limit integer # `= 25` 

--- @class Entity
--- @field spellCheck Component.spellCheck
--- @field spellCheckLimitPerRun Component.spellCheckLimitPerRun
--- @field spellCheckWasVisible Component.spellCheckWasVisible
--- @field spellCheckRevealed Component.spellCheckRevealed
--- @field spellCheckProvoked Component.spellCheckProvoked
--- @field spellCheckDescent Component.spellCheckDescent
--- @field spellCheckComponent Component.spellCheckComponent
--- @field spellCheckBossFloor Component.spellCheckBossFloor
--- @field spellCheckSafeLevel Component.spellCheckSafeLevel
--- @field spellCheckTileInfo Component.spellCheckTileInfo
--- @field spellCheckHolderCollision Component.spellCheckHolderCollision
--- @field spellCheckTargetCount Component.spellCheckTargetCount
--- @field spellCheckEmptySlot Component.spellCheckEmptySlot
--- @field spellCheckHasItem Component.spellCheckHasItem
--- @field spellCheckStatusEffect Component.spellCheckStatusEffect
--- @field spellCheckCurrency Component.spellCheckCurrency
--- @field spellCheckHealth Component.spellCheckHealth
--- @field spellCheckSpawnPrep Component.spellCheckSpawnPrep
--- @field spellCheckLimitRecursionDepth Component.spellCheckLimitRecursionDepth

return SpellCheckComponents
