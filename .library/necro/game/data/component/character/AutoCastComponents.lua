--- @meta

local AutoCastComponents = {}

--- Makes this entity periodically perform an action if conditions are met.
--- This action is in addition to this entity’s normal action for the turn.
--- This is controlled by the `autoCastProcess` event.
--- @class Component.autoCast
--- @field input integer # `= 0` The action autoCast tries to perform.
--- @field requireAI boolean # `= true` If true, autoCast has no effect while this entity is player-controlled.

--- Overrides the default autoCast action depending on the direction from this entity to its target.
--- @class Component.autoCastDirectionalInput
--- @field inputs table # Maps direction => input

--- Sets a minimum amount of turns between auto-casts.
--- @class Component.autoCastCooldown
--- @field cooldown integer # `= 1` 
--- @field remainingTurns integer # `= 0` 

--- Checks that this entity is revealed before auto-casting.
--- This also prevents autoCastCooldown from ticking down while this entity is not revealed.
--- @class Component.autoCastCheckRevealed

--- Checks that this entity is aligned with its target before auto-casting.
--- @class Component.autoCastActivationLinear
--- @field directions table # Set of allowed alignment directions.
--- @field minDistance integer # `= 0` Inclusive minimum L∞ distance to the target.
--- @field maxDistance integer # `= 100` Inclusive maximum L∞ distance to the target.

--- Checks that the target is within a cone starting from this entity before auto-casting.
--- @class Component.autoCastActivationCone
--- @field directions table # Set of allowed cone directions.
--- @field minDistance number # `= 0` Inclusive minimum L∞ distance to the target.
--- @field maxDistance number # `= 100` Inclusive maximum L∞ distance to the target.

--- Checks that this entity is within line of sight of its target before auto-casting.
--- @class Component.autoCastCheckLineOfSight
--- @field mask Collision.Type # `= collision.Type.WALL` 
--- @field offset integer # `= 1` Directional offset applied to the starting point of the line-of-sight check (similar to spellcastDirectionalOffset).

--- Checks that this entity is unfrozen before auto-casting.
--- @class Component.autoCastCheckTargetUnfrozen
--- @field cooldown integer # `= 0` 

--- Checks that this entity is far enough from its target before autocasting.
--- @class Component.autoCastMinimumTargetDistance
--- @field distance integer # `= 0` Inclusive minimum L2 distance.

--- Applies the autoCast's cooldown values to certain player actions
--- @class Component.autoCastControlledCooldown
--- @field actions table # Set of affected actions.

--- Disables autoCast if this entity’s normal action had a specific result.
--- @class Component.autoCastCheckMoveResult
--- @field result Action.Result # `= action.Result.ATTACK` 

--- Makes a successful autoCast override this entity’s action result.
--- @class Component.autoCastSetMoveResult
--- @field result Action.Result # `= action.Result.SPELL` 

--- @class Entity
--- @field autoCast Component.autoCast
--- @field autoCastDirectionalInput Component.autoCastDirectionalInput
--- @field autoCastCooldown Component.autoCastCooldown
--- @field autoCastCheckRevealed Component.autoCastCheckRevealed
--- @field autoCastActivationLinear Component.autoCastActivationLinear
--- @field autoCastActivationCone Component.autoCastActivationCone
--- @field autoCastCheckLineOfSight Component.autoCastCheckLineOfSight
--- @field autoCastCheckTargetUnfrozen Component.autoCastCheckTargetUnfrozen
--- @field autoCastMinimumTargetDistance Component.autoCastMinimumTargetDistance
--- @field autoCastControlledCooldown Component.autoCastControlledCooldown
--- @field autoCastCheckMoveResult Component.autoCastCheckMoveResult
--- @field autoCastSetMoveResult Component.autoCastSetMoveResult

return AutoCastComponents
