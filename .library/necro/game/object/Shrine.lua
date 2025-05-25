--- @meta

local Shrine = {}

function Shrine.generateItem(args) end

function Shrine.placeItemBelow(item, x, y) end

function Shrine.placeItemNearby(item, x, y) end

--- @param ev table Event parameter for `event.shrine`
--- @param items Entity.Type[] Items to spawn
--- @param _1 any [nodoc] Deprecated
--- @param _2 any [nodoc] Deprecated
function Shrine.singleChoice(ev, items, _1, _2) end

function Shrine.generateShrineItems(entity, interactor, queueType) end

function Shrine.getOrGenerateItems(ev, requiredItemCount, queueType) end

function Shrine.processPainActivation(entity, damageAmount, damageType) end

return Shrine
