--- @meta

local BeatDelay = {}

--- Returns the number of beats of beat delay remaining for the given entity
--- @param entity Entity Entity to check the beat delay of
--- @return integer delay Number of beats until this entity can act (0 for entities without the `beatDelay` component)
function BeatDelay.getRemaining(entity) end

return BeatDelay
