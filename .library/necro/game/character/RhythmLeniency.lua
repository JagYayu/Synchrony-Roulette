--- @meta

local RhythmLeniency = {}

--- Checks if the entity is currently under the effects of rhythm leniency
--- @param entity Entity? Entity to check rhythm leniency for
--- @return boolean
function RhythmLeniency.isActive(entity) end

--- Grants temporary rhythm leniency to this entity. If the entity already has leniency, the timer is refreshed, but not
--- stacked additively. Does nothing for entities without the `rhythmLeniency` component
--- @param entity Entity? Entity to grant leniency to
--- @param turns integer? Number of turns to grant leniency for (defaults to 2)
function RhythmLeniency.activate(entity, turns) end

return RhythmLeniency
