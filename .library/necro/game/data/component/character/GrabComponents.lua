--- @meta

local GrabComponents = {}

--- Lets this entity be grabbed by grabbers.
--- @class Component.grabbable
--- @field grabber Entity.ID # 
--- @field isGrabbed boolean # `= false` This is similar to `grabbable.grabber == 0`, but not directly equivalent: it stays true for a brief moment after the grabber dies, which is needed to make grabbed explosion immunity work even if the explosion kills the grabber first.

--- Makes this entity grab its enemies instead of attacking them.
--- @class Component.grab
--- @field target Entity.ID # 

--- Modifies this entity’s collision while it is grabbing something.
--- @class Component.grabCollision
--- @field add integer # `= 0` 
--- @field remove Collision.Type # `= collision.Type.CHARACTER` 

--- Modifies this entity’s attackability while it is grabbing something.
--- @class Component.grabAttackability
--- @field add integer # `= 0` 
--- @field remove Attack.Flag # `= attack.Flag.TRAP` 

--- Modifies this entity z-order while it is grabbing something.
--- @class Component.grabRowOrder
--- @field offsetZ number # `= 10` The grabber will appear above the victim if this is > 0, below if < 0.
--- @field z number # `= 0` 

--- On grab, moves this entity to the position of its grab target.
--- @class Component.grabMoveOntoVictim

--- When this entity moves, moves its grab target to the same destination.
--- @class Component.grabDragVictim

--- Actually grabs the victim. If this entity has `grab` but not `grabAttachToVictim`, it’s
--- never considered to be "grabbing something", and its victim is never considered "grabbed".
--- (This lets non-grabber entities reuse some functionality from the grabbing system).
--- @class Component.grabAttachToVictim

--- Overrides this entity’s AI while it is grabbing something.
--- @class Component.grabAI
--- @field type Ai.Type # `= ai.Type.IDLE` 

--- Prevents this entity from being forced moved while it is grabbing something.
--- @class Component.grabKnockbackImmunity
--- @field requiredFlags Move.Flag # `= move.Flag.FORCED_MOVE` 

--- When this entity is damaged via `grabTakeDamageFromVictim`, plays a hop animation.
--- @class Component.grabHopInPlaceOnHit

--- Increases this entity’s health when it grabs.
--- @class Component.grabIncreaseHealth
--- @field multiplier integer # `= 1` 
--- @field max integer # `= 20` 

--- Inflicts damage to this entity when its grab target tries to move.
--- @class Component.grabTakeDamageFromVictim
--- @field minimum integer # `= 1` 
--- @field requeuePrevention integer # `= 0` For internal use.

--- When this entity is damaged via `grabTakeDamageFromVictim`, makes the damage directional.
--- @class Component.grabTakeDirectionalDamageFromVictim

--- Partially protects this entity from its grab target.
--- By default, golden lute damage is blocked, to avoid double-hits.
--- @class Component.grabShieldFromVictim
--- @field requiredFlags Damage.Flag # `= damage.Flag.GOLDEN_LUTE` 

--- On grab, spawn a new attachment attached to the grabber.
--- @class Component.grabAttachment
--- @field name string # `= ""` 
--- @field id Entity.ID # 

--- On grab, drop the groove
--- @class Component.grabDropGrooveChain
--- @field type GrooveChain.Type # `= grooveChain.Type.TRAPDOOR` 

--- Causes this entity’s grabbed victim to be confused, for as long as the grab lasts.
--- @class Component.grabInflictConfusion

--- Prevents this entity’s grab target from moving.
--- @class Component.grabParalyzeVictim

--- Teleports this entity’s grab target when it tries to move.
--- @class Component.grabTeleportVictim

--- Modifies this entity’s kill credit while it is grabbing something.
--- @class Component.grabDenyKillCredit
--- @field mask Kill.Credit # `= -1` 
--- @field storedCredit integer # `= 0` 

--- Causes grabbers to attack this entity when they fail to grab it.
--- (This is normally used on non-`grabbable` entities, so all grab attempts fail).
--- @class Component.attackableByGrabbers

--- @class Entity
--- @field grabbable Component.grabbable
--- @field grab Component.grab
--- @field grabCollision Component.grabCollision
--- @field grabAttackability Component.grabAttackability
--- @field grabRowOrder Component.grabRowOrder
--- @field grabMoveOntoVictim Component.grabMoveOntoVictim
--- @field grabDragVictim Component.grabDragVictim
--- @field grabAttachToVictim Component.grabAttachToVictim
--- @field grabAI Component.grabAI
--- @field grabKnockbackImmunity Component.grabKnockbackImmunity
--- @field grabHopInPlaceOnHit Component.grabHopInPlaceOnHit
--- @field grabIncreaseHealth Component.grabIncreaseHealth
--- @field grabTakeDamageFromVictim Component.grabTakeDamageFromVictim
--- @field grabTakeDirectionalDamageFromVictim Component.grabTakeDirectionalDamageFromVictim
--- @field grabShieldFromVictim Component.grabShieldFromVictim
--- @field grabAttachment Component.grabAttachment
--- @field grabDropGrooveChain Component.grabDropGrooveChain
--- @field grabInflictConfusion Component.grabInflictConfusion
--- @field grabParalyzeVictim Component.grabParalyzeVictim
--- @field grabTeleportVictim Component.grabTeleportVictim
--- @field grabDenyKillCredit Component.grabDenyKillCredit
--- @field attackableByGrabbers Component.attackableByGrabbers

return GrabComponents
