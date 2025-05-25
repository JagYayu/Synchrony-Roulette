--- @meta

local HUDComponents = {}

--- Allows displaying text over the entire HUD for this entity (like the "Song ended!" text).
--- @class Component.hudTextOverlay
--- @field text string # `= ""` 

--- Hides some items from this entity’s HUD.
--- @class Component.hudHideSlots
--- @field hidden table # Set of hidden HUD slots. Keys in this table can be either item slot names (to hide items from the "equipment" HUD) or `Action.Special` values (to hide items from the "action" HUD).

--- Changes the opacity of all unequipped items in this entity’s HUD.
--- @class Component.inventoryHUDUnequippedItemOpacity
--- @field opacity number # `= 0.3` 

--- Causes the player list to show this entity’s head sprite instead of its body.
--- @class Component.hudPlayerListUseAttachmentSprite

--- Displays this item’s stack size over its HUD sprite (requires `itemStack`).
--- @class Component.itemStackQuantityLabelHUD
--- @field offsetX number # `= -2` Offset from the bottom-right of the HUD slot to where the bottom-center of the label would be if it was using a monospaced font (bottom-left + 2px to the right per character)
--- @field offsetY number # `= -2` 
--- @field digitOffsetX number # `= -2` 
--- @field minimumQuantity integer # `= 0` 

--- Displays text over this item’s HUD sprite while it is active (requires `itemActivable`).
--- @class Component.itemActivablePromptHUD
--- @field text localizedString # `= "Press arrow key to throw"` 
--- @field opacity number # `= 0.6` 
--- @field offsetX number # `= 1` 
--- @field offsetY number # `= 2` 

--- Stops `itemActivablePromptHUD` from hiding the keybinding for this item in the HUD.
--- @class Component.itemActivableShowSlotLabelHUD

--- Displays this item’s ammo count over its HUD sprite (requires `weaponReloadable`).
--- @class Component.weaponAmmoCounterHUD
--- @field alignX number # `= 0.5` 
--- @field alignY number # `= 1` 
--- @field offsetX number # `= 0` Offset from a point (by default, bottom-center) of the HUD slot to the corresponding point of the label. alignX and alignY affect the reference point (0,0 is top-left; 1,1 is bottom-right)
--- @field offsetY number # `= 0` 

--- Displays the number of kills required until the next `regenerationKillCounter` heal for the holder,
--- over this item’s HUD sprite.
--- @class Component.itemRegenerationKillCounterHUD
--- @field offsetX number # `= 0` Offset from the bottom-center of the HUD slot to the bottom-center of the label
--- @field offsetY number # `= 0` 

--- Displays the number of kills required until the next `regenerationKillCounter` heal for this entity,
--- over the HUD sprite for any weapon held by this entity.
--- @class Component.hudRegenerationKillCounter
--- @field offsetX number # `= 0` Offset from the bottom-center of the HUD slot to the bottom-center of the label
--- @field offsetY number # `= 0` 

--- Displays items in this entity's equipment HUD slots, without actually being present in the inventory
--- @class Component.inventoryVirtualEquipmentHUD
--- @field slots table # Mapping from slot to item type name

--- Displays items in this entity's action HUD slots, without actually being present in the inventory
--- @class Component.inventoryVirtualActionHUD
--- @field actions table # Mapping from action to item type name

--- Displays the contents of an item stash in the holder's HUD.
--- @class Component.itemStashHUD

--- Indicates the holder's autoCast cooldown in the HUD
--- @class Component.virtualItemAutoCastCooldownHUD
--- @field opacity number # `= 0.5` 

--- Indicates the holder's beat delay cooldown in the HUD
--- @class Component.virtualItemBeatDelayCooldownHUD
--- @field opacity number # `= 0.5` 

--- Modifies the item's opacity in the HUD depending on the holder's stasis
--- @class Component.virtualItemStasisOpacityHUD
--- @field opacity number # `= 0.5` 

--- Rotates the item's sprite in the HUD according to the holder's innate spell's direction
--- @class Component.virtualItemInnateSpellDirectionalHUD

--- Hides the item's key binding in the HUD
--- @class Component.virtualItemHideKeyBindingHUD

--- Displays the item at a different scale factor in the HUD
--- @class Component.itemSpriteScaleHUD
--- @field scale number # `= 1` 

--- @class Entity
--- @field hudTextOverlay Component.hudTextOverlay
--- @field hudHideSlots Component.hudHideSlots
--- @field inventoryHUDUnequippedItemOpacity Component.inventoryHUDUnequippedItemOpacity
--- @field hudPlayerListUseAttachmentSprite Component.hudPlayerListUseAttachmentSprite
--- @field itemStackQuantityLabelHUD Component.itemStackQuantityLabelHUD
--- @field itemActivablePromptHUD Component.itemActivablePromptHUD
--- @field itemActivableShowSlotLabelHUD Component.itemActivableShowSlotLabelHUD
--- @field weaponAmmoCounterHUD Component.weaponAmmoCounterHUD
--- @field itemRegenerationKillCounterHUD Component.itemRegenerationKillCounterHUD
--- @field hudRegenerationKillCounter Component.hudRegenerationKillCounter
--- @field inventoryVirtualEquipmentHUD Component.inventoryVirtualEquipmentHUD
--- @field inventoryVirtualActionHUD Component.inventoryVirtualActionHUD
--- @field itemStashHUD Component.itemStashHUD
--- @field virtualItemAutoCastCooldownHUD Component.virtualItemAutoCastCooldownHUD
--- @field virtualItemBeatDelayCooldownHUD Component.virtualItemBeatDelayCooldownHUD
--- @field virtualItemStasisOpacityHUD Component.virtualItemStasisOpacityHUD
--- @field virtualItemInnateSpellDirectionalHUD Component.virtualItemInnateSpellDirectionalHUD
--- @field virtualItemHideKeyBindingHUD Component.virtualItemHideKeyBindingHUD
--- @field itemSpriteScaleHUD Component.itemSpriteScaleHUD

return HUDComponents
