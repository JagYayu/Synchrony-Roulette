--- @meta

local EquipmentSpriteComponents = {}

--- Lets this entity’s frameY and its head’s frameY be affected by equipped items.
--- @class Component.characterEquipmentSpriteRow
--- @field defaultBodyRow integer # `= 1` 
--- @field defaultHeadRow integer # `= 1` 

--- Changes the holder’s frameY.
--- @class Component.itemArmorBodySpriteRow
--- @field row integer # `= 0` 

--- Changes the holder’s frameY based on this item’s stack size.
--- @class Component.itemStackBodySpriteRow
--- @field maxQuantity integer # `= 0` 

--- Changes the holder’s frameY based on the holder’s grooveChain.
--- @class Component.itemGrooveChainBodySpriteRow
--- @field maxGroove integer # `= 3` 

--- Changes the holder’s head’s frameY.
--- @class Component.itemArmorHeadSpriteRow
--- @field row integer # `= 0` 

--- Changes this item’s sprite while in the HUD.
--- @class Component.itemSpriteHUD
--- @field texture string # `= ""` 
--- @field width integer # `= 24` 
--- @field height integer # `= 24` 
--- @field offsetX number # `= 0` Those two fields don’t actually do anything, but they’re needed by Character.setDynamicSprite. To set a HUD-specific sprite offset, use itemSpriteOffsetHUD.
--- @field offsetY number # `= 0` 

--- Changes this item’s sprite offset while in the HUD.
--- @class Component.itemSpriteOffsetHUD
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 

--- Adds a secondary HUD sprite underneath this item’s sprite.
--- @class Component.itemOverlaySpriteHUD
--- @field texture string # `= ""` 
--- @field width number # `= 0` 
--- @field height number # `= 0` 
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field active boolean # `= false` The secondary sprite is only displayed if this is true.

--- Enables this item’s `itemOverlaySpriteHUD` as long as its `itemConditionalDamageIncrease` is active.
--- @class Component.weaponOverlaySpriteOnConditionalDamage

--- Resets this entity’s frameX before applying visual updates.
--- All components that add to frameX should declare this as a dependency.
--- @class Component.spriteSheetReset
--- @field frameX integer # `= 1` 

--- Changes this item’s frameX based on its remaining ammo (requires `weaponReloadable`).
--- @class Component.weaponReloadableAmmoSprite
--- @field frameXOffsets table # Maps ammo count => frame offset. frameXOffsets[0] is optional, defaults to 0.
--- @field whileDropped boolean # `= true` If false, this item uses its base sprite while dropped, regardless of ammo count.

--- Changes this item’s frameX based on its combo count (requires `itemComboable`).
--- @class Component.itemSpriteChangeOnCombo
--- @field frameXOffsets table # Maps combo count => frame offset. frameXOffsets[0] is optional, defaults to 0.
--- @field loop boolean # `= false` Determines which frameX to use once the combo count exceeds the length of the frame list. If true, wrap back to the beginning (ABCABC…). If false, keep using the last frame (ABCCCC…).

--- Changes this item’s frameX based on whether `itemConditionalDamageIncrease` is active.
--- @class Component.itemSpriteChangeOnConditionalDamage
--- @field frameXOffset integer # `= 1` 

--- Changes this item’s frameX based on its holder’s groove chain.
--- @class Component.itemHolderGrooveChainSprite
--- @field frameXOffset integer # `= 1` 
--- @field maxGroove integer # `= 3` 

--- Changes this item’s frameX based on its stack size.
--- @class Component.itemStackSprite
--- @field frameXOffset integer # `= 1` 
--- @field minQuantity integer # `= 1` Stack sizes less than this do not affect frameX.
--- @field maxQuantity integer # `= 3` Stack sizes equal to or greater than this do not affect frameX.

--- @class Entity
--- @field characterEquipmentSpriteRow Component.characterEquipmentSpriteRow
--- @field itemArmorBodySpriteRow Component.itemArmorBodySpriteRow
--- @field itemStackBodySpriteRow Component.itemStackBodySpriteRow
--- @field itemGrooveChainBodySpriteRow Component.itemGrooveChainBodySpriteRow
--- @field itemArmorHeadSpriteRow Component.itemArmorHeadSpriteRow
--- @field itemSpriteHUD Component.itemSpriteHUD
--- @field itemSpriteOffsetHUD Component.itemSpriteOffsetHUD
--- @field itemOverlaySpriteHUD Component.itemOverlaySpriteHUD
--- @field weaponOverlaySpriteOnConditionalDamage Component.weaponOverlaySpriteOnConditionalDamage
--- @field spriteSheetReset Component.spriteSheetReset
--- @field weaponReloadableAmmoSprite Component.weaponReloadableAmmoSprite
--- @field itemSpriteChangeOnCombo Component.itemSpriteChangeOnCombo
--- @field itemSpriteChangeOnConditionalDamage Component.itemSpriteChangeOnConditionalDamage
--- @field itemHolderGrooveChainSprite Component.itemHolderGrooveChainSprite
--- @field itemStackSprite Component.itemStackSprite

return EquipmentSpriteComponents
