--- @meta

local Animations = {}

function Animations.reverse(animation) end

function Animations.offBeat(firstFrame, numFrames, duration, hold) end

function Animations.getAnimationFrame(entity, animationName, variant, fraction) end

function Animations.apply(animationName, animationFunc, extraFilter) end

return Animations
