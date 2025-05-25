--- @meta

local FreezeComponents = {}

--- Status effect. While frozen, this entity cannot perform directional actions, and most moves are inhibited.
--- @class Component.freezable
--- @field remainingTurns integer # `= 0` 
--- @field permanent boolean # `= false` 
--- @field pendingAction boolean # `= false` 
--- @field type integer # `= 0` 

--- Unfreezes this entity when it takes damage.
--- @class Component.freezableThawOnHit

--- Prevents this entity from performing any action while frozen.
--- @class Component.freezablePreventActions

--- Prevents this entity from being knocked back while frozen.
--- (The knockback’s movement is inhibited anyway, but this component also prevents
--- any other effects from the knockback, such as beat delay).
--- @class Component.freezableInhibitKnockback

--- Modifies this entity’s attackability while it is frozen.
--- @class Component.freezeAttackableFlags
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- @class Entity
--- @field freezable Component.freezable
--- @field freezableThawOnHit Component.freezableThawOnHit
--- @field freezablePreventActions Component.freezablePreventActions
--- @field freezableInhibitKnockback Component.freezableInhibitKnockback
--- @field freezeAttackableFlags Component.freezeAttackableFlags

return FreezeComponents
