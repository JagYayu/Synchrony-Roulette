--- @meta

local SpriteEffectComponents = {}

--- Resets this entity’s opacity before applying sprite effects.
--- All components that modify opacity multiplicatively should declare this as a dependency.
--- @class Component.opacityEffect
--- @field baseOpacity number # `= 1.0` 

--- Gradually changes the entity’s opacity.
--- @class Component.fadeEffect
--- @field fadedOpacity number # `= 0` 
--- @field animationDuration number # `= 0.15` 
--- @field active boolean # `= false` Protected field. Do not set directly, use `SpriteEffects.setFade` instead.

--- Plays this entity’s `fadeEffect` when it enters or leaves stasis.
--- @class Component.stasisFade
--- @field ignoreFrozen boolean # `= false` 

--- Makes the entity alternatively visible and invisible.
--- @class Component.blinkEffect
--- @field intervalOn number # `= 0.1` 
--- @field intervalOff number # `= 0.1` 
--- @field duration number # `= 0` 
--- @field active boolean # `= false` Protected field. Do not set directly, use `SpriteEffects.blink` instead.

--- Plays this entity’s `blinkEffect` when it gains iframes.
--- @class Component.invincibilityBlinkEffect
--- @field duration number # `= 0.45` 

--- Plays the holder’s `blinkEffect` when this item’s conditional invincibility activates.
--- @class Component.itemConditionalInvincibilityBlinkEffect
--- @field duration number # `= 0.45` 

--- Lowers the holder’s opacity.
--- @class Component.itemHolderFadeEffect
--- @field opacity number # `= 0` 

--- Overrides this entity’s opacity depending on its caster’s focus.
--- @class Component.spawnableFocusFadeEffect
--- @field focusedOpacity number # `= 1` 
--- @field unfocusedOpacity number # `= 0` 
--- @field flag Focus.Flag # `= focus.Flag.OBJECT_VISIBILITY` 

--- Changes the holder’s z-order.
--- @class Component.itemHolderZOffset
--- @field z number # `= 0` 

--- Lowers this entity’s opacity when it’s far away from its target.
--- @class Component.targetProximityFadeEffect
--- @field distance number # `= 1` Minimum exclusive L2 distance at which the effect applies.
--- @field fadedOpacity number # `= 0` 

--- Sets this entity’s opacity equal to its tile’s brightness.
--- @class Component.fadeToTileBrightnessEffect

--- Sets this entity’s brightness equal to its tile’s brightness.
--- @class Component.darkenToTileBrightnessEffect

--- Stops this entity’s animations while it is frozen.
--- @class Component.animationFreezeEffect
--- @field minimumTurns integer # `= 0` 
--- @field needUpdate boolean # `= true` 

--- Adds a periodic oscillation to this entity’s vertical position.
--- @class Component.hoverEffect
--- @field active boolean # `= false` 
--- @field offset integer # `= 0` 
--- @field amplitude number # `= 2.5` 
--- @field exponent number # `= 1.5` 
--- @field period number # `= 1` 
--- @field toggleDuration number # `= 0.125` 
--- @field timeStart number # `= 0` 

--- Permanently enables this entity’s `hoverEffect`.
--- @class Component.hoverEffectAlwaysEnabled

--- Disables this entity’s `hoverEffect` while it is descending.
--- @class Component.hoverEffectDisableOnDescent

--- Enables the holder’s `hoverEffect`.
--- @class Component.itemHolderHoverEffect

--- Adds a vertical offset to this entity if it spawned immediately above a wall.
--- @class Component.spriteOffsetIfAboveWall
--- @field offsetY number # `= 0` 
--- @field active boolean # `= false` 

--- Adds a vertical offset to this entity as long as it is inside a wall.
--- @class Component.spriteOffsetIfInsideWall
--- @field offsetY number # `= 0` 

--- Adds an offset to this entity depending on its current animation frame.
--- @class Component.spriteOffsetPerFrame
--- @field offsetX table # Maps frameX => offset
--- @field offsetY table # Maps frameX => offset

--- Crops this entity’s sprite while it is sunken in a liquid.
--- @class Component.spriteCropOnSink
--- @field sinkOffset integer # `= 0` 
--- @field sinkDistance integer # `= 6` 
--- @field animationDuration number # `= 0.05` 
--- @field animationDelay number # `= 0` 
--- @field startCrop integer # `= 0` 
--- @field endCrop integer # `= 0` 

