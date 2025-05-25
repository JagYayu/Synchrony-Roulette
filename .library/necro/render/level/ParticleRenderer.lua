--- @meta

local ParticleRenderer = {}

ParticleRenderer.Direction = {
}

function ParticleRenderer.initStatefulParticles(ev, directionCallback, multiplier) end

function ParticleRenderer.attract(ev, x, y, z, velocityXY, velocityZ) end

function ParticleRenderer.jitter(ev, velocityXY, velocityZ) end

function ParticleRenderer.friction(ev, friction, frictionZ) end

function ParticleRenderer.ceaseSpawning(ev) end

function ParticleRenderer.Direction.NONE(ev) end

function ParticleRenderer.Direction.LIT_FLOOR(ev) end

function ParticleRenderer.Direction.EVENT(ev) end

return ParticleRenderer
