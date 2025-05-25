--- @meta

local ApparitionComponents = {}

--- Makes this entity intangible by default, and allows it to become tangible via the `apparitionSpawn` event.
--- @class Component.apparition
--- @field appeared boolean # `= false` Protected field! Do not modify directly.
--- @field deletionRadius number # `= 3` If this entity is forced to appear too close to its target, it is immediately deleted. Inclusive maximum L2 distance.

--- Decides the position where this entity appears relative to its target.
--- @class Component.apparitionSpawnNearTarget
--- @field distance integer # `= 1` 
--- @field flipDistances boolean # `= false` 

--- Forces this entity to appear immediately when revealed.
--- @class Component.apparitionSpawnOnReveal

--- Prevents this entity from appearing if it would cause a collision.
--- Unlike other apparitionXCheck components, this also applies to forced apparitions.
--- @class Component.apparitionSpawnCollisionCheck
--- @field mask Collision.Type # `= collision.Group.SOLID` 

--- Prevents this entity from appearing on an unlit tile.
--- @class Component.apparitionSpawnLightCheck

--- Prevents this entity from appearing in another segment than its target.
--- @class Component.apparitionSpawnSegmentCheck

--- Prevents this entity from appearing if another entity appeared recently.
--- @class Component.apparitionSpawnGlobalCooldown
--- @field cooldownName string # `= ""` 
--- @field turnCount integer # `= 1` 

--- Requires this entity having been close enough to a valid target before it can appear.
--- @class Component.apparitionSpawnProximityCheck
--- @field radius number # `= 0` Inclusive maximum L2 distance from a target to disable this check.
--- @field active boolean # `= true` While true, this entity can’t appear. Set to false when close enough to a target.

--- Prevents this entity from appearing if its target is too close to another hostile entity.
--- @class Component.apparitionSpawnAvoidSwarmedTarget
--- @field radius number # `= 0` Inclusive maximum L2 distance at which an hostile entity is considered too close to the target.

--- Forces apparitions to appear.
--- @class Component.spawnApparitions
--- @field component string # `= ""` 

--- Forces apparitions to appear if this entity is equipped.
--- @class Component.itemSpawnApparitions
--- @field component string # `= ""` 

--- @class Entity
--- @field apparition Component.apparition
--- @field apparitionSpawnNearTarget Component.apparitionSpawnNearTarget
--- @field apparitionSpawnOnReveal Component.apparitionSpawnOnReveal
--- @field apparitionSpawnCollisionCheck Component.apparitionSpawnCollisionCheck
--- @field apparitionSpawnLightCheck Component.apparitionSpawnLightCheck
--- @field apparitionSpawnSegmentCheck Component.apparitionSpawnSegmentCheck
--- @field apparitionSpawnGlobalCooldown Component.apparitionSpawnGlobalCooldown
--- @field apparitionSpawnProximityCheck Component.apparitionSpawnProximityCheck
--- @field apparitionSpawnAvoidSwarmedTarget Component.apparitionSpawnAvoidSwarmedTarget
--- @field spawnApparitions Component.spawnApparitions
--- @field itemSpawnApparitions Component.itemSpawnApparitions

return ApparitionComponents
