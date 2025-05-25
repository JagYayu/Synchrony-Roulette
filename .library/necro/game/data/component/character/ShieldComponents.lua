--- @meta

local ShieldComponents = {}

--- Conditionally protects this entity from damage.
--- @class Component.shield
--- @field bypassFlags Damage.Flag # `= damage.Flag.BYPASS_ARMOR` Damage with any of these flags will bypass the shield.
--- @field bypassDamage integer # `= -1` Damage higher than this will bypass the shield (-1 = not bypassable).
--- @field damageReduction integer # `= 0` Flat amount subtracted from incoming damage when the shield applies. This can cause the damage to end up negative!
--- @field maximumDamageTaken integer # `= 0` Cap on the final amount of damage taken when the shield applies.
--- @field active boolean # `= true` If false, the shield doesn’t apply. Set to false when the shield is broken.

--- Protects this entity from a given damage type.
--- Despite the name, this component is unrelated to `shield`.
--- @class Component.shieldDamageType
--- @field requiredFlags integer # `= 0` Only damage with all of these flags is affected.
--- @field damage integer # `= 0` Overrides amount of damage dealt by incoming damage matching `requiredFlags`.
--- @field knockback integer # `= 0` Overrides the knockback caused by incoming damage matching `requiredFlags`.

--- Restricts this entity’s `shield` to a specific direction.
--- Any damage that doesn’t match this direction will bypass the shield.
--- @class Component.shieldDirection
--- @field direction integer # `= 0` 

--- Updates this entity’s shield direction to match its facing direction.
--- @class Component.shieldDirectionFollowFacingDirection

--- Breaks this entity’s `shield` when it successfully blocks damage.
--- @class Component.shieldBreakOnHit
--- @field minimumDamage integer # `= 0` 

--- Breaks this entity’s `shield` when it fails to block damage.
--- @class Component.shieldBreakOnBypass
--- @field minimumDamage integer # `= 1` 

--- Converts this entity to another type when its shield breaks.
--- @class Component.shieldBreakConvert
--- @field targetType string # `= ""` 

--- Moves this entity when it shields damage.
--- @class Component.shieldDodgeOnHit
--- @field relativeToAttacker boolean # `= true` 
--- @field useDamageDirection boolean # `= false` 
--- @field collisionMask Collision.Type # `= 0` 
--- @field moveType Move.Flag # `= move.Type.UNCHECKED` 
--- @field offsets table # 
--- @field spell string # `= ""` 
--- @field attacker Entity.ID # 
--- @field direction integer # `= 0` 

--- Overrides this entity’s beat delay when it shields damage.
--- @class Component.shieldSetBeatDelay
--- @field delay integer # `= 1` 

--- Overrides the knockback caused by shielded damage.
--- @class Component.shieldKnockbackOnHit
--- @field distance integer # `= 1` 

--- Prevents the entity from acting for the remainder of the current turn after shielding damage.
--- @class Component.shieldPreventActionOnHit

--- Creates a flyaway when this entity shields damage.
--- @class Component.shieldFlyawayOnHit
--- @field text localizedString # `= "Shielded!"` 

--- Prevents the regular hit sound from playing for shielded hits.
--- @class Component.shieldSuppressHitSound

--- Prevents the regular hit voiceline from playing for shielded hits.
--- @class Component.shieldSuppressHitVoice

--- Status effect. While active, this entity is shielded from damage (used by shield spell).
--- @class Component.barrier
--- @field bypassFlags Damage.Flag # `= damage.Flag.BYPASS_ARMOR` 
--- @field bypassDamage integer # `= -1` 
--- @field damageReduction integer # `= 0` 
--- @field maximumDamageTaken integer # `= 0` 
--- @field remainingTurns integer # `= 0` 
--- @field permanent boolean # `= false` 

--- Protects this entity from damage based on its beat delay.
--- @class Component.beatDelayShield
--- @field maxBeatDelay integer # `= 0` 

--- Specific to skeleton knights.
--- @class Component.dismountOnHit
--- @field targetType string # `= ""` 
--- @field active boolean # `= true` 

--- @class Entity
--- @field shield Component.shield
--- @field shieldDamageType Component.shieldDamageType
--- @field shieldDirection Component.shieldDirection
--- @field shieldDirectionFollowFacingDirection Component.shieldDirectionFollowFacingDirection
--- @field shieldBreakOnHit Component.shieldBreakOnHit
--- @field shieldBreakOnBypass Component.shieldBreakOnBypass
--- @field shieldBreakConvert Component.shieldBreakConvert
--- @field shieldDodgeOnHit Component.shieldDodgeOnHit
--- @field shieldSetBeatDelay Component.shieldSetBeatDelay
--- @field shieldKnockbackOnHit Component.shieldKnockbackOnHit
--- @field shieldPreventActionOnHit Component.shieldPreventActionOnHit
--- @field shieldFlyawayOnHit Component.shieldFlyawayOnHit
--- @field shieldSuppressHitSound Component.shieldSuppressHitSound
--- @field shieldSuppressHitVoice Component.shieldSuppressHitVoice
--- @field barrier Component.barrier
--- @field beatDelayShield Component.beatDelayShield
--- @field dismountOnHit Component.dismountOnHit

return ShieldComponents
