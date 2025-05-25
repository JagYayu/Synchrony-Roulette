--- @meta

local Tangibility = {}

--- Force an entity’s tangibility to a specific value.
--- It's usually recommended to use Tangibility.update instead.
function Tangibility.setTangible(entity, tangible) end

--- Recompute an entity’s tangibility.
function Tangibility.update(entity) end

return Tangibility
