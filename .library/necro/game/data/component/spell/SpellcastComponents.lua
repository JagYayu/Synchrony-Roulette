--- @meta

local SpellcastComponents = {}

--- Marker component.
--- @class Component.spellcast

--- Casts additional copies of this spell on cast.
--- @class Component.spellcastMulticast
--- @field castCount integer # `= 0` 
--- @field rotation integer # `= 0` 

--- Defines how spell upgrades affect spell items that would normally cast this spell.
--- (Despite only affecting spell items, this component goes on the spellcast itself, not on the spell item).
--- @class Component.spellcastUpgradable
--- @field upgradeTypes table # Maps upgrade type => spell name.

--- Sets this spell’s direction to the caster’s facing direction.
--- @class Component.spellcastUseFacingDirection

--- Despawns the caster (optionally after a delay).
--- @class Component.spellcastDespawnCaster
--- @field delay number # `= 0` 

--- Kills the caster.
--- @class Component.spellcastKillCaster

--- Spawns an entity.
--- @class Component.spellcastSpawnEntity
--- @field name string # `= ""` Entity type name to be spawned.
--- @field skipCasterPosition boolean # `= false` Specific to ghoul hallucinations.
--- @field attemptOffsets table # List of {x, y} offsets, attempted in order until a valid spawn position is found.
--- @field collisionMask Collision.Type # `= collision.Group.SOLID` Do not spawn the entity on a tile colliding with this mask.
--- @field attributes table # Table of component values set on the spawned entity.
--- @field distance integer # `= 0` After spawning the entity, moves it by this distance in this spell’s direction.
--- @field diagonalDistanceMalus integer # `= 0` Specific to ND2.

--- Sets the facing direction of the entity spawned by `spellcastSpawnEntity` to this spell’s direction.
--- @class Component.spellcastSpawnApplyDirection

--- Grants an item to the caster.
--- (Despite the inconsistent name, this is indeed a spellcast component).
--- @class Component.spellGrant
--- @field name string # `= ""` 

