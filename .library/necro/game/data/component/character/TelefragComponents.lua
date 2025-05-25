--- @meta

local TelefragComponents = {}

--- Causes a telefrag to happen when this entity teleports onto a `telefraggable` entity.
--- @class Component.telefragger

--- Fires `objectTelefrag` on this entity when a `telefragger` entity teleports to its position.
--- @class Component.telefraggable

--- Inflicts damage to this entity when it is telefragged.
--- @class Component.telefragTakeDamage
--- @field damage integer # `= 999` 
--- @field type Damage.Flag, damage.Flag.mask(damage.Type.PHASING # `= damage.Flag.NO_CREDIT)` 

--- @class Entity
--- @field telefragger Component.telefragger
--- @field telefraggable Component.telefraggable
--- @field telefragTakeDamage Component.telefragTakeDamage

return TelefragComponents
