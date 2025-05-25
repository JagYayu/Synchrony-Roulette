--- @meta

local FollowerComponents = {}

--- Adds a follower of the given type to this entity on spawn.
--- @class Component.characterWithFollower
--- @field followerType string # `= ""` 
--- @field followerID Entity.ID # 

--- Makes this entity a follower: whenever its parent moves, this entity moves to follow.
--- @class Component.follower
--- @field usePrevPos boolean # `= false` 
--- @field dx integer # `= 0` 
--- @field dy integer # `= 0` 

--- Deletes this entity when its parent deploys another follower to the same relative coordinates.
--- @class Component.followerReplaceable

--- Forwards any gold this entity moves onto to its parent.
--- @class Component.followerCollectGold
--- @field minQuantityForHeal integer # `= 25` 

--- Prevents this entity from taking damage while on the same tile as any `characterProtectFollower` entity.
--- @class Component.followerProtectedByParent

--- Protects `followerProtectedByParent` entities on the same tile as this one.
--- @class Component.characterProtectFollower

--- While this entity is dead, deals damage to its parent every beat.
--- @class Component.followerDamageParentWhileDead
--- @field damageRatio number # `= 0.2` 
--- @field type Damage.Flag # `= damage.Type.SUICIDE` 
--- @field sounds table # 
--- @field killerName localizedString # `= 0` 
--- @field stage integer # `= 0` 

--- Always sets the follower’s color equal to its parent’s color.
--- @class Component.followerCopyColorFromParent

--- Plays an animation when this entity’s parent descends or ascends.
--- @class Component.followerDescent

--- @class Entity
--- @field characterWithFollower Component.characterWithFollower
--- @field follower Component.follower
--- @field followerReplaceable Component.followerReplaceable
--- @field followerCollectGold Component.followerCollectGold
--- @field followerProtectedByParent Component.followerProtectedByParent
--- @field characterProtectFollower Component.characterProtectFollower
--- @field followerDamageParentWhileDead Component.followerDamageParentWhileDead
--- @field followerCopyColorFromParent Component.followerCopyColorFromParent
--- @field followerDescent Component.followerDescent

return FollowerComponents