--- Deals damage to the targets.
--- @class Component.spellcastInflictDamage
--- @field attackFlags Attack.Flag, attack.mask(attack.Flag.DEFAULT # `= attack.Flag.PROVOKE)` 
--- @field damage integer # `= 0` 
--- @field type Damage.Flag # `= damage.Type.MAGIC` 
--- @field silentHit boolean # `= false` 
--- @field orthogonalize boolean # `= false` 
--- @field useCastDirection boolean # `= false` 

--- Deals damage to the targets, using the properties of the caster’s innateAttack.
--- @class Component.spellcastInflictInnateDamage
--- @field attackFlags Attack.Flag # `= attack.Flag.DEFAULT` 
--- @field type Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field defaultDamage integer # `= 0` 

--- Fires `objectEarthquake` on the targets.
--- @class Component.spellcastInflictEarthquake
--- @field damage integer # `= 0` 

--- Reveals all enemies (not just targets).
--- @class Component.spellcastRevealAllEnemies

--- Aggros all enemies (not just targets).
--- @class Component.spellcastAggroAllEnemies

--- Heals the targets.
--- @class Component.spellcastHeal
--- @field health integer # `= 0` 
--- @field maxHealth integer # `= 0` 
--- @field cursedHealth integer # `= 0` 
--- @field invincibility integer # `= 1` 
--- @field overheal boolean # `= false` 
--- @field silent boolean # `= false` 
--- @field noParticles boolean # `= false` 

--- Sets the targets’ health to a specific value.
--- @class Component.spellcastSetHealth
--- @field health integer # `= 1` 

--- Heals the caster based on the number of targets.
--- @class Component.spellcastHealCasterPerTarget
--- @field health integer # `= 2` 

--- Plays a hop animation on each target.
--- @class Component.spellcastHopInPlace

--- Converts target items to randomly generated items.
--- @class Component.spellcastConvertItems

--- Converts the holder’s weapon to a different material.
--- @class Component.spellcastEnchantWeapon

--- Kills targetted items.
--- @class Component.spellcastDestroyItems

--- Kills targetted traps.
--- @class Component.spellcastDestroyTraps

--- Kills targetted gold.
--- @class Component.spellcastDestroyCurrency
--- @field type string # `= currency.Type.GOLD` 
--- @field requirePoverty boolean # `= false` 

--- Collects targetted gold.
--- @class Component.spellcastCollectCurrency
--- @field type string # `= currency.Type.GOLD` 

--- Digs targetted walls.
--- @class Component.spellcastDestroyWalls
--- @field strength Dig.Strength # `= dig.Strength.SHOP` 
--- @field silent boolean # `= false` 
--- @field probability number # `= 1` 

--- Specific to the Crown of Teleportation.
--- @class Component.spellcastOpenLockedShop

--- Changes the tile type of the target tiles.
--- @class Component.spellcastConvertTiles
--- @field types table # Maps original tile type => new tile type.
--- @field default string # `= ""` Floors that aren’t listed in the `types` table are converted to `default` instead.

--- Causes targetted Z2 floors to jump to a specific frame.
--- @class Component.spellcastBurnGrass
--- @field frame integer # `= 3` 

--- Changes targetted wired floors to regular floors.
--- (This could be done with `spellcastConvertTiles`, but is separate for ordering reasons).
--- @class Component.spellcastDestroyWire

--- Changes targetted floors to walls.
--- @class Component.spellcastCreateWalls
--- @field wallType string # `= ""` 
--- @field collisionMask integer # `= 0` 

--- Enables the targets’ barrier.
--- @class Component.spellcastGrantBarrier
--- @field turns integer # `= 0` 

--- Grants iframes to the caster.
--- @class Component.spellcastGrantInvincibility
--- @field turns integer # `= 0` 

--- Knockbacks the targets, in the spell’s direction.
--- @class Component.spellcastKnockback
--- @field attackFlags Attack.Flag # `= attack.Flag.CHARACTER` 
--- @field distance integer # `= 1` 
--- @field moveType Move.Flag, move.Flag.mask(move.Type.KNOCKBACK, move.Flag.VOCALIZE # `= move.Flag.TWEEN_HOP_FAIL)` 
--- @field beatDelay integer # `= 0` 

--- Moves the caster, in a direction based on the spell’s direction.
--- @class Component.spellcastMoveCaster
--- @field distance integer # `= 1` 
--- @field moveType Move.Flag, move.Flag.mask(move.Type.KNOCKBACK # `= move.Flag.TWEEN_HOP_FAIL)` 
--- @field rotation Action.Rotation # `= action.Rotation.IDENTITY` 

--- Either gigantifies or shrinks the targets.
--- @class Component.spellcastModifySize
--- @field size integer # `= 0` 1 means gigantify, -1 means shrink.
--- @field turns integer # `= 0` 

--- Freezes the targets.
--- @class Component.spellcastInflictFreeze
--- @field turns integer # `= 0` 
--- @field attackFlags Attack.Flag # `= attack.FlagGroup.SPELL` 
--- @field type Freeze.Type # `= freeze.Type.ICE` 

--- Confuses the targets.
--- @class Component.spellcastInflictConfusion
--- @field turns integer # `= 0` 
--- @field attackFlags Attack.Flag # `= attack.FlagGroup.SPELL` 

--- Globally enables fear.
--- @class Component.spellcastFear
--- @field turns integer # `= 0` 

--- Charms the targets (this is legacy charm, not Sync charm).
--- @class Component.spellcastCharm

--- Grants a randomly generated item to the caster.
--- @class Component.spellcastGrantRandomItem
--- @field slot string # `= ""` 
--- @field chanceType string # `= "need"` 

--- Activates the effects of a shrine, as if the caster had just bumped it.
--- @class Component.spellcastShrineEffects
--- @field shrine string # `= ""` 

--- Grants gold to the caster.
--- @class Component.spellcastGrantCurrency
--- @field type string # `= currency.Type.GOLD` 
--- @field amount integer # `= 0` 

--- Curses the targets’ health (replacing all normal hearts with cursed hearts).
--- @class Component.spellcastCurseHealth

--- Specific to the food shopkeeper.
--- @class Component.spellcastSpawnBombs

--- Casts other spells.
--- @class Component.spellcastChainCast
--- @field spells table # List of spell names. Those are attempted in order, until one of them succeeds.

--- Transforms all `transformable` targets.
--- @class Component.spellcastTransform

--- Forces targets to descend.
--- @class Component.spellcastDescent
--- @field type Descent.Type # `= descent.Type.RHYTHM` 

--- Resets the caster's target entity to none (0).
--- @class Component.spellcastResetCasterTarget

--- Specific to shopkeeper teleports.
--- @class Component.spellcastSetCasterTargetToAttacker

--- Starts the boss fight, if it was pending.
--- @class Component.spellcastStartBossFight

--- Increases the speedrun timer to the song's maximum
--- @class Component.spellcastPenalizeSpeedrunTime
--- @field additionalTime number # `= 2` 

--- Tries really hard to clear all obstacles from the target area
--- @class Component.spellcastClearObstacles
--- @field damage integer # `= 999` 
--- @field type Damage.Flag # `= damage.Type.SPECIAL` 

--- Teleports the targets.
--- The destination is determined by the `spellTeleportTarget` and `spellTeleportFilter` events.
--- @class Component.spellcastTeleport
--- @field attackFlags Attack.Flag, attack.Flag.mask(attack.FlagGroup.SPELL # `= attack.Flag.IGNORE_TEAM)` 
--- @field moveType Move.Flag # `= move.Type.TELEPORT` 
--- @field extraCollision integer # `= 0` 
--- @field ignoreCollision integer # `= 0` 

--- Sets the destination based on a tile marker (see `Marker`).
--- @class Component.spellcastTeleportToMarker
--- @field markerType integer # `= 0` 
--- @field offsetX integer # `= 0` 
--- @field offsetY integer # `= 0` 

--- Picks the destination inside the target’s `homeArea`.
--- If the target doesn’t have `homeArea`, use its `homePosition` instead.
--- @class Component.spellcastTeleportToHome

--- Picks the destination inside a given segment.
--- @class Component.spellcastTeleportToSegment
--- @field segment integer # `= 1` 

--- Prevents teleporting targets with a given component.
--- @class Component.spellcastTeleportIgnore
--- @field component string # `= ""` 

--- Picks a destination far away from the target’s current position.
--- @class Component.spellcastTeleportMaximizeDistance
--- @field limit integer # `= 8` Inclusive minimum L2 distance. This is weakly enforced: if there’s no valid tile ≥8 away, it falls back to looking for tiles ≥7 away, then ≥6, etc.

--- Restricts the teleport to tiles that are far enough from the nearest entity hostile to the target.
--- @class Component.spellcastTeleportAvoidHostileEntities
--- @field teamBypass Team.Id # `= team.Id.PLAYER` 
--- @field minimumDistance integer # `= 3` Inclusive minimum L2 distance.

--- Specific to shopkeeper teleports.
--- @class Component.spellcastTeleportAvoidExclusionZone
--- @field minimumDistance integer # `= 2` 

--- Disables this spell’s visual and audio effects if it had no valid targets.
--- @class Component.spellcastRequireTargetForFX

--- Changes the killer name shown for entities killed by this spell.
--- @class Component.spellcastOverrideKillerName

--- Creates screen shake on this spell’s position.
--- @class Component.spellcastScreenShake
--- @field duration number # `= 0.25` 
--- @field intensity integer # `= 10` 
--- @field range integer # `= 16` 

--- Flashes the targets’ screen.
--- @class Component.spellcastScreenFlashTargets

--- Flashes everybody’s screen.
--- @class Component.spellcastScreenFlashGlobal

--- Flashes the caster’s screen.
--- @class Component.spellcastScreenFlashCaster
--- @field color integer # `= color.WHITE` 
--- @field sustain number # `= 0` 
--- @field fadeOut number # `= 0.15` 

--- Creates a flyaway on the caster.
--- @class Component.spellcastFlyaway
--- @field text localizedString # `= 0` 
--- @field offsetY integer # `= 0` 

--- Creates a flyaway on each target.
--- @class Component.spellcastFlyawayTargets
--- @field text localizedString # `= 0` 
--- @field offsetY integer # `= 0` 
--- @field attackFlags Attack.Flag # `= attack.FlagGroup.SPELL` 

--- Sets the caster’s text overlay.
--- @class Component.spellcastTextOverlay
--- @field text localizedString # `= 0` 

--- Creates particles on the caster.
--- @class Component.spellcastParticles
--- @field component string # `= "particleSplash"` 

--- Makes the targets play the given voice component
--- @class Component.spellcastVocalize
--- @field component string # `= ""` 

--- @class Entity
--- @field spellcast Component.spellcast
--- @field spellcastMulticast Component.spellcastMulticast
--- @field spellcastUpgradable Component.spellcastUpgradable
--- @field spellcastUseFacingDirection Component.spellcastUseFacingDirection
--- @field spellcastDespawnCaster Component.spellcastDespawnCaster
--- @field spellcastKillCaster Component.spellcastKillCaster
--- @field spellcastSpawnEntity Component.spellcastSpawnEntity
--- @field spellcastSpawnApplyDirection Component.spellcastSpawnApplyDirection
--- @field spellGrant Component.spellGrant
--- @field spellcastInflictDamage Component.spellcastInflictDamage
--- @field spellcastInflictInnateDamage Component.spellcastInflictInnateDamage
--- @field spellcastInflictEarthquake Component.spellcastInflictEarthquake
--- @field spellcastRevealAllEnemies Component.spellcastRevealAllEnemies
--- @field spellcastAggroAllEnemies Component.spellcastAggroAllEnemies
--- @field spellcastHeal Component.spellcastHeal
--- @field spellcastSetHealth Component.spellcastSetHealth
--- @field spellcastHealCasterPerTarget Component.spellcastHealCasterPerTarget
--- @field spellcastHopInPlace Component.spellcastHopInPlace
--- @field spellcastConvertItems Component.spellcastConvertItems
--- @field spellcastEnchantWeapon Component.spellcastEnchantWeapon
--- @field spellcastDestroyItems Component.spellcastDestroyItems
--- @field spellcastDestroyTraps Component.spellcastDestroyTraps
--- @field spellcastDestroyCurrency Component.spellcastDestroyCurrency
--- @field spellcastCollectCurrency Component.spellcastCollectCurrency
--- @field spellcastDestroyWalls Component.spellcastDestroyWalls
--- @field spellcastOpenLockedShop Component.spellcastOpenLockedShop
--- @field spellcastConvertTiles Component.spellcastConvertTiles
--- @field spellcastBurnGrass Component.spellcastBurnGrass
--- @field spellcastDestroyWire Component.spellcastDestroyWire
--- @field spellcastCreateWalls Component.spellcastCreateWalls
--- @field spellcastGrantBarrier Component.spellcastGrantBarrier
--- @field spellcastGrantInvincibility Component.spellcastGrantInvincibility
--- @field spellcastKnockback Component.spellcastKnockback
--- @field spellcastMoveCaster Component.spellcastMoveCaster
--- @field spellcastModifySize Component.spellcastModifySize
--- @field spellcastInflictFreeze Component.spellcastInflictFreeze
--- @field spellcastInflictConfusion Component.spellcastInflictConfusion
--- @field spellcastFear Component.spellcastFear
--- @field spellcastCharm Component.spellcastCharm
--- @field spellcastGrantRandomItem Component.spellcastGrantRandomItem
--- @field spellcastShrineEffects Component.spellcastShrineEffects
--- @field spellcastGrantCurrency Component.spellcastGrantCurrency
--- @field spellcastCurseHealth Component.spellcastCurseHealth
--- @field spellcastSpawnBombs Component.spellcastSpawnBombs
--- @field spellcastChainCast Component.spellcastChainCast
--- @field spellcastTransform Component.spellcastTransform
--- @field spellcastDescent Component.spellcastDescent
--- @field spellcastResetCasterTarget Component.spellcastResetCasterTarget
--- @field spellcastSetCasterTargetToAttacker Component.spellcastSetCasterTargetToAttacker
--- @field spellcastStartBossFight Component.spellcastStartBossFight
--- @field spellcastPenalizeSpeedrunTime Component.spellcastPenalizeSpeedrunTime
--- @field spellcastClearObstacles Component.spellcastClearObstacles
--- @field spellcastTeleport Component.spellcastTeleport
--- @field spellcastTeleportToMarker Component.spellcastTeleportToMarker
--- @field spellcastTeleportToHome Component.spellcastTeleportToHome
--- @field spellcastTeleportToSegment Component.spellcastTeleportToSegment
--- @field spellcastTeleportIgnore Component.spellcastTeleportIgnore
--- @field spellcastTeleportMaximizeDistance Component.spellcastTeleportMaximizeDistance
--- @field spellcastTeleportAvoidHostileEntities Component.spellcastTeleportAvoidHostileEntities
--- @field spellcastTeleportAvoidExclusionZone Component.spellcastTeleportAvoidExclusionZone
--- @field spellcastRequireTargetForFX Component.spellcastRequireTargetForFX
--- @field spellcastOverrideKillerName Component.spellcastOverrideKillerName
--- @field spellcastScreenShake Component.spellcastScreenShake
--- @field spellcastScreenFlashTargets Component.spellcastScreenFlashTargets
--- @field spellcastScreenFlashGlobal Component.spellcastScreenFlashGlobal
--- @field spellcastScreenFlashCaster Component.spellcastScreenFlashCaster
--- @field spellcastFlyaway Component.spellcastFlyaway
--- @field spellcastFlyawayTargets Component.spellcastFlyawayTargets
--- @field spellcastTextOverlay Component.spellcastTextOverlay
--- @field spellcastParticles Component.spellcastParticles
--- @field spellcastVocalize Component.spellcastVocalize

return SpellcastComponents
