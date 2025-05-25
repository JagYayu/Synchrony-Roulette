--- @meta

local CastComponents = {}

--- Casts a spell when this item is activated.
--- @class Component.itemCastOnUse
--- @field spell string # `= ""` 
--- @field direction integer # `= 0` 

--- Casts a spell when this entity gets certain action results.
--- @class Component.castOnMoveResult
--- @field results table # Set of action results.
--- @field spell string # `= ""` 

--- Casts a spell when this entity gets certain action results.
--- @class Component.castOnAttackResult
--- @field results table # Set of action results.
--- @field spell string # `= ""` 

--- Casts a spell after a given number of beats.
--- @class Component.castOnBeatCounter
--- @field spell string # `= ""` 
--- @field beat integer # `= 1` 

--- Casts a spell whenever this entity moves.
--- @class Component.castOnMove
--- @field requiredMoveFlags integer # `= 0` 
--- @field spell string # `= ""` 

--- Casts a spell when this entity spawns.
--- @class Component.castOnSpawn
--- @field spell string # `= ""` 

--- Casts a spell when this entity dies.
--- @class Component.castOnDeath
--- @field spell string # `= ""` 
--- @field bypassFlags integer # `= 0` Skip casting the spell when killed by damage with one of those flags.

--- Casts a spell when this entity does its innate attack.
--- @class Component.castOnAttack
--- @field spell string # `= ""` 
--- @field castOnAttackerPosition boolean # `= false` If false, uses the victim’s position.

--- Casts a spell when this entity enters stasis.
--- @class Component.castOnStasis
--- @field spell string # `= ""` 

--- Casts a spell when this entity grabs another entity.
--- @class Component.castOnGrab
--- @field spell string # `= ""` 

--- Casts a spell when this entity is tickled.
--- @class Component.castOnTickle
--- @field spell string # `= ""` 

--- Casts a spell when the holder attacks with this weapon.
--- @class Component.weaponCastOnAttack
--- @field spell string # `= ""` 

--- Casts a spell when the holder attacks with any weapon.
--- @class Component.itemCastOnAttack
--- @field spell string # `= ""` 

--- Casts a spell when this entity takes damage.
--- @class Component.castOnHit
--- @field bypassFlags Damage.Flag # `= damage.Flag.SELF_DAMAGE` 
--- @field spell string # `= ""` 
--- @field castOnAttackerPosition boolean # `= false` If false, uses this entity’s position.
--- @field rotation Action.Rotation # `= action.Rotation.IDENTITY` 

--- Casts a spell when this entity shields damage.
--- @class Component.castOnShieldHit
--- @field spell string # `= ""` 
--- @field castOnAttackerPosition boolean # `= false` If false, uses this entity’s position.
--- @field rotation Action.Rotation # `= action.Rotation.IDENTITY` 

--- Casts a spell when this entity is about to die from damage.
--- If casting that spell heals this entity, this will prevent the death.
--- @class Component.castOnLethalHit
--- @field spell string # `= ""` 
--- @field castOnAttackerPosition boolean # `= false` If false, uses this entity’s position.
--- @field rotation Action.Rotation # `= action.Rotation.IDENTITY` 

--- Casts a spell when this entity takes damage, with a delay.
--- @class Component.castOnHitDeferred
--- @field spell string # `= ""` 
--- @field castOnAttackerPosition boolean # `= false` 
--- @field rotation Action.Rotation # `= action.Rotation.IDENTITY` 

--- Specific to goolems.
--- @class Component.goolemCastOnHit
--- @field spell string # `= ""` 
--- @field active boolean # `= true` 

--- Casts a spell upon provocation.
--- @class Component.castOnProvoke
--- @field spell string # `= ""` 
--- @field castOnAttackerPosition boolean # `= false` 
--- @field rotation Action.Rotation # `= action.Rotation.IDENTITY` 

--- Casts a spell when another entity moves into this entity.
--- @class Component.castOnCollision
--- @field spell string # `= ""` 
--- @field attackFlags Attack.Flag # `= attack.Flag.DEFAULT` 

--- Specific to wind gargoyles.
--- @class Component.castOnNearbyActiveHostiles
--- @field spell string # `= ""` 
--- @field attackFlags Attack.Flag # `= attack.Flag.CHARACTER` 

--- Casts a spell after a number of beats, depending on whether this entity’s tile is occupied.
--- @class Component.castWithDelay
--- @field spell string # `= ""` 
--- @field remainingTurns integer # `= 0` 
--- @field vacantCooldown integer # `= -1` -1 (default) means ignore this condition entirely. 0 means don’t cast while the tile is vacant, but don’t go on cooldown either. > 0 means don’t cast for that many beats after the tile has been vacant.
--- @field occupiedCooldown integer # `= -1` -1 (default) means ignore this condition entirely. 0 means don’t cast while the tile is occupied, but don’t go on cooldown either. > 0 means don’t cast for that many beats after the tile has been occupied.
--- @field frameCheck boolean # `= true` 

--- Specific to earth dragons.
--- @class Component.spawnWallsOnHit
--- @field spell string # `= ""` 
--- @field active boolean # `= true` 

--- @class Entity
--- @field itemCastOnUse Component.itemCastOnUse
--- @field castOnMoveResult Component.castOnMoveResult
--- @field castOnAttackResult Component.castOnAttackResult
--- @field castOnBeatCounter Component.castOnBeatCounter
--- @field castOnMove Component.castOnMove
--- @field castOnSpawn Component.castOnSpawn
--- @field castOnDeath Component.castOnDeath
--- @field castOnAttack Component.castOnAttack
--- @field castOnStasis Component.castOnStasis
--- @field castOnGrab Component.castOnGrab
--- @field castOnTickle Component.castOnTickle
--- @field weaponCastOnAttack Component.weaponCastOnAttack
--- @field itemCastOnAttack Component.itemCastOnAttack
--- @field castOnHit Component.castOnHit
--- @field castOnShieldHit Component.castOnShieldHit
--- @field castOnLethalHit Component.castOnLethalHit
--- @field castOnHitDeferred Component.castOnHitDeferred
--- @field goolemCastOnHit Component.goolemCastOnHit
--- @field castOnProvoke Component.castOnProvoke
--- @field castOnCollision Component.castOnCollision
--- @field castOnNearbyActiveHostiles Component.castOnNearbyActiveHostiles
--- @field castWithDelay Component.castWithDelay
--- @field spawnWallsOnHit Component.spawnWallsOnHit

return CastComponents
