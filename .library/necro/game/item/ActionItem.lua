--- @meta

local ActionItem = {}

--- @class ActionItem.VisualSlot
--- @field action Action.Special Action being looked up
--- @field item? Entity Item that was found within the specified slot, or nil if no item is present
--- @field visualItem? Entity Alternate item whose sprite should be rendered instead of the primary item
--- @field container? Entity Optional item that acts as a "storage" for the result item
--- @field hideKeybinding? boolean If true, the key binding text is not rendered under this slot
--- @field slotImage? string Specifies an alternate image file to render for this item slot's frame

function ActionItem.getActionItem(entity, actionID) end

--- Looks up the item and visual slot information associated with the specified action for HUD rendering
--- @param entity Entity Holder entity within which to look up the item
--- @param actionID any Action for which to look up the item
--- @return ActionItem.VisualSlot
function ActionItem.getVisualSlot(entity, actionID) end

function ActionItem.activate(item, holder) end

return ActionItem
