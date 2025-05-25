--- @meta

local UnusedEnemyComponents = {}

--- @class Component.doppelganger
--- @field interval integer # `= 7` 
--- @field counter integer # `= 0` 
--- @field puppet Entity.ID # 
--- @field types table # 

--- @class Component.spawnMultipleOnDeath
--- @field type string # `= ""` 
--- @field offsets table # 

--- @class Component.convertOnWeaponAttack
--- @field type string # `= ""` 

--- @class Component.chargeLimitedDuration
--- @field maxDuration integer # `= 1` 
--- @field counter integer # `= 0` 

--- @class Component.chargeEndBeatDelay
--- @field delay integer # `= 0` 

--- @class Component.chargeEndHeal
--- @field health integer # `= 0` 

--- @class Component.despawnCountdownBlinkEffect

--- @class Entity
--- @field doppelganger Component.doppelganger
--- @field spawnMultipleOnDeath Component.spawnMultipleOnDeath
--- @field convertOnWeaponAttack Component.convertOnWeaponAttack
--- @field chargeLimitedDuration Component.chargeLimitedDuration
--- @field chargeEndBeatDelay Component.chargeEndBeatDelay
--- @field chargeEndHeal Component.chargeEndHeal
--- @field despawnCountdownBlinkEffect Component.despawnCountdownBlinkEffect

return UnusedEnemyComponents
