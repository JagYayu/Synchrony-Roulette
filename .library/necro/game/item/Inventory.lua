--- @meta

local Inventory = {}

--- @class Event.InventoryAddItem
--- @field item Entity Item entity that should be given
--- @field holder Entity Entity that should receive the item
--- @field deleteDrop boolean|nil Deletes existing items in the slot instead of dropping them
--- @field insertIndex integer|false|nil Overrides the index at which the item should be inserted (`false` for append)
--- @field dropIndex integer|false|nil Overrides the index at which excess items should be dropped

function Inventory.formatQuantity(quantity) end

function Inventory.fireEvent(eventTypeName, parameter) end

function Inventory.findMatchingItemStack(item, holder) end

function Inventory.isCursedSlot(holder, slot, index) end

function Inventory.isSlotReplacable(holder, slot, banMask) end

--- Invokes an `inventoryAddItem` or `inventoryStackItem` event, while allowing control over the event parameters for
--- the non-stacking case. Future versions of this API may also allow overriding stacking parameters.
--- @param args Event.InventoryAddItem Controls how the item is added to the inventory
function Inventory.fireAddEvent(args) end

function Inventory.add(item, holder) end

function Inventory.grant(itemType, holder) end

--- Adds a new item of the specified type to the holder's inventory. If the slot is full, the previous item is destroyed.
--- @param item string|Entity
--- @param holder Entity
--- @return Entity item the newly created item
function Inventory.replace(item, holder) end

--- Adds a new item of the specified type to the holder's inventory.
--- If an item ban prevents the new item from being added, or the current item in that slot
--- from being dropped, nothing happens.
--- @param itemType string
--- @param holder Entity
--- @param gainBanMask? ItemBan.Flag defaults to ItemBan.Flag.GENERATE_SHRINE_FIXED
--- @param lossBanMask? ItemBan.Flag defaults to ItemBan.Flag.LOSS_DROP
--- @return Entity? item the newly created item, or nil if an item ban prevented the operation
function Inventory.grantIfUncursed(itemType, holder, gainBanMask, lossBanMask) end

--- Adds a new item of the specified type to the holder's inventory. If the slot is full, the previous item is destroyed.
--- If an item ban prevents the new item from being added, or the current item in that slot
--- from being deleted, nothing happens.
--- @param itemType string
--- @param holder Entity
--- @param gainBanMask? ItemBan.Flag defaults to ItemBan.Flag.PICKUP
--- @param lossBanMask? ItemBan.Flag defaults to ItemBan.Flag.LOSS_DROP
--- @return Entity? item the newly created item, or nil if an item ban prevented the operation
function Inventory.replaceIfUncursed(itemType, holder, gainBanMask, lossBanMask) end

function Inventory.grantInnate(itemType, holder) end

function Inventory.drop(item, x, y) end

--- Drop all items in the given slot.
--- If keepItems is specified, keep that many of the newest items in that slot.
function Inventory.dropSlot(holder, slot, keepItems) end

function Inventory.equip(item, holder) end

function Inventory.unequip(item, holder) end

--- Unequip all non-equippable items, equip all held and equippable items
function Inventory.updateEquipment(holder) end

function Inventory.scatter(holder, offsets, collisionMask, banFlags) end

function Inventory.clear(holder) end

--- @param holder Entity
--- @return Entity[]
function Inventory.getItems(holder) end

function Inventory.getSlotCapacity(holder, slot) end

function Inventory.hasSlotCapacity(holder, slot, count) end

function Inventory.getItemsInSlot(holder, slot) end

function Inventory.getItemInSlot(holder, slot, index) end

function Inventory.getItemInUncursedSlot(holder, slot, index, banMask) end

function Inventory.swapWithHolster(holder, bag) end

return Inventory
