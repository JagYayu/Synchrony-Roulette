--- @meta

local SlideComponents = {}

--- Allows this entity to slide.
--- While this entity is sliding, it is forced to keep moving in the same direction.
--- @class Component.slide
--- @field direction integer # `= 0` 
--- @field moveType Move.Flag # `= move.Type.SLIDE` 

--- Makes this entity start sliding when it steps on ice.
--- @class Component.slideOnSlipperyTile
--- @field collisionMask Collision.Type # `= collision.Group.SOLID` 

--- Changes the timing of slide moves (player-controlled only).
--- @class Component.slideRhythmAutoPlay

--- Allows this entity to perform special actions while sliding (player-controlled only).
--- @class Component.slideSubBeatActions
--- @field active boolean # `= false` 

--- Prevents this entity from performing directional actions while sliding (player-controlled only).
--- @class Component.slideIgnoreActions
--- @field actions table # Set of ignored directional actions. By default, this includes all directional actions.

--- @class Entity
--- @field slide Component.slide
--- @field slideOnSlipperyTile Component.slideOnSlipperyTile
--- @field slideRhythmAutoPlay Component.slideRhythmAutoPlay
--- @field slideSubBeatActions Component.slideSubBeatActions
--- @field slideIgnoreActions Component.slideIgnoreActions

return SlideComponents
