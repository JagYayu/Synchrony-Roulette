--- @meta

local AnimationTimer = {}

--- Animations that are not associated with an entity should use this to generate an id
--- that can be passed to .play() and .getTime()
--- @return integer
function AnimationTimer.generateFallbackID(animationName) end

function AnimationTimer.reset() end

function AnimationTimer.resetAfter(thresholdTurnID) end

function AnimationTimer.addTime(difference) end

function AnimationTimer.play(entityID, animationName) end

function AnimationTimer.overrideTime(entityID, animationName, offset) end

--- Similar to AnimationTimer.getTime, but requires passing the turnID manually.
--- Slightly faster since it avoids a lookup, but less convenient.
function AnimationTimer.getReferencedAnimationTime(entityID, turnID, animationName) end

function AnimationTimer.getTime(entityID, animationName) end

function AnimationTimer.isPlayingInTurn(entityID, animationName, turnID) end

function AnimationTimer.getFactor(entityID, animationName, duration) end

function AnimationTimer.getFactorClamped(entityID, animationName, duration) end

--- Deprecated aliases
function AnimationTimer.playAnimation(entityID) end

function AnimationTimer.getAnimationTime(entityID) end

function AnimationTimer.getAnimationFactor(entityID, duration) end

function AnimationTimer.getAnimationFactorClamped(entityID, duration) end

function AnimationTimer.playReferencedAnimation(entityID, _, animationName) end

function AnimationTimer.getReferencedAnimationFactor(entityID, turnID, animationName, duration) end

function AnimationTimer.getReferencedAnimationFactorClamped(entityID, turnID, animationName, duration) end

return AnimationTimer
