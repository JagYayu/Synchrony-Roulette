--- @meta

local Swipe = {}

Swipe.FollowMode = {
	NONE = 0,
	TWEEN = 1,
	TILE = 2,
}

function Swipe.getFollowMode() end

function Swipe.getExplosionIntensity() end

function Swipe.isDashOffsetActive() end

--- @return any[]
function Swipe.getAll() end

function Swipe.create(parameters) end

function Swipe.inherit(ev, baseType) end

function Swipe.getAnimationFraction(instance) end

function Swipe.getAnimationFrame(instance) end

function Swipe.isExpired(instance) end

return Swipe
