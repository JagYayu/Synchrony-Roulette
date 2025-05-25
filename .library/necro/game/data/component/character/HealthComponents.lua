--- @meta

local HealthComponents = {}

--- @class Component.health
--- @field health integer # `= 1` 
--- @field maxHealth integer # `= 1` 

--- @class Component.cursedHealth
--- @field health integer # `= 0` 

--- Prevents this entity from spawning with health higher than its max health.
--- @class Component.healthEnforceMaxOnSpawn

--- Gives this entity extra health against a specific player.
--- @class Component.healthBonusAgainstPlayer
--- @field name string # `= ""` 
--- @field increase integer # `= 1` 

--- Gives this entity extra health depending on the current depth.
--- @class Component.scalingHealth

--- @class Component.cursedHealthUncurseOnHeal
--- @field roundingFactor integer # `= 1` 
--- @field roundDownThreshold integer # `= 0` 

--- Enforces a maximum maxHealth.
--- @class Component.healthLimit
--- @field limit integer # `= 0` 

--- @class Component.maxHealthRounding
--- @field roundingFactor integer # `= 1` 
--- @field roundDownThreshold integer # `= 0` 

--- Converts this entity to a different type based on its remaining health after taking damage.
--- @class Component.lowHealthConvert
--- @field targetTypes table # Maps remaining health => type to convert into.

--- Status effect. While invincible, this entity cannot be damaged.
--- @class Component.invincibility
--- @field remainingTurns integer # `= 0` 
--- @field permanent boolean # `= false` 

--- Makes this entity immune to damage for a brief time after it spawns.
--- @class Component.spawnInvincibility
--- @field active boolean # `= true` 

--- Makes this entity immune to damage while it is pending deletion.
--- @class Component.despawnedInvincibility

--- Makes this entity immune to a given damage type.
--- @class Component.damageTypeImmunity
--- @field requiredFlags integer # `= 0` 

--- Makes this entity immune to damage while in a safe level (see `CurrentLevel.isSafe`).
--- @class Component.lobbyImmunity

--- Grants this entity temporary invincibility when it takes damage ("iframes").
--- @class Component.invincibilityOnHit
--- @field turns integer # `= 2` 

--- Grants this entity temporary invincibility at the start of each floor.
--- @class Component.invincibilityOnLevelStart
--- @field turns integer # `= 2` 

--- Stores the kill count used by effects that heal this entity after a number of kills.
--- Kills only count for this if they give REGENERATION credit (see `Kill.Credit`).
--- @class Component.regenerationKillCounter
--- @field killThreshold integer # `= 10` 
--- @field healthGain integer # `= 1` 
--- @field killCount integer # `= 0` 
--- @field totalIncrement integer # `= 0` 

--- Heals this entity after some number of kills.
--- @class Component.incrementRegenerationKillCounter
--- @field increment integer # `= 1` 

--- Specific to the super-secret shopkeeper.
--- @class Component.healOnFrame
--- @field health integer # `= 20` 

--- Auto-stash heart containers picked up by this entity.
--- @class Component.healthStashContainers

--- Makes this entity immune to a given damage type while it is not revealed.
--- @class Component.unrevealedDamageImmunity
--- @field requiredFlags Damage.Flag # `= damage.Flag.EXPLOSIVE` 

--- Makes damage dealt by this entity bypass the victim’s `unrevealedDamageImmunity`.
--- @class Component.bypassUnrevealedDamageImmunity

--- Conditionally increases damage this entity takes.
--- @class Component.damageTypeVulnerability
--- @field requiredFlags integer # `= 0` 
--- @field minimumDamageTaken integer # `= 1` 

--- Kills this entity when damage brings its health to 0 or less.
--- @class Component.killable
--- @field dead boolean # `= false` 

--- Prevents this entity from being deleted when it is killed.
--- This makes it possible for this entity to respawn later.
--- @class Component.respawn
--- @field pending boolean # `= false` 

--- Tries to respawn this entity as decided by the "Respawn players" setting.
--- @class Component.respawnAutomatically

--- Respawns this entity at the start of each floor.
--- @class Component.respawnOnLevelTransition

--- @class Entity
--- @field health Component.health
--- @field cursedHealth Component.cursedHealth
--- @field healthEnforceMaxOnSpawn Component.healthEnforceMaxOnSpawn
--- @field healthBonusAgainstPlayer Component.healthBonusAgainstPlayer
--- @field scalingHealth Component.scalingHealth
--- @field cursedHealthUncurseOnHeal Component.cursedHealthUncurseOnHeal
--- @field healthLimit Component.healthLimit
--- @field maxHealthRounding Component.maxHealthRounding
--- @field lowHealthConvert Component.lowHealthConvert
--- @field invincibility Component.invincibility
--- @field spawnInvincibility Component.spawnInvincibility
--- @field despawnedInvincibility Component.despawnedInvincibility
--- @field damageTypeImmunity Component.damageTypeImmunity
--- @field lobbyImmunity Component.lobbyImmunity
--- @field invincibilityOnHit Component.invincibilityOnHit
--- @field invincibilityOnLevelStart Component.invincibilityOnLevelStart
--- @field regenerationKillCounter Component.regenerationKillCounter
--- @field incrementRegenerationKillCounter Component.incrementRegenerationKillCounter
--- @field healOnFrame Component.healOnFrame
--- @field healthStashContainers Component.healthStashContainers
--- @field unrevealedDamageImmunity Component.unrevealedDamageImmunity
--- @field bypassUnrevealedDamageImmunity Component.bypassUnrevealedDamageImmunity
--- @field damageTypeVulnerability Component.damageTypeVulnerability
--- @field killable Component.killable
--- @field respawn Component.respawn
--- @field respawnAutomatically Component.respawnAutomatically
--- @field respawnOnLevelTransition Component.respawnOnLevelTransition

return HealthComponents
