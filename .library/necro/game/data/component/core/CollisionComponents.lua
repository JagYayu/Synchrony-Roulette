--- @meta

local CollisionComponents = {}

--- Determines how other entities collide into this entity.
--- @class Component.collision
--- @field mask Collision.Type # `= collision.Type.ENEMY` Protected field! Do not modify directly, use an `objectUpdateCollision` handler instead.

--- Determines which tiles this entity is allowed to attack.
--- @class Component.collisionCheckOnAttack
--- @field mask Collision.Type # `= collision.Group.WEAPON_CLEARANCE` Computed field. Do not modify directly, use an `objectUpdateCollision` handler instead.

--- Determines which tiles this entity is allowed to move to.
--- @class Component.collisionCheckOnMove
--- @field mask Collision.Type # `= collision.Group.SOLID` Computed field. Do not modify directly, use an `objectUpdateCollision` handler instead.

--- Determines which tiles this entity is allowed to teleport to.
--- @class Component.collisionCheckOnTeleport
--- @field mask integer # `= 0` Computed field. Do not modify directly, use an `objectUpdateCollision` handler instead.

--- Marks this entity as a player for the purposes of the `playerCollisions` setting.
--- @class Component.collisionCheckPlayerSetting
--- @field remove Collision.Type # `= collision.Type.PLAYER` 

--- Deletes this entity after a delay
--- @class Component.disappearOnCollision
--- @field mask Collision.Type # `= collision.Group.SOLID` 
--- @field delay number # `= 0.15` 

--- Modifies the holder’s `collision.mask`.
--- @class Component.itemCollision
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- Modifies the holder’s `collisionCheckOnMove.mask`.
--- @class Component.itemCollisionCheckOnMove
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- Updates the collision mask of the item itself while it is equipped
--- @class Component.itemEquipmentCollision
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- @class Entity
--- @field collision Component.collision
--- @field collisionCheckOnAttack Component.collisionCheckOnAttack
--- @field collisionCheckOnMove Component.collisionCheckOnMove
--- @field collisionCheckOnTeleport Component.collisionCheckOnTeleport
--- @field collisionCheckPlayerSetting Component.collisionCheckPlayerSetting
--- @field disappearOnCollision Component.disappearOnCollision
--- @field itemCollision Component.itemCollision
--- @field itemCollisionCheckOnMove Component.itemCollisionCheckOnMove
--- @field itemEquipmentCollision Component.itemEquipmentCollision

return CollisionComponents
