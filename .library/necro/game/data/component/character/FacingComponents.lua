--- @meta

local FacingComponents = {}

--- Tracks this entity’s facing direction for gameplay purposes.
--- @class Component.facingDirection
--- @field direction integer # `= 0` 

--- Sets this entity’s facing at random when it spawns.
--- @class Component.randomInitialFacingDirection
--- @field directions table # List of possible initial directions. One of them is picked at random.

--- Updates this entity’s facing when it moves.
--- @class Component.setFacingOnMove

--- Updates this entity’s facing when it performs a directional action.
--- @class Component.setFacingOnDirection
--- @field cancelConfusion boolean # `= false` If true, confusion doesn’t affect this entity’s facing.

--- Updates this entity’s facing when it flees from its target (AI-controlled only).
--- @class Component.setFacingOnFlee

--- Sets this entity’s facing to match the next move in its `aiPattern`.
--- @class Component.setFacingFromPattern

--- Rotates this entity’s facing when it fails a move.
--- @class Component.turnOnMoveFail
--- @field rotation integer # `= 0` 

--- Rotates this entity’s facing every beat.
--- @class Component.facingAutoRotate
--- @field rotation integer # `= 0` 

--- Updates this entity’s visual facing every beat.
--- @class Component.facingFollowTarget

--- Updates this entity’s visual facing when it idles while AI-controlled.
--- @class Component.facingFollowTargetOnIdle

--- Updates this entity’s sprite’s horizontal mirroring based on its facing.
--- @class Component.facingMirrorX
--- @field directions table # Maps direction => mirrorX.

--- Updates this entity’s sprite’s vertical mirroring based on its facing.
--- @class Component.facingMirrorY
--- @field directions table # Maps direction => mirrorY.

--- Changes this entity’s animation frame based on its facing.
--- @class Component.facingFrameY
--- @field directions table # Maps direction => frameY

--- Prevents this entity from moving during a directional action that caused its facing to change.
--- @class Component.inhibitOnFacingChange

--- @class Entity
--- @field facingDirection Component.facingDirection
--- @field randomInitialFacingDirection Component.randomInitialFacingDirection
--- @field setFacingOnMove Component.setFacingOnMove
--- @field setFacingOnDirection Component.setFacingOnDirection
--- @field setFacingOnFlee Component.setFacingOnFlee
--- @field setFacingFromPattern Component.setFacingFromPattern
--- @field turnOnMoveFail Component.turnOnMoveFail
--- @field facingAutoRotate Component.facingAutoRotate
--- @field facingFollowTarget Component.facingFollowTarget
--- @field facingFollowTargetOnIdle Component.facingFollowTargetOnIdle
--- @field facingMirrorX Component.facingMirrorX
--- @field facingMirrorY Component.facingMirrorY
--- @field facingFrameY Component.facingFrameY
--- @field inhibitOnFacingChange Component.inhibitOnFacingChange

return FacingComponents
