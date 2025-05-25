--- @meta

local Random = {}

--- Reduces the specified random signed 32-bit integer to a smaller range of integers
function Random.limit(value, limit) end

--- 2D pseudo-random noise function
function Random.noise2(x, y, limit) end

--- 3D pseudo-random noise function
--- @return integer
function Random.noise3(x, y, z, limit) end

function Random.float2(x, y) end

--- @param x integer
--- @param y integer
--- @param z integer
--- @return number
function Random.float3(x, y, z) end

--- 2D pseudo-random thresholding function
function Random.threshold2(x, y, threshold) end

--- 3D pseudo-random thresholding function
function Random.threshold3(x, y, z, threshold) end

--- Advances a random number generator's state
function Random.rng3Advance(r1, r2, r3) end

--- Returns a random number based on a generator's state
function Random.rng3Get(r1, r2, r3, limit) end

return Random
