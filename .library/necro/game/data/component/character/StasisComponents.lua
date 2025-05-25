--- @meta

local StasisComponents = {}

--- Tracks a toggleable "stasis" state. The effects of being in stasis are determined purely by other components.
--- @class Component.stasis
--- @field active boolean # `= true` Protected field! Do not set directly, use `Stasis.setStasis` instead.

--- Modifies this entity’s attackability while it is in stasis.
--- @class Component.stasisAttackableFlags
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- Overrides this entity’s AI while it is in stasis.
--- @class Component.stasisAI
--- @field id integer # `= 0` 

--- Toggles stasis depending on movements by `stasisApproacher` entities.
--- @class Component.stasisOnApproach
--- @field minimumDistance number # `= 0` 

--- When this entity moves, updates `stasisOnApproach` entities.
--- @class Component.stasisApproacher

--- Disables stasis on this entity’s first action after being provoked (requires `provokable`).
--- @class Component.stasisUntilProvoked

--- Enables stasis and prevents the move when this entity tries to move while not in stasis.
--- @class Component.stasisOnMove

--- Enables stasis when this entity is tickled (by Dove’s flower).
--- @class Component.stasisOnTickle

--- Protects this entity from damage while it is in stasis.
--- @class Component.stasisShield
--- @field bypassFlags Damage.Flag # `= bit.bnot(damage.Flag.TRAP)` 
--- @field bypassDamage integer # `= -1` 
--- @field damageReduction integer # `= 0` 
--- @field maximumDamageTaken integer # `= 0` 

--- Stops `stasisShield` from taking effect while this entity is frozen.
--- @class Component.stasisShieldBypassWhileFrozen

--- Plays a sound whenever this entity move, based on its stasis state.
--- @class Component.stasisSoundWalk
--- @field on string # `= ""` Sound played when this entity moves while in stasis.
--- @field off string # `= ""` Sound played when this entity moves while not in stasis.

--- Hides this entity’s in-world health bar while it is in stasis.
--- @class Component.stasisHideHealthBar

--- Changes the color of this entity’s pixel on the minimap while it is in stasis.
--- @class Component.stasisMinimapPixel
--- @field color integer # `= 0` 

--- Disables stasis and prevents the attack when this entity tries to attack while in stasis.
--- @class Component.unstasisOnAttack

--- Disables the stasis when this entity fails to move because of a collision.
--- @class Component.unstasisOnCollision

--- @class Entity
--- @field stasis Component.stasis
--- @field stasisAttackableFlags Component.stasisAttackableFlags
--- @field stasisAI Component.stasisAI
--- @field stasisOnApproach Component.stasisOnApproach
--- @field stasisApproacher Component.stasisApproacher
--- @field stasisUntilProvoked Component.stasisUntilProvoked
--- @field stasisOnMove Component.stasisOnMove
--- @field stasisOnTickle Component.stasisOnTickle
--- @field stasisShield Component.stasisShield
--- @field stasisShieldBypassWhileFrozen Component.stasisShieldBypassWhileFrozen
--- @field stasisSoundWalk Component.stasisSoundWalk
--- @field stasisHideHealthBar Component.stasisHideHealthBar
--- @field stasisMinimapPixel Component.stasisMinimapPixel
--- @field unstasisOnAttack Component.unstasisOnAttack
--- @field unstasisOnCollision Component.unstasisOnCollision

return StasisComponents
