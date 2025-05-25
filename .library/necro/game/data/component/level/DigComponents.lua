--- @meta

local DigComponents = {}

--- Lets this entity dig walls.
--- @class Component.dig
--- @field strength Dig.Strength # `= dig.Strength.DEFAULT` 
--- @field silentFail boolean # `= false` If true, no sound is played when this entity fails to dig.
--- @field innateShovel boolean # `= false` If true, sets the `shovel` flag on dig events, which affects some interactions (notably Z4 walls).
--- @field isPlayer boolean # `= false` If true, sets the `player` flag on dig events, which allows Z5 dirt walls to regrow.

--- Lets this entity dig when a multi-tile move is interrupted midway by a wall.
--- @class Component.digOnPartialMove
--- @field strength Dig.Strength # `= dig.Strength.DEFAULT` 

--- Prevents gold drops from shop walls dug by this entity.
--- @class Component.wallDropSuppressor
--- @field active boolean # `= true` 

--- Prevents gold drops from shop walls destroyed by bombs placed by the holder (used by ∞Bomb).
--- @class Component.wallDropSuppressorEnabler

--- @class Entity
--- @field dig Component.dig
--- @field digOnPartialMove Component.digOnPartialMove
--- @field wallDropSuppressor Component.wallDropSuppressor
--- @field wallDropSuppressorEnabler Component.wallDropSuppressorEnabler

return DigComponents
