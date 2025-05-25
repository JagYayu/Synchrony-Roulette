--- @meta

local AnimationComponents = {}

--- Always active.
--- @class Component.normalAnimation
--- @field frames table # 

--- Always active.
--- @class Component.directionalAnimation
--- @field frames table # 
--- @field variants table # Variant key is the facing direction

--- Active if this entity is close enough to its target.
--- @class Component.targetProximityAnimation
--- @field frames table # 
--- @field distance number # `= 1` Inclusive maximum L2 distance to the target

--- Active every other beat.
--- @class Component.parityAnimation
--- @field frames table # 

--- Active for a short time at random intervals.
--- @class Component.blinkAnimation
--- @field activeTime integer # `= 0` 
--- @field duration number # `= 1/3` 
--- @field minInterval number # `= 0.5` 
--- @field maxInterval number # `= 2` 
--- @field frames table # 

--- Active if parry is on cooldown.
--- @class Component.parryVulnerabilityAnimation
--- @field frames table # 

--- Active if this entity is provoked.
--- @class Component.provokeAnimation
--- @field frames table # 

--- Active if this entity is in stasis.
--- @class Component.stasisAnimation
--- @field frames table # 

--- Active if this entity’s beat delay is low enough.
--- @class Component.tellAnimation
--- @field frames table # 
--- @field variants table # Variant key is the beat delay
--- @field maxDelay integer # `= 0` Inclusive maximum beat delay for which the animation is active.

--- Active if this entity is stunned.
--- @class Component.stunAnimation
--- @field frames table # 
--- @field variants table # Variant key is the stun counter

--- Active if this entity is grabbing something.
--- @class Component.grabAnimation
--- @field frames table # 

--- Active if this entity has a pending delayed action.
--- @class Component.actionDelayAnimation
--- @field frames table # 
--- @field variants table # Variant key is the current delayed action

--- Specific to ogres.
--- @class Component.clonkTellAnimation
--- @field frames table # 

--- Active if this entity’s last action had the given result.
--- @class Component.moveResultAnimation
--- @field result Action.Result # `= action.Result.SPELL` 
--- @field active boolean # `= false` 
--- @field frames table # 

--- Specific to the Mommy.
--- @class Component.spawnPrepAnimation
--- @field frames table # 

--- Active if this entity is charging.
--- @class Component.chargeAnimation
--- @field frames table # 
--- @field variants table # Variant key is the charge direction

--- Active if this shrine has been activated.
--- @class Component.shrineActiveAnimation
--- @field frames table # 

--- Always active.
--- @class Component.trapActivationAnimation
--- @field frames table # 

--- Active if this trap failed its latest activation.
--- @class Component.trapFailAnimation
--- @field active boolean # `= false` 
--- @field frames table # 

--- Active if this item is equipped.
--- @class Component.itemHUDAnimation
--- @field frames table # 

--- Active if `active` is set to true. Other code is free to use any condition to set `active`.
--- @class Component.customAnimation
--- @field frames table # 
--- @field variants table # Variant key is customAnimation.activeVariant
--- @field active boolean # `= false` 
--- @field activeVariant boolean # `= false` 

--- Causes this entity to restart its offBeat animation timer every beat.
--- @class Component.offBeatAnimationTimer

--- Sets the animation speed used by previews of this entity.
--- @class Component.previewAnimationSpeed
--- @field factor integer # `= 1` 

--- Specific to tempo traps.
--- @class Component.tempoTrapSpriteChange
--- @field activeFrameX integer # `= 0` 
--- @field defaultFrameX integer # `= 0` 

--- Specific to ND1 button traps.
--- @class Component.buttonTrapSpriteChange
--- @field activeFrameX integer # `= 0` 
--- @field defaultFrameX integer # `= 0` 

--- Overrides this entity’s frameX while it is stunned.
--- @class Component.sleepSpriteChange
--- @field unprovokedFrameX integer # `= 0` Frame used when this entity is stunned but not provoked.
--- @field provokedFrameX integer # `= 0` Frame used when this entity is stunned and provoked.

