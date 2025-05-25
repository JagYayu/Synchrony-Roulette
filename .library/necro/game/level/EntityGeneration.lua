--- @meta

local EntityGeneration = {}

--- @class EntityGeneration.ChoiceArguments
--- @field player? Entity Do not generate entities that are banned for this player (defaults to a random initial player)
--- @field requiredComponents Entity.Type[] Only generate entities that have all of those components
--- @field chanceFunction? fun(e:Entity,args:any):integer Determines how likely to be generated each entity is
--- @field filter? fun(e:Entity,args:any,player:Entity?):boolean Do not generate entities for which this returns false
--- @field seenCounts? table<Entity.Type,integer> Acts as a counter for tracking entity generation to prevent duplicates, defaults to none
--- @field depletionLimit? integer Entities seen that many time will not be generated, defaults to math.huge
--- @field default? Entity.Type If no entity match the requirements, this is returned instead
--- @field markSeen? boolean Overrides whether this entity should be marked as seen or not (default true)
--- @field randomPool? RandomPool Choice pool instance from which entities will be drawn
--- @field seed integer Random seed for choosing entity types

function EntityGeneration.randomPlayer(channel) end

--- @param args EntityGeneration.ChoiceArguments
--- @return Entity.Type?
function EntityGeneration.choice(args) end

function EntityGeneration.markSeen(entity, count, seenCounts) end

return EntityGeneration
