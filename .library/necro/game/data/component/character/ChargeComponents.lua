--- @meta

local ChargeComponents = {}

--- Allows this entity to charge.
--- While this entity is charging, it is forced to keep moving in the same direction.
--- @class Component.charge
--- @field active boolean # `= false` 
--- @field direction integer # `= 0` 
--- @field maxBeatDelay integer # `= 0` 

--- Starts a charge when this entity is aligned with its target (AI-controlled only).
--- @class Component.chargeStartPreAI
--- @field maxDistance integer # `= 6` Inclusive maximum L∞ distance between this entity and its target
--- @field usePrevPos boolean # `= true` If true, this entity can also start a charge when aligned with its target’s previous position.
--- @field diagonal boolean # `= false` 

--- Starts a charge when this entity is aligned with its target (AI-controlled only).
--- @class Component.chargeStartOnFrame
--- @field maxDistance integer # `= 6` Inclusive maximum L∞ distance between this entity and its target

--- Starts a charge after converting from another type to this type.
--- @class Component.chargePostConvert
--- @field direction integer # `= 0` 

--- Starts a charge when this entity performs a directional action.
--- @class Component.chargeStartOnDirection

--- Starts a charge when this entity takes damage.
--- @class Component.chargeStartOnHit

--- Changes the direction of this entity’s charge when it takes damage while charging.
--- @class Component.chargeRedirectOnHit
--- @field orthogonalize boolean # `= false` If true, diagonal damage makes this entity charge horizontally, not diagonally.

--- Changes the direction of this entity’s charge when it moves while charging.
--- @class Component.chargeRedirectOnMove
--- @field orthogonalize boolean # `= false` 
--- @field requiredFlags Move.Flag # `= move.Flag.FORCED_MOVE` 

--- Required for `charge` to work on player-controlled entities.
--- @class Component.chargeOverrideActions

--- Starts a charge when aligned with an attackable enemy (player-controlled only).
--- @class Component.chargeControlledStartTowardsHostile
--- @field maxDistance integer # `= 0` 
--- @field attackFlags Attack.Flag # `= attack.Flag.CHARACTER` 

--- Prevents damage to this entity while it is charging.
--- @class Component.chargeShield
--- @field bypassFlags Damage.Flag # `= damage.Flag.BYPASS_ARMOR` 
--- @field bypassDamage integer # `= -1` 
--- @field damageReduction integer # `= 0` 
--- @field maximumDamageTaken integer # `= 0` 

--- Ends this entity’s charge on certain action results.
--- @class Component.chargeStopOnResults
--- @field stop table # Stop on any key in the table, value = true means silent stop

--- Increases this entity’s dig strength while it is charging.
--- @class Component.chargeDigStrength
--- @field addedStrength integer # `= 0` 
--- @field silentFail boolean # `= false` 

--- Changes the timing of charge moves (player-controlled only).
--- @class Component.chargeRhythmAutoPlay

--- Overrides this entity’s beat delay when its charge ends.
--- @class Component.chargeSetBeatDelayOnEnd
--- @field delay integer # `= 0` 

--- @class Entity
--- @field charge? Component.charge
--- @field chargeStartPreAI? Component.chargeStartPreAI
--- @field chargeStartOnFrame? Component.chargeStartOnFrame
--- @field chargePostConvert? Component.chargePostConvert
--- @field chargeStartOnDirection? Component.chargeStartOnDirection
--- @field chargeStartOnHit? Component.chargeStartOnHit
--- @field chargeRedirectOnHit? Component.chargeRedirectOnHit
--- @field chargeRedirectOnMove? Component.chargeRedirectOnMove
--- @field chargeOverrideActions? Component.chargeOverrideActions
--- @field chargeControlledStartTowardsHostile? Component.chargeControlledStartTowardsHostile
--- @field chargeShield? Component.chargeShield
--- @field chargeStopOnResults? Component.chargeStopOnResults
--- @field chargeDigStrength? Component.chargeDigStrength
--- @field chargeRhythmAutoPlay? Component.chargeRhythmAutoPlay
--- @field chargeSetBeatDelayOnEnd? Component.chargeSetBeatDelayOnEnd

return ChargeComponents
