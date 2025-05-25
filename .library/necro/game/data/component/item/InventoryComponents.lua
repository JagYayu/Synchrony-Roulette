--- @meta

local InventoryComponents = {}

--- Allows this entity to carry items, and keeps track of those items.
--- @class Component.inventory
--- @field items table # List of entity IDs of carried items. Protected field! Do not modify directly, use `Inventory.add` and `Inventory.drop` instead.
--- @field itemSlots table # Maps slot name => list of entity IDs of items in that slot.

--- Grants some items to this entity when it spawns.
--- @class Component.initialInventory
--- @field items table # List of item names.
--- @field pending boolean # `= true` 

--- @class Component.initialInventoryRestoreSlotsOnRespawn
--- @field slots table # 

--- Partitions item slots so that drop-banned items are always placed before swappable items (most notably spells)
--- @class Component.inventoryForceSlotOrder
--- @field slots table # 

--- Makes this entity able to equip items and benefit from their effects.
--- @class Component.equipment
--- @field items table # List of entity IDs of equipped items. Protected field! Do not modify directly, use `Inventory.equip` and `Inventory.unequip` instead.

--- Makes the entity attempt to equip all items in its inventory.
--- @class Component.itemUser

--- Makes the entity attempt to equip items in specific slots of its inventory.
--- @class Component.itemSlotUser
--- @field slots table # Set of slot names.

--- Makes this entity pickup items on its tile.
--- @class Component.itemCollector
--- @field pickupLimit integer # `= -1` Maximum number of items this entity can pick up in a turn. -1 = unlimited.

--- Allows this entity to receive extra items from `itemGrantBonusItem`.
--- @class Component.bonusItemReceiver
--- @field received table # 

--- @class Entity
--- @field inventory Component.inventory
--- @field initialInventory Component.initialInventory
--- @field initialInventoryRestoreSlotsOnRespawn Component.initialInventoryRestoreSlotsOnRespawn
--- @field inventoryForceSlotOrder Component.inventoryForceSlotOrder
--- @field equipment Component.equipment
--- @field itemUser Component.itemUser
--- @field itemSlotUser Component.itemSlotUser
--- @field itemCollector Component.itemCollector
--- @field bonusItemReceiver Component.bonusItemReceiver

return InventoryComponents
