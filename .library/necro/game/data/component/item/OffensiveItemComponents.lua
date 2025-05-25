--- @meta

local OffensiveItemComponents = {}

--- Adds a flat bonus to damage dealt by the holder.
--- @class Component.itemAttackDamageIncrease
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field increase integer # `= 0` 

--- Multiplies base damage dealt by the holder (excluding other bonuses).
--- @class Component.itemAttackBaseDamageMultiplier
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field multiplier integer # `= 1` 

--- Multiplies total damage dealt by the holder (including other bonuses).
--- @class Component.itemAttackFinalDamageMultiplier
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field multiplier integer # `= 1` 

--- Sets knockback dealt by the holder’s attacks.
--- @class Component.itemAttackOverrideKnockback
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field distance integer # `= 1` 

--- Adds extra damage flags to the holder’s attacks (see `Damage.Flag`).
--- @class Component.itemDamageFlags
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field addedFlags integer # `= 0` 

--- Freezes enemies damaged by the holder.
--- @class Component.itemFreezeOnAttack
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field duration integer # `= 3` 
--- @field damage integer # `= 999` 

--- Increases the holder’s wire level (requires `wired` on the holder).
--- @class Component.itemWireLevel

--- Increases the damage if a certain condition is met
--- @class Component.itemConditionalDamageIncrease
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field increase integer # `= 0` 
--- @field setHitChain boolean # `= false` 
--- @field remainingTurns integer # `= 0` 

--- Activates the item's conditional damage buff whenever the holder digs a wall
--- @class Component.itemConditionalDamageOnDig
--- @field minimumDigStrength integer # `= 0` 

--- Activates the item's conditional damage buff whenever the holder gains currency of a specific type
--- @class Component.itemConditionalDamageOnCurrencyGain
--- @field currencyType string # `= currency.Type.GOLD` 

--- Activates the item's conditional damage buff while the holder is on low health
--- @class Component.itemConditionalDamageOnLowHealth
--- @field threshold integer # `= 1` 

--- Activates the item's conditional damage buff when item is activated.
--- @class Component.itemConditionalDamageOnActivation

--- Activates the item's conditional damage buff when the holder wired level is above the threshold.
--- @class Component.itemConditionalDamageOnWireLevel
--- @field threshold integer # `= 0` 

--- Multiplies base damage based on the item's current combo.
--- @class Component.itemComboDamageMultiplier
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field setHitChain boolean # `= false` 
--- @field multipliers table # Maps combo count => damage multiplier.
--- @field loop boolean # `= false` Determines which multiplier to use once the combo count exceeds the length of the multiplier list. If true, wrap back to the beginning (ABCABC…). If false, keep using the last multiplier (ABCCCC…).

--- Multiplies damage based on the holder's current groove chain
--- @class Component.itemGrooveChainDamageMultiplier
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 

--- When a reflectable projectile entity (`projectileReflectable` component) is damaged using this weapon, a copy of
--- the projectile is created for the killer's team. Must be placed on a weapon (`ev.weapon` in `event.objectTakeDamage`).
--- @class Component.itemReflectProjectileOnKill

--- Temporarily changes the entity's team while performing an action.
--- @class Component.itemTeamChangeDuringAction
--- @field team Team.Id # `= team.Id.NONE` 

--- @class Entity
--- @field itemAttackDamageIncrease Component.itemAttackDamageIncrease
--- @field itemAttackBaseDamageMultiplier Component.itemAttackBaseDamageMultiplier
--- @field itemAttackFinalDamageMultiplier Component.itemAttackFinalDamageMultiplier
--- @field itemAttackOverrideKnockback Component.itemAttackOverrideKnockback
--- @field itemDamageFlags Component.itemDamageFlags
--- @field itemFreezeOnAttack Component.itemFreezeOnAttack
--- @field itemWireLevel Component.itemWireLevel
--- @field itemConditionalDamageIncrease Component.itemConditionalDamageIncrease
--- @field itemConditionalDamageOnDig Component.itemConditionalDamageOnDig
--- @field itemConditionalDamageOnCurrencyGain Component.itemConditionalDamageOnCurrencyGain
--- @field itemConditionalDamageOnLowHealth Component.itemConditionalDamageOnLowHealth
--- @field itemConditionalDamageOnActivation Component.itemConditionalDamageOnActivation
--- @field itemConditionalDamageOnWireLevel Component.itemConditionalDamageOnWireLevel
--- @field itemComboDamageMultiplier Component.itemComboDamageMultiplier
--- @field itemGrooveChainDamageMultiplier Component.itemGrooveChainDamageMultiplier
--- @field itemReflectProjectileOnKill Component.itemReflectProjectileOnKill
--- @field itemTeamChangeDuringAction Component.itemTeamChangeDuringAction

return OffensiveItemComponents
