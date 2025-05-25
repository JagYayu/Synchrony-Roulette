--- @meta

local RhythmItemComponents = {}

--- Specific to heart transplants.
--- @class Component.consumableIgnoreRhythmTemporarily
--- @field duration number # `= 0` 

--- Multiplies the speed of the holder’s beatmap.
--- @class Component.itemRhythmSubdivision
--- @field factor integer # `= 1` 

--- Removes some beats from the holder’s beatmap.
--- @class Component.itemRhythmSkipEveryNth
--- @field n integer # `= 0` 

--- @class Entity
--- @field consumableIgnoreRhythmTemporarily Component.consumableIgnoreRhythmTemporarily
--- @field itemRhythmSubdivision Component.itemRhythmSubdivision
--- @field itemRhythmSkipEveryNth Component.itemRhythmSkipEveryNth

return RhythmItemComponents
