--- @meta

local ParryComponents = {}

--- Makes this entity parry all parryable damage, except while frozen.
--- @class Component.parry
--- @field cooldown integer # `= 0` 

--- Moves this entity backwards when it performs a parry.
--- @class Component.parryKnockback
--- @field moveType Move.Flag, move.Flag.mask(move.Type.NORMAL # `= move.Flag.FORCED_MOVE)` 
--- @field orthogonalize boolean # `= false` If true, this entity is knocked back horizontally when parrying diagonal damage.

--- Creates a flyaway when this entity performs a parry.
--- @class Component.parryFlyaway
--- @field text localizedString # `= "Parried!"` 

--- Causes this entity to counter-attack after a successful parry.
--- Also disables parries for one beat after the counter-attack.
--- @class Component.parryCounterAttack
--- @field active boolean # `= false` 
--- @field direction integer # `= 0` 
--- @field parryCooldown integer # `= 1` 
--- @field distance integer # `= 2` 
--- @field moveType Move.Flag, move.Flag.mask(move.Type.NORMAL # `= move.Flag.TWEEN_QUARTIC)` 
--- @field sound string # `= ""` 

--- @class Entity
--- @field parry Component.parry
--- @field parryKnockback Component.parryKnockback
--- @field parryFlyaway Component.parryFlyaway
--- @field parryCounterAttack Component.parryCounterAttack

return ParryComponents
