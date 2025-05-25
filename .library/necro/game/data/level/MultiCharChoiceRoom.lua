--- @meta

local MultiCharChoiceRoom = {}

--- @class LevelGenerator.Options.MultiCharChoiceRoom : LevelGenerator.Options
--- @field choosableCharacters? string[] List of all characters that can be chosen in this run
--- @field lockedCharacters? string[] List of characters that have already been chosen
--- @field columns? integer Number of staircases in each row of the selection room

function MultiCharChoiceRoom.getName(options) end

return MultiCharChoiceRoom
