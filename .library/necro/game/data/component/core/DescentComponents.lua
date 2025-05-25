--- @meta

local DescentComponents = {}

--- Allows this entity to fall through holes in the floor (such as trapdoors).
--- @class Component.descent
--- @field active boolean # `= false` True from the start of the descent animation until this entity arrives to the next level.
--- @field complete boolean # `= false` True from the end of the descent animation until this entity arrives to the next level.
--- @field type integer # `= 0` 

--- Modifies the collision mask while this entity descends.
--- @class Component.descentCollisionMask
--- @field add integer # `= 0` 
--- @field remove Collision.Type # `= collision.Group.SOLID` 
--- @field needUpdate boolean # `= false` 

--- Modifies attackability flags while this entity descends.
--- @class Component.descentAttackableFlags
--- @field add integer # `= 0` 
--- @field remove Attack.Flag # `= attack.Flag.ALL` 
--- @field active boolean # `= false` This is distinct from `descent.active` because only some descent types (stairs) modify attackability.

--- Prevents this entity from moving while descending.
--- @class Component.descentLockMovement

--- Makes this entity invincible to all damage types while descending, but only once per level.
--- @class Component.descentDamageImmunity
--- @field active boolean # `= false` 
--- @field available boolean # `= true` 

--- Allows this entity to exit to the next level by stepping on an exit tile.
--- @class Component.descentActivateOnTile

--- Allows this entity to exit to the next level upon descending.
--- @class Component.descentExitLevel

--- Creates a screen overlay when the focused entity descends.
--- @class Component.descentOverlay

--- @class Component.descentDurationOverride
--- @field duration number # `= 0` 

--- Makes this entity intangible after completing its descent.
--- @class Component.descentIntangibleOnCompletion

--- Makes this entity as a spectator after completing its descent.
--- @class Component.descentSpectateOnCompletion

--- Despawns this entity after completing its descent.
--- @class Component.descentDeleteOnCompletion

--- Allows this entity to return to the level after descending if the level transition requirement is not yet met.
--- @class Component.descentAllowAscent
--- @field collisionMask Collision.Type # `= collision.Group.PLAYER_PLACEMENT` 
--- @field moveType Move.Flag # `= move.Type.UNCHECKED` 
--- @field active boolean # `= false` 

--- Makes this entity appear on the next level after descending.
--- @class Component.descentPersistToNextLevel

--- Applies a positional offset to the descending entity upon arriving at the next level.
--- @class Component.descentPositionOffset
--- @field offsetX integer # `= 0` 
--- @field offsetY integer # `= 0` 
--- @field collisionMask Collision.Type # `= collision.Group.SOLID` 

--- Inflicts damage upon a descending entity arriving at the next level.
--- @class Component.descentDamage
--- @field damage integer # `= 0` 
--- @field type integer # `= 0` 

--- Prevents locked stairs from being unlocked.
--- @class Component.stairLocker
--- @field level LevelExit.StairLock # `= levelExit.StairLock.MINIBOSS` 

--- Allows this entity to ignore some or all `stairLocker` entities when unlocking stairs.
--- @class Component.bypassStairLock
--- @field level LevelExit.StairLock # `= levelExit.StairLock.MINIBOSS` 

--- Causes this entity to create an ambush fight on the next floor
--- @class Component.ambusher
--- @field pending boolean # `= true` If true, this entity will be part of an ambush on the next floor if the players escape this floor with a trapdoor.
--- @field active boolean # `= false` If true, this entity is part of an ambush on the current floor. Killing this entity is required to open the ambush walls.

--- Creates a box containing enemies and the previous level's ambushers upon arrival.
--- @class Component.descentAmbush

--- Collects all gold in the level when this entity takes the stairs.
--- @class Component.descentCollectCurrency
--- @field currencyType string # `= currency.Type.GOLD` 

--- Descend all items on this entity’s tile every turn
--- @class Component.descendItems

--- @class Entity
--- @field descent Component.descent
--- @field descentCollisionMask Component.descentCollisionMask
--- @field descentAttackableFlags Component.descentAttackableFlags
--- @field descentLockMovement Component.descentLockMovement
--- @field descentDamageImmunity Component.descentDamageImmunity
--- @field descentActivateOnTile Component.descentActivateOnTile
--- @field descentExitLevel Component.descentExitLevel
--- @field descentOverlay Component.descentOverlay
--- @field descentDurationOverride Component.descentDurationOverride
--- @field descentIntangibleOnCompletion Component.descentIntangibleOnCompletion
--- @field descentSpectateOnCompletion Component.descentSpectateOnCompletion
--- @field descentDeleteOnCompletion Component.descentDeleteOnCompletion
--- @field descentAllowAscent Component.descentAllowAscent
--- @field descentPersistToNextLevel Component.descentPersistToNextLevel
--- @field descentPositionOffset Component.descentPositionOffset
--- @field descentDamage Component.descentDamage
--- @field stairLocker Component.stairLocker
--- @field bypassStairLock Component.bypassStairLock
--- @field ambusher Component.ambusher
--- @field descentAmbush Component.descentAmbush
--- @field descentCollectCurrency Component.descentCollectCurrency
--- @field descendItems Component.descendItems

return DescentComponents
