--- @meta

local ShrineGeneration = {}

--- @class ShrineGeneration.ChoiceArguments
--- @field player? Entity Do not generate shrines that this player can't use (defaults to a random initial player)
--- @field banMask? ItemBan.Flag Ban flag to check on the player for shrine generation, defaults to GENERATE_ITEM_POOL
--- @field shrinePool? Entity.ComponentType Component name to use for weight lookup. If nil, auto-detects by single-zone/all-zones
--- @field requiredComponents? string[] Only generate shrines that have all of those components (use ! for negation)
--- @field shriner? boolean Excludes shrines with unconventional activation methods (Sacrifice, Chance, Pain, etc.)
--- @field multiplayer? boolean If set, forcefully includes/excludes multiplayer-only shrines. If nil, auto-detects by player count
--- @field seenCounts? table<string,integer> Acts as a counter for tracking shrine generation to prevent duplicates, defaults to global counter
--- @field depletionLimit? integer Shrines seen this many times will not be generated
--- @field default? Entity.Type If no shrines match the requirements, this is returned instead

--- @param args ShrineGeneration.ChoiceArguments
--- @return Entity.Type?
function ShrineGeneration.choice(args) end

function ShrineGeneration.getSeenCounts() end

return ShrineGeneration
