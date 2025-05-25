--- @meta

local WeaponComponents = {}

--- Common component for weapon items
--- @class Component.weapon
--- @field damage integer # `= 1` Base amount of damage dealt by this weapon (can be modified by weapon patterns).
--- @field damageType Damage.Flag # `= damage.Type.PHYSICAL` Base damage type dealt by this weapon (can be modified by weapon patterns).

--- Allows this entity to attack using itself as a weapon
--- @class Component.innateWeapon

--- Defines the pattern used when attacking with this weapon normally.
--- @class Component.weaponPattern
--- @field pattern table # 

--- Allows this weapon to be thrown, and defines the pattern used when throwing it.
--- @class Component.weaponThrowable
--- @field pattern table # 
--- @field maxDistance integer # `= 100` 

--- Consumes this weapon when it is thrown.
--- @class Component.weaponConsumeOnThrow

--- Allows this weapon to be reloaded, and defines the pattern used when attacking while it is loaded.
--- @class Component.weaponReloadable
--- @field pattern table # 
--- @field maximumAmmo integer # `= 1` 
--- @field ammoPerReload integer # `= 1` 
--- @field ammo integer # `= 0` 
--- @field slotImage string # `= "ext/gui/hud_slot_reload.png"` 
--- @field slotLabel string # `= "Reload!"` 

--- Knockbacks entities hit by this weapon.
--- @class Component.weaponKnockback
--- @field distance integer # `= 1` 

--- Specific to the Shovemonster’s Piston.
--- @class Component.weaponShove

--- Flashes the holder’s screen when attacking with this weapon.
--- @class Component.weaponScreenFlash

--- Causes the holder to parry incoming attacks after performing an attack with this weapon
--- @class Component.weaponParryOnAttack
--- @field active boolean # `= false` 

--- Overrides the beat delay of entities hit by this weapon
--- @class Component.weaponOverrideBeatDelay
--- @field delay integer # `= 0` 

--- Inflicts confusion to any entities hit by this weapon
--- @class Component.weaponInflictConfusion
--- @field duration integer # `= 0` 

--- Attacks with this weapon use the ranged voice line
--- @class Component.weaponRanged

--- Entities hit by this weapon will be "tickled", dropping their gold and counting as a "kill" for the attacker
--- @class Component.weaponTickle

--- Prevents this weapon from dealing any form of damage
--- @class Component.weaponNoDamage

--- Prevents attacking from inside walls
--- @class Component.weaponCheckOriginCollision
--- @field mask Collision.Type # `= collision.Type.WALL` 

--- Contains the primary material name (used for swipes)
--- @class Component.weaponMaterial
--- @field name string # `= ""` 
--- @field component string # `= ""` 

--- Contains the weapon pattern type
--- @class Component.weaponType
--- @field name string # `= ""` 
--- @field component string # `= ""` 

--- @class Entity
--- @field weapon Component.weapon
--- @field innateWeapon Component.innateWeapon
--- @field weaponPattern Component.weaponPattern
--- @field weaponThrowable Component.weaponThrowable
--- @field weaponConsumeOnThrow Component.weaponConsumeOnThrow
--- @field weaponReloadable Component.weaponReloadable
--- @field weaponKnockback Component.weaponKnockback
--- @field weaponShove Component.weaponShove
--- @field weaponScreenFlash Component.weaponScreenFlash
--- @field weaponParryOnAttack Component.weaponParryOnAttack
--- @field weaponOverrideBeatDelay Component.weaponOverrideBeatDelay
--- @field weaponInflictConfusion Component.weaponInflictConfusion
--- @field weaponRanged Component.weaponRanged
--- @field weaponTickle Component.weaponTickle
--- @field weaponNoDamage Component.weaponNoDamage
--- @field weaponCheckOriginCollision Component.weaponCheckOriginCollision
--- @field weaponMaterial Component.weaponMaterial
--- @field weaponType Component.weaponType

return WeaponComponents
