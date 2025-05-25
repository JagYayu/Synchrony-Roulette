--- @meta

local TrapComponents = {}

--- Generic component identifying a ground trap, which is any entity that acts a short time after being stepped on.
--- @class Component.trap
--- @field targetFlags Attack.Flag # `= attack.Flag.TRAP` Specifies which entities can trigger the trap and are affected by its effects.
--- @field triggerDelay number # `= 0.2` Specifies the delay (in seconds) upon stepping on the trap after which the its effects trigger.

--- Marks this entity as being potentially vulnerable to trap effects.
--- For the entity to actually be trapped, it also needs to pass an attackability check.
--- @class Component.trappable
--- @field immuneTurnID integer # `= -1` Trap victims gain trap immunity until their next move. However, to allow stacked traps, further traps triggering in the same turn bypass this immunity. This field contains the turn ID where the victim gained immunity. -1 = no immunity, -2 = immunity ignoring the "same turn" exception

--- Doubles the effect of `trapInflictDamage` on this entity.
--- @class Component.trappableTakeDoubleDamage

--- Inflicts damage to any entity triggering the trap.
--- @class Component.trapInflictDamage
--- @field damage integer # `= 0` 
--- @field type Damage.Flag # `= damage.Type.TRAP` 

--- Converts the trap after being triggered.
--- @class Component.trapConvert
--- @field targetType string # `= ""` 

--- Destroys the trap if a spell with `spellcastDestroyTraps` is cast upon it
--- @class Component.trapDestructible

--- The trap is immune to destruction outside of the main segment
--- @class Component.trapSegmentImmunity

--- Destroys the trap if it is triggered by an entity with the "crushTraps" tag
--- @class Component.trapCrushable

--- Workaround to make cross-segment teleports work as expected
--- @class Component.trapFixTargets

--- Destroys traps with the "trapCrushable" tag
--- @class Component.crushTraps

--- Causes victims to fall down into the next level.
--- @class Component.trapDescend
--- @field type Descent.Type # `= descent.Type.TRAPDOOR` 

--- Forces any entity triggering the trap to move in a certain direction.
--- @class Component.trapMove
--- @field moveType Move.Flag # `= move.Type.KNOCKBACK` 

--- Moves the victim in this trap’s facing direction.
--- @class Component.trapMoveAbsoluteDirection

--- Moves the victim in a direction depending on the victim’s last move (omnibounce trap).
--- @class Component.trapMoveRelativeDirection
--- @field rotation Action.Rotation # `= action.Rotation.IDENTITY` 

--- @class Component.trapMoveRedirectSlide

--- Scatters all inventory items held by an entity triggering the trap.
--- @class Component.trapScatterInventory
--- @field collisionMask Collision.Type, collision.mask(collision.Group.SOLID, collision.Type.ITEM # `= collision.Type.TRAP)` 
--- @field droppedSlots table # 

--- Casts a spell whenever the trap is triggered.
--- @class Component.trapCast
--- @field spell string # `= ""` 
--- @field direction Action.Direction # `= action.Direction.NONE` 

--- Modifies the music's playback speed for a limited amount of time.
--- @class Component.trapModifyMusicSpeed
--- @field factor number # `= 1` 
--- @field duration number # `= 0` 
--- @field fadeIn number # `= 0` 
--- @field fadeOut number # `= 0` 
--- @field region integer # `= 0` 

--- Teleports the victim to specific coordinates
--- @class Component.trapTravel
--- @field collisionMask Collision.Type # `= collision.Group.SOLID` 
--- @field xOff integer # `= 0` 
--- @field yOff integer # `= 0` 
--- @field x integer # `= 0` 
--- @field y integer # `= 0` 

--- In custom dungeons with two instances of this trap, links them to each other.
--- @class Component.trapTravelAutoConnect
--- @field active boolean # `= true` 

--- Allows this trap to transmit pings across isolated segments.
--- @class Component.trapTravelTransmitPing

--- Makes the victim play the given voice component or sound
--- @class Component.trapVocalize
--- @field component string # `= ""` 
--- @field sound string # `= ""` 

--- Shoot aligned hostile entities
--- @class Component.trapFirepig
--- @field litRange integer # `= 5` 
--- @field unlitRange integer # `= 4` 
--- @field collisionMask Collision.Type # `= collision.Type.WALL` 
--- @field cooldown integer # `= 6` 
--- @field action Action.Special # `= action.Special.SPELL_1` 

--- Creates a flyaway when this trap triggers.
--- @class Component.trapFlyaway
--- @field success localizedString # `= 0` 
--- @field failure localizedString # `= 0` 

--- Tints this trap with the victim’s `bloodColor` after a successful activation.
--- @class Component.trapBloodSprite

--- Deletes this trap on activation.
--- @class Component.trapSelfDelete

--- Converts the victim’s weapon to a different material.
--- @class Component.trapEnchantWeapon
--- @field component string # `= ""` Weapon material name.

--- Grants invincibility to the victim.
--- @class Component.trapGrantInvincibility
--- @field turns integer # `= 1` 

--- Handles arena and shriner secret room fights.
--- @class Component.secretFightMarker
--- @field fights table # List of lists of enemy type names.
--- @field expand boolean # `= false` 
--- @field started boolean # `= false` 
--- @field pending boolean # `= false` 
--- @field enemies table # 

--- @class Entity
--- @field trap Component.trap
--- @field trappable Component.trappable
--- @field trappableTakeDoubleDamage Component.trappableTakeDoubleDamage
--- @field trapInflictDamage Component.trapInflictDamage
--- @field trapConvert Component.trapConvert
--- @field trapDestructible Component.trapDestructible
--- @field trapSegmentImmunity Component.trapSegmentImmunity
--- @field trapCrushable Component.trapCrushable
--- @field trapFixTargets Component.trapFixTargets
--- @field crushTraps Component.crushTraps
--- @field trapDescend Component.trapDescend
--- @field trapMove Component.trapMove
--- @field trapMoveAbsoluteDirection Component.trapMoveAbsoluteDirection
--- @field trapMoveRelativeDirection Component.trapMoveRelativeDirection
--- @field trapMoveRedirectSlide Component.trapMoveRedirectSlide
--- @field trapScatterInventory Component.trapScatterInventory
--- @field trapCast Component.trapCast
--- @field trapModifyMusicSpeed Component.trapModifyMusicSpeed
--- @field trapTravel Component.trapTravel
--- @field trapTravelAutoConnect Component.trapTravelAutoConnect
--- @field trapTravelTransmitPing Component.trapTravelTransmitPing
--- @field trapVocalize Component.trapVocalize
--- @field trapFirepig Component.trapFirepig
--- @field trapFlyaway Component.trapFlyaway
--- @field trapBloodSprite Component.trapBloodSprite
--- @field trapSelfDelete Component.trapSelfDelete
--- @field trapEnchantWeapon Component.trapEnchantWeapon
--- @field trapGrantInvincibility Component.trapGrantInvincibility
--- @field secretFightMarker Component.secretFightMarker

return TrapComponents
