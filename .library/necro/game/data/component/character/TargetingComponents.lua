--- @meta

local TargetingComponents = {}

--- Allows this entity to be targeted by other entities.
--- @class Component.targetable
--- @field active boolean # `= false` Protected field! Do not modify directly, use `Targeting.updateTargetability()` instead.

--- Makes this entity non-targetable by default. If this component is absent, the entity is non-targetable unless
--- another component explicitly enables targetability.
--- @class Component.targetableOffByDefault

--- Prevents teleports from selecting tiles too close to this entity in co-op mode
--- @class Component.targetableExclusionZone
--- @field squareDistance integer # `= 1` 

--- Allows this entity to target other entities. This is required for AI-controlled entities.
--- @class Component.target
--- @field entity Entity.ID # 
--- @field bias Entity.ID # 
--- @field ignoreSegments boolean # `= false` 

--- Makes this entity target its caster.
--- @class Component.targetCaster

--- Bias this entity’s targeting to slightly favor the last entity that attacked it.
--- @class Component.targetAttacker

--- Makes this entity target the nearest player.
--- @class Component.targetNearestPlayer

--- Makes this entity target the nearest hostile entity.
--- @class Component.targetNearestHostileEntity

--- @class Entity
--- @field targetable Component.targetable
--- @field targetableOffByDefault Component.targetableOffByDefault
--- @field targetableExclusionZone Component.targetableExclusionZone
--- @field target Component.target
--- @field targetCaster Component.targetCaster
--- @field targetAttacker Component.targetAttacker
--- @field targetNearestPlayer Component.targetNearestPlayer
--- @field targetNearestHostileEntity Component.targetNearestHostileEntity

return TargetingComponents
