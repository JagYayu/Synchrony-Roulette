--- @meta

local SpawnComponents = {}

--- Keeps track of this entity’s caster (the entity responsible for spawning it).
--- @class Component.spawnable
--- @field caster Entity.ID # 

--- Makes this entity count against its caster’s `spawnCap`.
--- @class Component.spawnableCountInCap
--- @field caster Entity.ID # Protected field! Do not modify directly, use `Spawn.setSpawnCapParent` instead.

--- Allows spawning another entity type instead of this one under certain circumstances.
--- @class Component.enemySubstitutions
--- @field types table # Keys are `EnemySubstitution.Type` enum values. Values are either an entity type, or a list of entity types (in which case one of them is picked at random).

--- Causes damage dealt by this entity to count as having been dealt by its caster.
--- @class Component.spawnableForwardDamageCredit
--- @field active boolean # `= true` 

--- Causes kills made by this entity to count as having been made by its caster.
--- @class Component.spawnableForwardKillCredit
--- @field active boolean # `= true` 

--- Updates `spawnable.caster` on possession and unpossession.
--- @class Component.spawnableFollowOwnershipChanges

--- Prevents this entity from spawning more than a given number of entities at once.
--- @class Component.spawnCap
--- @field counter integer # `= 0` 

--- Delays this entity when its spawnCap is reached.
--- @class Component.spawnCapBeatDelay
--- @field delay integer # `= 0` 

--- Spawns something when this entity performs a directional action (instead of moving).
--- @class Component.spawnOnDirection
--- @field attributes table # 
--- @field collisionMask Collision.Type # `= collision.Group.SOLID` 
--- @field sound string # `= ""` 
--- @field goldAmounts table # 
--- @field removeKillCredit Kill.Credit, kill.Credit.mask(kill.Credit.CURRENCY # `= kill.Credit.SOUL)` 
--- @field spawnCount integer # `= 0` 

--- Disables the common enemy substitutions for enemies spawned by this entity.
--- @class Component.spawnOnDirectionBypassEnemySubstitutions

--- Specific to training sarcophagi.
--- @class Component.spawnOnDirectionCastSpell
--- @field mapping table # Maps spawned entity type => spell.

--- Spawns something when this entity is aligned with its target.
--- (This isn’t related to `charge`, it just triggers in similar conditions).
--- @class Component.spawnOnCharge
--- @field type string # `= ""` 
--- @field sound string # `= ""` 
--- @field attributes table # 
--- @field maxDistance integer # `= 100` 
--- @field singleTarget boolean # `= false` 

--- Spawns something when this entity takes damage.
--- @class Component.spawnOnHit
--- @field type string # `= ""` 
--- @field bypassFlags integer # `= 0` When damage matching these flags triggers the spawn, immediately deal the same damage to the spawned entities.

--- Spawns something when this entity dies.
--- @class Component.spawnOnDeath
--- @field type string # `= ""` 

--- Specific to the Mommy.
--- @class Component.spawnPrep
--- @field active boolean # `= false` 
--- @field sound string # `= ""` 

--- Kills this entity when its caster dies.
--- @class Component.spawnableDieWithCaster

--- Updates this entity’s tangibility to match its caster’s tangibility.
--- @class Component.spawnableInheritCasterTangibility

--- Requires this entity to be in the same segment as its caster to be tangible.
--- @class Component.spawnableCasterSegmentTangibility

--- @class Entity
--- @field spawnable Component.spawnable
--- @field spawnableCountInCap Component.spawnableCountInCap
--- @field enemySubstitutions Component.enemySubstitutions
--- @field spawnableForwardDamageCredit Component.spawnableForwardDamageCredit
--- @field spawnableForwardKillCredit Component.spawnableForwardKillCredit
--- @field spawnableFollowOwnershipChanges Component.spawnableFollowOwnershipChanges
--- @field spawnCap Component.spawnCap
--- @field spawnCapBeatDelay Component.spawnCapBeatDelay
--- @field spawnOnDirection Component.spawnOnDirection
--- @field spawnOnDirectionBypassEnemySubstitutions Component.spawnOnDirectionBypassEnemySubstitutions
--- @field spawnOnDirectionCastSpell Component.spawnOnDirectionCastSpell
--- @field spawnOnCharge Component.spawnOnCharge
--- @field spawnOnHit Component.spawnOnHit
--- @field spawnOnDeath Component.spawnOnDeath
--- @field spawnPrep Component.spawnPrep
--- @field spawnableDieWithCaster Component.spawnableDieWithCaster
--- @field spawnableInheritCasterTangibility Component.spawnableInheritCasterTangibility
--- @field spawnableCasterSegmentTangibility Component.spawnableCasterSegmentTangibility

return SpawnComponents
