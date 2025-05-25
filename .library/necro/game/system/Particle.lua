--- @meta

local Particle = {}

--- @class Particle.Parameters
--- @field duration? number Duration of the particle effect in seconds
--- @field minDelay? number Minimum value for random particle delays in seconds
--- @field maxDelay? number Maximum value for random particle delays in seconds
--- @field fadeDelay? number Number of seconds before the particle starts fading out
--- @field fadeTime? number Number of seconds the particle takes to fully fade out
--- @field minOpacity? number Minimum value for random per-particle opacity
--- @field maxSize? number Maximum value for random per-particle scale factors
--- @field spread? number Random displacement to spread particles across the X/Y axes
--- @field velocity? number Speed at which emitted particles travel across the X/Y axes
--- @field offsetY? number Pixel offset by which to displace particles along the Y axis
--- @field offsetZ? number Pixel offset by which to displace particles along the Z axis, causing them to fall longer
--- @field gravity? number Downward acceleration to apply to particles along the Z axis
--- @field explosiveness? number Speed at which emitted particles travel along all axes by their random offset
--- @field bounciness? number Proportion of velocity retained after a particle bounces off a wall or the ground

--- Advanced function to play a particle effect independently of any entity.
--- It's recommended to use `Particle.play()` instead, whenever possible.
--- @param params Particle.Parameters
function Particle.playFromTable(params) end

--- Play the particle effect according to the specified particle component on the given source entity.
--- @param entity Entity Entity to generate particles from
--- @param component Entity.ComponentType Name of the particle-related component on the entity
--- @param extraParams? Particle.Parameters Additional parameters to merge into this particle effect
function Particle.play(entity, component, extraParams) end

--- Returns a table of all active particle effects.
--- @return Particle.Parameters[]
function Particle.getAll() end

return Particle
