--- @meta

local LevelSequence = {}

--- @class LevelSequence
--- @field options LevelGenerator.Options Common options that apply to each level in this sequence
--- @field sequence LevelGenerator.Options[] Per-level options that are merged into the common options when generating

--- @class Event.LevelSequenceUpdate
--- @field options LevelGenerator.Options Output: common options that apply to each level in this sequence
--- @field sequence LevelGenerator.Options[] Output: list of generation parameters to use for each level in this run
--- @field mode GameSession.Mode.Data Game session mode data
--- @field modeID GameSession.Mode Game session mode ID
--- @field runState RunState Current state of the run at the time the sequence is generated
--- @field offset integer The number of levels that have already been completed prior to this level sequence (default 0)
--- @field rng table RNG channel, initialized by the dungeon seed and sequence offset
--- @field characterBitmask PlayableCharacter.ID Bitmask of active playable character IDs / generation traits

function LevelSequence.getZoneCount() end

function LevelSequence.getLength() end

function LevelSequence.getLoopID() end

--- Initializes/updates the level sequence based on the specified parameters.
--- @param args Event.LevelSequenceUpdate Parameters using which to generate the level sequence
--- @return LevelSequence
function LevelSequence.generate(args) end

--- Fully clears the current level sequence
function LevelSequence.reset() end

--- Initializes and uploads the level sequence based on the specified parameters.
--- @param args Event.LevelSequenceUpdate Parameters using which to generate the level sequence
function LevelSequence.update(args) end

--- Retrieves the level sequence entry at the specified index
--- @param index integer Level number to get the generation parameters for
--- @return LevelGenerator.Options entry? Generation parameters for the level at this index, or nil if out of bounds
function LevelSequence.get(index) end

return LevelSequence
