--- @meta

local AttackComponents = {}

--- Lets this entity be attacked. Each flag appearing in `attackable.currentFlags`
--- makes this entity vulnerable to attacks checking for that flag.
--- @class Component.attackable
--- @field currentFlags integer # `= 0` Computed field. Do not modify directly, use an `objectUpdateAttackability` handler instead.
--- @field flags Attack.Flag, attack.mask(attack.Flag.CHARACTER # `= attack.Flag.DEFAULT)` 

--- Marks this entity as part of a team, making it friendly to entities in the same team.
--- Entities without a team are hostile to every entity, including themselves.
--- Team id NONE (0) is special, and is treated the same as not having the `team` component at all.
--- @class Component.team
--- @field id integer # `= 0` Protected field! Do not modify directly, use `Team.setTeam` instead.

--- Grants kill credit to the attacker when killing this entity. See `Kill.Credit`.
--- @class Component.killCredit
--- @field mask Kill.Credit # `= kill.CREDIT_ALL` 

--- Prevents same-team attackers from getting kill credit for killing this entity.
--- @class Component.killCreditRequireHostileAttacker
--- @field removeFlags Kill.Credit # `= kill.CREDIT_ALL` 

--- Prevents this entity from granting some kill credit, regardless of the value of `killCredit.mask`.
--- @class Component.killCreditIgnore
--- @field mask integer # `= 0` 

--- Causes this entity to spawn a tombstone upon dying, reducing rollback in online multiplayer.
--- @class Component.dropTombstoneOnDeath
--- @field entityType string # `= "Tombstone"` 

--- Overrides explosive damage dealt by this entity.
--- @class Component.explosive
--- @field damage integer # `= 4` 

--- Prevents this entity from dealing explosive damage to entities in the same team.
--- @class Component.explosiveSafe

--- Makes this entity move after attacking.
--- @class Component.moveOnAttack
--- @field moveType Move.Flag, move.Flag.unmask(move.Type.UNCHECKED # `= move.Flag.INHIBIT_FROZEN)` This must not include move.Flag.HANDLE_ATTACK, or it would cause infinite recursion.

--- When this entity attacks, sets the victim’s gold to 0.
--- @class Component.stealGoldOnAttack
--- @field castOnSuccess string # `= ""` 

--- Lets this entity attack enemies standing in its way when it tries moving several tiles at once.
--- @class Component.attackOnPartialMove
--- @field damageMultiplier integer # `= 1` 

--- Lets this entity attack its enemies without a weapon, by simply moving into them.
--- @class Component.innateAttack
--- @field damage integer # `= 0` 
--- @field swipe string # `= "enemy"` 
--- @field flags Attack.Flag # `= attack.Flag.DEFAULT` 
--- @field type Damage.Flag # `= damage.Type.PHYSICAL` 
--- @field knockback integer # `= 0` 

--- Prevents innate attacks from happening while this entity is intangible.
--- @class Component.innateAttackRequireTangibility

--- Prevents innate attacks temporarily by unmasking `move.Flag.HANDLE_ATTACK` from the entity's move flags.
--- Lasts for a number of turns, ticking down for every turn that the entity is active.
--- @class Component.innateAttackInhibitTemporarily
--- @field remainingTurns integer # `= 0` 

--- Prevents retaliation against attacks by unmasking `move.Flag.HANDLE_ATTACK` from the current turn's move flags
--- @class Component.innateAttackInhibitOnHit
--- @field turnID integer # `= -1` 

--- Prevents this entity from attacking entities other than its target (except for non-targetable entities)
--- @class Component.innateAttackInhibitAgainstNonTarget

--- Lets this entity be knocked back by attacks.
--- @class Component.knockbackable
--- @field minimumDistance integer # `= 0` If this is greater than 0, forces any hit on this entity to knock it back.
--- @field beatDelay integer # `= 1` When this entity takes knockback, its beat delay increases by this much.
--- @field moveType Move.Flag # `= move.Type.KNOCKBACK` 

--- When this entity takes knockback, sets it beat delay equal to `knockbackable.beatDelay`
--- (instead of increasing it by that much).
--- @class Component.knockbackableResetBeatDelay

--- Prevents this entity from being moved by knockback. It still suffers the other effects of knockback.
--- @class Component.knockbackableInhibitMovement

--- Prevents this entity from acting during any turn where it has been knocked back.
--- @class Component.knockbackablePreventActions

--- Prevents this entity from being knocked back more than once per "frame" (twice per turn).
--- @class Component.knockbackableOncePerFrame
--- @field done boolean # `= false` 

--- When this entity takes knockback while player inputs are being processed (e.g. as a result of a player's attack),
--- the knockback is deferred until later in the same turn, before enemy action processing begins.
--- This eliminates sub-beat order dependencies and the resulting rollback in online multiplayer sessions.
--- @class Component.knockbackableDeferred

--- Lets this entity be shoved by the Shield of Shove.
--- @class Component.shovable

--- Prevents this entity from being moved by shoves. It still suffers the other effects of shoves.
--- @class Component.shovableInhibitMovement

--- Treats this entity as an indestructible obstacle when shoved against a wall by Shield of Shove,
--- allowing other entities to be crushed against it.
--- @class Component.shovableIndestructible

--- Tracks how many consecutive attacks this entity has performed (used for attack voices).
--- @class Component.hitChain
--- @field consecutiveHits integer # `= 0` 
--- @field totalHits integer # `= 0` 
--- @field forceMax boolean # `= false` 

--- Increases damage dealt by this entity.
--- @class Component.damageIncrease
--- @field damage integer # `= 0` 
--- @field type Damage.Flag # `= damage.Flag.STRENGTH_BASED` 

--- Tags this entity as a reflectable projectile.
--- @class Component.projectileReflectable
--- @field turnID integer # `= -1` 

--- Increases this entity's priority value upon being reflected
--- @class Component.projectileReflectablePriority
--- @field increase integer # `= character.Priority.PROJECTILE_REFLECTED` 

--- Prevents this entity from being damaged by other entities in the same team.
--- @class Component.friendlyFireProtection

--- Allows this entity to initiate friendly fire attacks at melee range.
--- @class Component.friendlyFireEnableAttacks
--- @field itemType string # `= "FriendlyFireTeamChanger"` Item granted temporarily while performing a friendly fire attack.

--- Allows this entity to be attacked in friendly fire mode.
--- @class Component.friendlyFireTargetable

--- Prevents all friendly fire damage in the spawn area.
--- @class Component.friendlyFireExclusionZone
--- @field range integer # `= 2` Radius of the square-shaped area around the spawn point in which friendly fire should be disabled.

--- Deals damage to the holder when it moves back to its previous tile.
--- @class Component.itemNoReturn
--- @field damage integer # `= 1` 
--- @field type Damage.Flag # `= damage.Type.SPECIAL` 
--- @field singleUse boolean # `= false` 
--- @field active boolean # `= false` 
--- @field skipTurnID integer # `= 0` 

--- @class Entity
--- @field attackable Component.attackable
--- @field team Component.team
--- @field killCredit Component.killCredit
--- @field killCreditRequireHostileAttacker Component.killCreditRequireHostileAttacker
--- @field killCreditIgnore Component.killCreditIgnore
--- @field dropTombstoneOnDeath Component.dropTombstoneOnDeath
--- @field explosive Component.explosive
--- @field explosiveSafe Component.explosiveSafe
--- @field moveOnAttack Component.moveOnAttack
--- @field stealGoldOnAttack Component.stealGoldOnAttack
--- @field attackOnPartialMove Component.attackOnPartialMove
--- @field innateAttack Component.innateAttack
--- @field innateAttackRequireTangibility Component.innateAttackRequireTangibility
--- @field innateAttackInhibitTemporarily Component.innateAttackInhibitTemporarily
--- @field innateAttackInhibitOnHit Component.innateAttackInhibitOnHit
--- @field innateAttackInhibitAgainstNonTarget Component.innateAttackInhibitAgainstNonTarget
--- @field knockbackable Component.knockbackable
--- @field knockbackableResetBeatDelay Component.knockbackableResetBeatDelay
--- @field knockbackableInhibitMovement Component.knockbackableInhibitMovement
--- @field knockbackablePreventActions Component.knockbackablePreventActions
--- @field knockbackableOncePerFrame Component.knockbackableOncePerFrame
--- @field knockbackableDeferred Component.knockbackableDeferred
--- @field shovable Component.shovable
--- @field shovableInhibitMovement Component.shovableInhibitMovement
--- @field shovableIndestructible Component.shovableIndestructible
--- @field hitChain Component.hitChain
--- @field damageIncrease Component.damageIncrease
--- @field projectileReflectable Component.projectileReflectable
--- @field projectileReflectablePriority Component.projectileReflectablePriority
--- @field friendlyFireProtection Component.friendlyFireProtection
--- @field friendlyFireEnableAttacks Component.friendlyFireEnableAttacks
--- @field friendlyFireTargetable Component.friendlyFireTargetable
--- @field friendlyFireExclusionZone Component.friendlyFireExclusionZone
--- @field itemNoReturn Component.itemNoReturn

return AttackComponents
