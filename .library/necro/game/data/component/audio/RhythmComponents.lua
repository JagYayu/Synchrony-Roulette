--- @meta

local RhythmComponents = {}

--- Allows this entity to act at any time, regardless of its beatmap.
--- @class Component.rhythmIgnored

--- Makes heart transplants work.
--- @class Component.rhythmIgnoredTemporarily
--- @field endTime number # `= -1` 
--- @field active boolean # `= false` 

--- Adds some beats to this entity’s beatmap.
--- @class Component.rhythmSubdivision
--- @field factor integer # `= 1` 

--- Removes some beats from this entity’s beatmap.
--- @class Component.rhythmSkipEveryNth
--- @field n integer # `= 0` 

--- Status effect. Grants temporary immunity to missed beats caused by early inputs.
--- Granted by level transitions, ND boss music change, unspectating, Heart Transplant end and Berserk Spell end.
--- @class Component.rhythmLeniency
--- @field remainingTurns integer # `= 0` 
--- @field permanent boolean # `= false` 

--- Grants temporary rhythm leniency when entering a level.
--- @class Component.rhythmLeniencyOnLevelStart
--- @field turns integer # `= 2` 

--- Grants temporary rhythm leniency when leaving spectator mode.
--- @class Component.rhythmLeniencyOnUnspectate
--- @field turns integer # `= 2` 

--- Casts a spell when a non-looping song ends.
--- @class Component.songEndCast
--- @field spell string # `= ""` 

--- @class Entity
--- @field rhythmIgnored Component.rhythmIgnored
--- @field rhythmIgnoredTemporarily Component.rhythmIgnoredTemporarily
--- @field rhythmSubdivision Component.rhythmSubdivision
--- @field rhythmSkipEveryNth Component.rhythmSkipEveryNth
--- @field rhythmLeniency Component.rhythmLeniency
--- @field rhythmLeniencyOnLevelStart Component.rhythmLeniencyOnLevelStart
--- @field rhythmLeniencyOnUnspectate Component.rhythmLeniencyOnUnspectate
--- @field songEndCast Component.songEndCast

return RhythmComponents