--- Animates this entity’s `extraSprite`.
--- @class Component.extraSpriteAnimation
--- @field frames table # 

--- Specific to mummies.
--- @class Component.animationCycling
--- @field frameX integer # `= 0` 
--- @field period integer # `= 0` 

--- Active if this entity is wired.
--- Not a regular animation! The animation frame it computes is *added* to this entity’s
--- frameX, instead of overriding it.
--- @class Component.wiredAnimation
--- @field frames table # 
--- @field turnID integer # `= 0` 
--- @field delay number # `= 0.15` 

--- Adds to this entity’s frameX depending on its facing direction.
--- @class Component.directionalSpriteChange
--- @field frameX table # Maps direction => frameX offset.

--- Adds to this entity’s frameX if it is about to perform a parry counter-attack.
--- @class Component.parrySpriteChange
--- @field frameX integer # `= 0` 

--- Adds to this entity’s frameX at timings determined by its music layer.
--- @class Component.musicLayerSpriteChange
--- @field frameX integer # `= 0` 

--- Animation-frame-based positional offsets for the "?" sprite for locked characters.
--- @class Component.playableCharacterLockedIndicatorOffset
--- @field offsetX number # `= 0` Fixed X offset
--- @field offsetsY table # List of Y offsets per animation frame

--- Freezes the screen for this entity when it takes damage.
--- @class Component.hitstopOnDamage
--- @field duration number # `= 0.08` 

--- Freezes the screen for the killer when this entity dies.
--- @class Component.hitstopOnVisibleDeath
--- @field duration number # `= 0.08` 

--- Freezes the screen for this entity when it dies.
--- @class Component.hitstopOnDeath
--- @field duration number # `= 0.18` 

--- @class Entity
--- @field normalAnimation Component.normalAnimation
--- @field directionalAnimation Component.directionalAnimation
--- @field targetProximityAnimation Component.targetProximityAnimation
--- @field parityAnimation Component.parityAnimation
--- @field blinkAnimation Component.blinkAnimation
--- @field parryVulnerabilityAnimation Component.parryVulnerabilityAnimation
--- @field provokeAnimation Component.provokeAnimation
--- @field stasisAnimation Component.stasisAnimation
--- @field tellAnimation Component.tellAnimation
--- @field stunAnimation Component.stunAnimation
--- @field grabAnimation Component.grabAnimation
--- @field actionDelayAnimation Component.actionDelayAnimation
--- @field clonkTellAnimation Component.clonkTellAnimation
--- @field moveResultAnimation Component.moveResultAnimation
--- @field spawnPrepAnimation Component.spawnPrepAnimation
--- @field chargeAnimation Component.chargeAnimation
--- @field shrineActiveAnimation Component.shrineActiveAnimation
--- @field trapActivationAnimation Component.trapActivationAnimation
--- @field trapFailAnimation Component.trapFailAnimation
--- @field itemHUDAnimation Component.itemHUDAnimation
--- @field customAnimation Component.customAnimation
--- @field offBeatAnimationTimer Component.offBeatAnimationTimer
--- @field previewAnimationSpeed Component.previewAnimationSpeed
--- @field tempoTrapSpriteChange Component.tempoTrapSpriteChange
--- @field buttonTrapSpriteChange Component.buttonTrapSpriteChange
--- @field sleepSpriteChange Component.sleepSpriteChange
--- @field extraSpriteAnimation Component.extraSpriteAnimation
--- @field animationCycling Component.animationCycling
--- @field wiredAnimation Component.wiredAnimation
--- @field directionalSpriteChange Component.directionalSpriteChange
--- @field parrySpriteChange Component.parrySpriteChange
--- @field musicLayerSpriteChange Component.musicLayerSpriteChange
--- @field playableCharacterLockedIndicatorOffset Component.playableCharacterLockedIndicatorOffset
--- @field hitstopOnDamage Component.hitstopOnDamage
--- @field hitstopOnVisibleDeath Component.hitstopOnVisibleDeath
--- @field hitstopOnDeath Component.hitstopOnDeath

return AnimationComponents
