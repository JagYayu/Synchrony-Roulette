--- @meta

local SpellTargetingComponents = {}

--- Moves the reference tile for this spell by a given distance in this spell’s direction.
--- Other spell targeting components will rely on the new position (for example, it’ll be the
--- center of the circle for `spellcastRadial`).
--- @class Component.spellcastDirectionalOffset
--- @field distance integer # `= 0` 

--- Targets only the caster.
--- @class Component.spellcastTargetCaster

--- Prevents this spell from targeting more than one entity.
--- @class Component.spellcastSingleTarget
--- @field attackFlags Attack.Flag # `= attack.Flag.CHARACTER` 

--- Targets the caster’s `homeArea`.
--- @class Component.spellcastTargetHome
--- @field outset integer # `= 0` 

--- Targets a specific list of tiles, relative to the casting tile and direction.
--- @class Component.spellcastTargetTiles
--- @field offsets table # List of {x, y} offsets. Those offsets are rotated using the same logic as weapon patterns.

--- Targets a straight line, stopping at obstacles.
--- @class Component.spellcastLinear
--- @field collisionMask Collision.Type # `= collision.Group.WEAPON_CLEARANCE` 
--- @field minDistance integer # `= 1` Inclusive minimum L∞ distance.
--- @field maxDistance integer # `= 100` Inclusive maximum L∞ distance.
--- @field singleTarget integer # `= 0` 
--- @field extraSwipeTile boolean # `= false` 

--- Targets a straight line, stopping at obstacles.
--- @class Component.spellcastBilinear
--- @field collisionMask Collision.Type # `= collision.Group.WEAPON_CLEARANCE` 
--- @field minDistance integer # `= 1` Inclusive minimum L∞ distance.
--- @field maxDistance integer # `= 100` Inclusive maximum L∞ distance.
--- @field singleTarget integer # `= 0` 
--- @field extraSwipeTile boolean # `= false` 

--- Targets a rectangle.
--- @class Component.spellcastRectangular
--- @field offsetX integer # `= 0` 
--- @field offsetY integer # `= 0` 
--- @field width integer # `= 1` 
--- @field height integer # `= 1` 

--- Targets a cone.
--- @class Component.spellcastCone
--- @field distance number # `= 0` L2 distance from the tip of the cone to the middle of the opposite end.

--- Targets a circle (or a ring).
--- @class Component.spellcastRadial
--- @field radius number # `= 0` Inclusive maximum L2 distance.
--- @field minDistance number # `= 0` Inclusive minimum L2 distance.

--- Targets the entire map.
--- @class Component.spellcastGlobal

--- Prevents this spell from targeting tiles with a given collision mask.
--- @class Component.spellcastIgnoreTiles
--- @field collisionMask integer # `= 0` 

--- Prevents this entity from counting as a target (used by tombstones).
--- @class Component.excludeFromSpellTargetCount

--- @class Entity
--- @field spellcastDirectionalOffset Component.spellcastDirectionalOffset
--- @field spellcastTargetCaster Component.spellcastTargetCaster
--- @field spellcastSingleTarget Component.spellcastSingleTarget
--- @field spellcastTargetHome Component.spellcastTargetHome
--- @field spellcastTargetTiles Component.spellcastTargetTiles
--- @field spellcastLinear Component.spellcastLinear
--- @field spellcastBilinear Component.spellcastBilinear
--- @field spellcastRectangular Component.spellcastRectangular
--- @field spellcastCone Component.spellcastCone
--- @field spellcastRadial Component.spellcastRadial
--- @field spellcastGlobal Component.spellcastGlobal
--- @field spellcastIgnoreTiles Component.spellcastIgnoreTiles
--- @field excludeFromSpellTargetCount Component.excludeFromSpellTargetCount

return SpellTargetingComponents
