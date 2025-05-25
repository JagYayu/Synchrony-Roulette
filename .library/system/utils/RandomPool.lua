--- @meta

local RandomPool = {}

--- @class RandomPool
--- @field count integer Number of non-zero-weight types in the pool
--- @field types any[] List of types to select from. This can be strings, tables, or anything else
--- @field weights integer[] List of weights for selecting types
--- @field seed integer Random seed for this pool
--- @field sum integer Total sum of all weights
--- @field choices any[] List of types chosen so far

--- Initializes a deterministic, lazy-loaded, weighted random choice pool for items or other types.
--- Each type will only be chosen once, with higher weights being more likely to be chosen early.
--- @param seed integer Numeric seed to randomize this pool
--- @param types any[] List of types to select from. This can be strings, tables, or anything else
--- @param weights integer[]? Optional list of weights for selecting types. If omitted, all types have the same weight
--- @return RandomPool
function RandomPool.new(seed, types, weights) end

--- Selects a random type from the specified pool.
--- @param pool RandomPool Pool to select types from
--- @param index integer Incremental index for type selection. MUST be increased by 1 sequentially between calls.
--- @return any
function RandomPool.select(pool, index) end

return RandomPool