--- Crops this entity’s sprite while it is going down a trapdoor.
--- @class Component.spriteCropOnDescent
--- @field descentType Descent.Type # `= descent.Type.TRAPDOOR` 
--- @field offset number # `= 3.6` 
--- @field velocity number # `= -126` Initial vertical speed in pixels per second.
--- @field acceleration number # `= 540` Vertical acceleration in pixels per second².
--- @field cropOffset number # `= 7` 
--- @field active boolean # `= false` 

--- Rotates this entity’s sprite while it is sliding.
--- @class Component.slideSwayEffect
--- @field angle number # `= 0` 
--- @field swayAmplitude number # `= 0` 
--- @field swayDuration number # `= 1` 
--- @field startupDuration number # `= 0` 
--- @field decayDuration number # `= 0` 

--- Determines the color of the "blood stains" this entity leaves on spike traps.
--- @class Component.bloodColor
--- @field color integer # `= color.hsv(0.978, 1, 1)` 

--- Causes this entity’s scale to be recomputed each tick.
--- This is needed for real-time-based scale effects to work.
--- @class Component.scaleEffect

--- Multiplies this entity’s scale while it is giant.
--- @class Component.spriteGigantismScale
--- @field scale number # `= 1.5` 
--- @field blinkPeriod number # `= 10 / 60` 

--- Multiplies this entity’s scale while it is shrunk.
--- @class Component.spriteDwarfismScale
--- @field scale number # `= 0.6` 
--- @field blinkPeriod number # `= 10 / 60` 

--- Adds a periodic oscillation to this entity’s horizontal position.
--- @class Component.spriteVibrate
--- @field active boolean # `= false` 
--- @field period number # `= 0.05` 
--- @field x number # `= 1` 

--- Enables this entity’s `spriteVibrate` while its beat delay is 0.
--- @class Component.spriteVibrateOnTell

--- Enables this entity’s `spriteVibrate` while it has a pending action.
--- @class Component.spriteVibrateOnActionDelay
--- @field maxDelay integer # `= 1` 
--- @field action Action.Special # `= action.Special.SPELL_1` 

--- Specific to lobby arrows.
--- @class Component.spriteCopyTextOpacity

--- Changes this entity’s vertical offset, opacity, and row order while it is inside a wall.
--- @class Component.tileCoverEffect

--- @class Entity
--- @field opacityEffect Component.opacityEffect
--- @field fadeEffect Component.fadeEffect
--- @field stasisFade Component.stasisFade
--- @field blinkEffect Component.blinkEffect
--- @field invincibilityBlinkEffect Component.invincibilityBlinkEffect
--- @field itemConditionalInvincibilityBlinkEffect Component.itemConditionalInvincibilityBlinkEffect
--- @field itemHolderFadeEffect Component.itemHolderFadeEffect
--- @field spawnableFocusFadeEffect Component.spawnableFocusFadeEffect
--- @field itemHolderZOffset Component.itemHolderZOffset
--- @field targetProximityFadeEffect Component.targetProximityFadeEffect
--- @field fadeToTileBrightnessEffect Component.fadeToTileBrightnessEffect
--- @field darkenToTileBrightnessEffect Component.darkenToTileBrightnessEffect
--- @field animationFreezeEffect Component.animationFreezeEffect
--- @field hoverEffect Component.hoverEffect
--- @field hoverEffectAlwaysEnabled Component.hoverEffectAlwaysEnabled
--- @field hoverEffectDisableOnDescent Component.hoverEffectDisableOnDescent
--- @field itemHolderHoverEffect Component.itemHolderHoverEffect
--- @field spriteOffsetIfAboveWall Component.spriteOffsetIfAboveWall
--- @field spriteOffsetIfInsideWall Component.spriteOffsetIfInsideWall
--- @field spriteOffsetPerFrame Component.spriteOffsetPerFrame
--- @field spriteCropOnSink Component.spriteCropOnSink
--- @field spriteCropOnDescent Component.spriteCropOnDescent
--- @field slideSwayEffect Component.slideSwayEffect
--- @field bloodColor Component.bloodColor
--- @field scaleEffect Component.scaleEffect
--- @field spriteGigantismScale Component.spriteGigantismScale
--- @field spriteDwarfismScale Component.spriteDwarfismScale
--- @field spriteVibrate Component.spriteVibrate
--- @field spriteVibrateOnTell Component.spriteVibrateOnTell
--- @field spriteVibrateOnActionDelay Component.spriteVibrateOnActionDelay
--- @field spriteCopyTextOpacity Component.spriteCopyTextOpacity
--- @field tileCoverEffect Component.tileCoverEffect

return SpriteEffectComponents
