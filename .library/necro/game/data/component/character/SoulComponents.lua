--- @meta

local SoulComponents = {}

--- Allows this entity to be followed by souls.
--- @class Component.soulLeader
--- @field souls table # 
--- @field stacked boolean # `= false` 
--- @field moveTurnID integer # `= -1` 

--- Copies the horizontal mirroring of this entity to all souls following it.
--- @class Component.soulLeaderSpriteMirrorX
--- @field mirrorX integer # `= 1` 
--- @field leftFacing boolean # `= false` 

--- Causes all souls following this entity to be animated.
--- (This performs better than giving `normalAnimation` to each soul).
--- @class Component.soulLeaderAnimation
--- @field frames table # 
--- @field variantCount integer # `= 1` 
--- @field variantOffsetX integer # `= 4` 

--- Creates a soul following this entity whenever it gets SOUL credit for a kill (see `Kill.Credit`).
--- @class Component.spawnSoulOnKill
--- @field soulType string # `= ""` 

--- Makes this entity a soul, which follows its leader’s moves.
--- @class Component.soulFollower

--- Deletes any soul that moves into this entity.
--- @class Component.soulDeleter

--- Deletes this entity when it moves into a `soulDeleter` entity, or into its leader.
--- @class Component.soulDeleteOnCollision

--- Deletes this entity when it tries to deal damage to a boss room enemy before starting the boss fight.
--- @class Component.soulDeleteOnPreBossAttack

--- @class Entity
--- @field soulLeader Component.soulLeader
--- @field soulLeaderSpriteMirrorX Component.soulLeaderSpriteMirrorX
--- @field soulLeaderAnimation Component.soulLeaderAnimation
--- @field spawnSoulOnKill Component.spawnSoulOnKill
--- @field soulFollower Component.soulFollower
--- @field soulDeleter Component.soulDeleter
--- @field soulDeleteOnCollision Component.soulDeleteOnCollision
--- @field soulDeleteOnPreBossAttack Component.soulDeleteOnPreBossAttack

return SoulComponents
