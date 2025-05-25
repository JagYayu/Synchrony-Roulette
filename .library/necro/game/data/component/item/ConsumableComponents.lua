--- @meta

local ConsumableComponents = {}

--- Consumes the item upon activation from an action slot
--- @class Component.activeItemConsumable

--- Consumes the item immediately upon being picked up
--- @class Component.itemConsumeOnPickup

--- Consumes the item on groove chain loss due to a missed beat
--- @class Component.itemConsumeOnMissedBeat

--- Consumes the item when damage is taken
--- @class Component.itemConsumeOnIncomingDamage
--- @field requiredFlags integer # `= 0` 
--- @field bypassFlags Damage.Flag # `= damage.Flag.SELF_DAMAGE` 

--- Creates a flyaway text when the item is consumed
--- @class Component.consumableFlyaway
--- @field text localizedString # `= 0` 
--- @field textLast localizedString # `= 0` 
--- @field offsetY integer # `= 0` 

--- Drops an item on the ground when consumed
--- @class Component.consumableCreateDroppedItem
--- @field itemType string # `= ""` 

--- Preserves the item on consumption, even if it's the last one in the stack
--- @class Component.consumableAllowEmptyStack

--- Converts this item to another type when it is consumed.
--- @class Component.consumableConvert
--- @field targetType string # `= ""` 

--- Resets the holder’s `damageCountdown` when this item is consumed.
--- @class Component.consumableResetDamageCountdown

--- Specific to heart transplants.
--- @class Component.consumableResetBeatmapAfterDelay
--- @field delay number # `= 0` 

--- @class Entity
--- @field activeItemConsumable Component.activeItemConsumable
--- @field itemConsumeOnPickup Component.itemConsumeOnPickup
--- @field itemConsumeOnMissedBeat Component.itemConsumeOnMissedBeat
--- @field itemConsumeOnIncomingDamage Component.itemConsumeOnIncomingDamage
--- @field consumableFlyaway Component.consumableFlyaway
--- @field consumableCreateDroppedItem Component.consumableCreateDroppedItem
--- @field consumableAllowEmptyStack Component.consumableAllowEmptyStack
--- @field consumableConvert Component.consumableConvert
--- @field consumableResetDamageCountdown Component.consumableResetDamageCountdown
--- @field consumableResetBeatmapAfterDelay Component.consumableResetBeatmapAfterDelay

return ConsumableComponents
