--- @meta

local TweenComponents = {}

--- Makes it possible to play movement animations ("tweens") on this entity.
--- @class Component.tween
--- @field defaultTween MoveAnimations.Type # `= moveAnimations.Type.HOP` 
--- @field duration number # `= 0.183` 
--- @field multiPart boolean # `= false` 
--- @field bounciness number # `= 0` 
--- @field maxHeight number # `= 0` 
--- @field exponent number # `= 0` 
--- @field turnID integer # `= -1` 
--- @field sourceX integer # `= 0` 
--- @field sourceY integer # `= 0` 
--- @field midpointX integer # `= 0` 
--- @field midpointY integer # `= 0` 

--- Specific to skeleton knights.
--- @class Component.postConvertOverrideTween
--- @field maxHeight number # `= 12` 
--- @field exponent number # `= 1` 

--- Plays a hop tween on this entity whenever it performs an IDLE action.
--- @class Component.hopInPlaceOnIdle

--- Plays a hop tween on this entity when it unsinks from a liquid.
--- @class Component.hopTweenOnUnsink

--- Plays a bounce tween on this entity when it does its innate attack.
--- @class Component.bounceTweenOnAttack
--- @field tween MoveAnimations.Type # `= moveAnimations.Type.BOUNCE` 

--- Plays a bounce tween on this entity when it takes directional damage while standing still.
--- @class Component.bounceTweenOnHit

--- @class Entity
--- @field tween Component.tween
--- @field postConvertOverrideTween Component.postConvertOverrideTween
--- @field hopInPlaceOnIdle Component.hopInPlaceOnIdle
--- @field hopTweenOnUnsink Component.hopTweenOnUnsink
--- @field bounceTweenOnAttack Component.bounceTweenOnAttack
--- @field bounceTweenOnHit Component.bounceTweenOnHit

return TweenComponents
