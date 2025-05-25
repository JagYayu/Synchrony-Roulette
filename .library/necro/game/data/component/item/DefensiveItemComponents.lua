--- @meta

local DefensiveItemComponents = {}

--- Protects the holder from damage. May not reduce damage below 1.
--- @class Component.itemArmor
--- @field bypassFlags Damage.Flag # `= damage.Flag.BYPASS_ARMOR` Damage with any of these flags will bypass the armor.
--- @field bypassDamage integer # `= -1` Damage higher than this will bypass the armor (-1 = not bypassable).
--- @field damageReduction integer # `= 0` Flat amount subtracted from incoming damage when the armor applies.
--- @field maximumDamageTaken integer # `= 32767` Cap on the final amount of damage taken when the armor applies.

--- Same as `itemArmor`, but applies later, leading to slightly different interactions with other armor.
--- @class Component.itemArmorLate
--- @field bypassFlags Damage.Flag # `= damage.Flag.BYPASS_ARMOR` 
--- @field bypassDamage integer # `= -1` 
--- @field damageReduction integer # `= 0` 
--- @field maximumDamageTaken integer # `= 32767` 

--- Same as `itemArmor`, but the damage reduction depends on the holder’s groove chain.
--- @class Component.itemArmorGrooveChain
--- @field bypassFlags Damage.Flag # `= damage.Flag.BYPASS_ARMOR` 
--- @field bypassDamage integer # `= -1` 
--- @field damageReduction integer # `= 0` 
--- @field maximumDamageTaken integer # `= 32767` 
--- @field damageReductionMultiplier integer # `= 0` 
--- @field baseDamageReduction integer # `= 0` 

--- Protects the holder from a given damage type. This happens before `invincibilityOnHit`, so
--- the holder does not get iframes for damage prevented this way.
--- @class Component.itemIncomingDamageTypeImmunityEarly
--- @field immuneDamageTypes integer # `= 0` 

--- Protects the holder from a given damage type. The holder still gets iframes for that damage.
--- “Late” here means that it happens after `itemIncomingDamageTypeImmunityEarly` and `invincibilityOnHit`;
--- it still happens before untyped damage suppression, like `itemIncomingDamageImmunityFirst`.
--- @class Component.itemIncomingDamageTypeImmunityLate
--- @field immuneDamageTypes integer # `= 0` 

--- Protects the holder from non-piercing damage.
--- @class Component.itemIncomingDamageImmunityFirst

--- Protects the holder from non-piercing damage.
--- @class Component.itemIncomingDamageImmunityEarly

--- Protects the holder from non-piercing damage.
--- @class Component.itemIncomingDamageImmunityLate

--- Protects the holder from non-piercing damage.
--- @class Component.itemIncomingDamageImmunityLast

--- Consumes this item when it prevents damage.
--- @class Component.itemIncomingDamageImmunityConsume

--- Casts a spell when this item prevents damage.
--- @class Component.itemIncomingDamageImmunityCastSpell
--- @field spell string # `= ""` 

--- When this item prevents damage, also prevents the attacker from stealing anything.
--- @class Component.itemIncomingDamageImmunitySuppressTheft

--- Creates a flyaway when this item prevents damage.
--- @class Component.itemIncomingDamageImmunityFlyaway
--- @field text localizedString # `= 0` 
--- @field offsetY integer # `= -14` 

--- Freezes the screen for the holder when this item prevents damage.
--- @class Component.itemIncomingDamageImmunityHitstop
--- @field duration number # `= 0.08` 

--- Conditionally protects the holder from damage for a limited time (courage).
--- @class Component.itemConditionalInvincibility
--- @field active boolean # `= false` 

--- Activates this item’s `itemConditionalInvincibility` when the holder kills an enemy during a weapon attack.
--- This requires the killed enemy to grant `INVINCIBILITY` credit (see `Kill.Credit`).
--- @class Component.itemConditionalInvincibilityOnKill
--- @field active boolean # `= false` 

--- Activates this item’s `itemConditionalInvincibility` when the holder digs a wall.
--- @class Component.itemConditionalInvincibilityOnDig
--- @field minimumDigStrength Dig.Strength # `= dig.Strength.EARTH` 

--- Protect the holder from grabs while this item’s `itemConditionalInvincibility` is active.
--- @class Component.itemConditionalInvincibilityGrabImmunity

--- Multiplies damage taken by the holder.
--- @class Component.itemIncomingDamageMultiplier
--- @field bypassFlags Damage.Flag # `= damage.Flag.SELF_DAMAGE` 
--- @field multiplier integer # `= 1` 

--- Adds a flat bonus to damage taken by the holder.
--- @class Component.itemIncomingDamageIncrease
--- @field bypassFlags Damage.Flag # `= damage.Flag.SELF_DAMAGE` 
--- @field increase integer # `= 1` 

--- Specific to the Monkey’s Paw.
--- @class Component.itemFreezeMonkeyLikes

--- Protects the holder from some music-related effects (tempo traps, banshee wail).
--- @class Component.itemMusicChangeImmunity
--- @field flyaway localizedString # `= "Muffled!"` 

--- @class Entity
--- @field itemArmor Component.itemArmor
--- @field itemArmorLate Component.itemArmorLate
--- @field itemArmorGrooveChain Component.itemArmorGrooveChain
--- @field itemIncomingDamageTypeImmunityEarly Component.itemIncomingDamageTypeImmunityEarly
--- @field itemIncomingDamageTypeImmunityLate Component.itemIncomingDamageTypeImmunityLate
--- @field itemIncomingDamageImmunityFirst Component.itemIncomingDamageImmunityFirst
--- @field itemIncomingDamageImmunityEarly Component.itemIncomingDamageImmunityEarly
--- @field itemIncomingDamageImmunityLate Component.itemIncomingDamageImmunityLate
--- @field itemIncomingDamageImmunityLast Component.itemIncomingDamageImmunityLast
--- @field itemIncomingDamageImmunityConsume Component.itemIncomingDamageImmunityConsume
--- @field itemIncomingDamageImmunityCastSpell Component.itemIncomingDamageImmunityCastSpell
--- @field itemIncomingDamageImmunitySuppressTheft Component.itemIncomingDamageImmunitySuppressTheft
--- @field itemIncomingDamageImmunityFlyaway Component.itemIncomingDamageImmunityFlyaway
--- @field itemIncomingDamageImmunityHitstop Component.itemIncomingDamageImmunityHitstop
--- @field itemConditionalInvincibility Component.itemConditionalInvincibility
--- @field itemConditionalInvincibilityOnKill Component.itemConditionalInvincibilityOnKill
--- @field itemConditionalInvincibilityOnDig Component.itemConditionalInvincibilityOnDig
--- @field itemConditionalInvincibilityGrabImmunity Component.itemConditionalInvincibilityGrabImmunity
--- @field itemIncomingDamageMultiplier Component.itemIncomingDamageMultiplier
--- @field itemIncomingDamageIncrease Component.itemIncomingDamageIncrease
--- @field itemFreezeMonkeyLikes Component.itemFreezeMonkeyLikes
--- @field itemMusicChangeImmunity Component.itemMusicChangeImmunity

return DefensiveItemComponents
