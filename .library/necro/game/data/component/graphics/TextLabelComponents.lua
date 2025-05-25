--- @meta

local TextLabelComponents = {}

--- @alias localizedString string

--- Spawns a flyaway displaying the item's friendly name on pickup
--- @class Component.itemPickupFlyaway

--- Changes the item's pickup flyaway text independently of its friendly name
--- @class Component.itemPickupFlyawayOverride
--- @field text localizedString # `= nil, "flyaway"` 

--- @class Component.itemStackQuantityLabelWorld
--- @field minimumQuantity integer # `= 0` 
--- @field offsetX number # `= 0` Offset from the right of the item’s sprite to the center of the label
--- @field offsetY number # `= 0` Offset from the bottom of the item’s sprite to the bottom of the label

--- @class Component.priceTagLabel
--- @field offsetX number # `= 1` Offset from the horizontal center of the tile to the center of the label
--- @field offsetY number # `= 8` Offset from the vertical center of the tile to the bottom of the label

--- Added to the priceTagLabel offset for this sale entity’s priceTag
--- @class Component.salePriceTagOffset
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 

--- @class Component.priceTagLabelInlineImage
--- @field costMultiplier number # `= 1` 
--- @field texture string # `= ""` 

--- Creates a flyaway when this price tag fails to be paid.
--- @class Component.priceTagUnaffordableFlyaway
--- @field text localizedString # `= "Can't afford!"` 

--- Creates a flyaway when this price tag is successfully paid.
--- @class Component.priceTagSuccessFlyaway
--- @field text localizedString # `= "Success!"` 

--- @class Component.damageCountdownFlyaways
--- @field texts table # Maps number of turns left to live => flyaway text

--- @class Component.itemHintLabel
--- @field text localizedString # `= nil, "hint"` 
--- @field offsetY number # `= -26` Offset from the center of the tile to the bottom-center of the label (offsetX is hardcoded to 0)

--- @class Component.itemHintLabelRebalanced
--- @field text localizedString # `= nil, "hintDLC"` Alternate item hint when balance-affecting DLC is enabled (gets a unique translation key)

--- @class Component.shrineHintLabel
--- @field visible boolean # `= true` 
--- @field text localizedString # `= nil, "shrineHint"` 
--- @field offsetY number # `= 14` Offset from the center of the tile to the bottom-center of the label (offsetX is hardcoded to 0)
--- @field offsetTopY number # `= -23` Alternative offset used when a player is immediately below the shrine

--- Hides the shrine's hint label after the shrine has been activated
--- @class Component.shrineHintLabelHideAfterActivation

--- @class Component.secretShopLabel
--- @field text localizedString # `= 0` 
--- @field offsetX integer # `= 0` Offset from the center of the tile to the bottom-center of the label
--- @field offsetY integer # `= 0` 
--- @field visible boolean # `= true` 

--- @class Component.worldLabel
--- @field text string # `= ""` 
--- @field offsetX integer # `= 0` Offset from the center of the tile to the bottom-center of the label
--- @field offsetY integer # `= -15` 
--- @field offsetZ integer # `= -48` 
--- @field spacingY integer # `= 0` 
--- @field alignY number # `= 1` 

--- @class Component.worldLabelMaxWidth
--- @field width number # `= 50` 
--- @field force boolean

--- @class Component.worldLabelBlink
--- @field maxDistance integer # `= 9` squared distance

--- @class Component.worldLabelFade
--- @field maxDistance number # `= 5` squared distance
--- @field falloff number # `= 0.1` 
--- @field factor number # `= 1` 

--- @class Component.worldLabelHideNearFlyaway

--- Hides the label if a menu is currently open
--- @class Component.worldLabelHideDuringMenu

--- Hides the label if a text visibility option is disabled
--- @class Component.worldLabelVisibleBySetting
--- @field option TextLabelRenderer.VisibilityOption # `= textLabelRenderer.VisibilityOption.INTRO_TEXT` 

--- Performs a text pool lookup to determine this label's text
--- @class Component.worldLabelTextPool
--- @field key string # `= ""` 

--- Appends a second line to this label via text pool
--- @class Component.worldLabelTextPoolAppend
--- @field key string # `= ""` 

--- Converts underscores to underlines
--- @class Component.worldLabelApplyFormatting

--- Colorizes the text of this world label
--- @class Component.worldLabelTextColor
--- @field active boolean # `= true` 
--- @field color integer # `= color.WHITE` 

--- Looks up a input binding to determine this label's text
--- @class Component.worldLabelInputBinding
--- @field key string # `= ""` Localization key to look up
--- @field controllerKey string # `= ""` Alternate localization key to look up when using a controller
--- @field binding string # `= ""` Specifies the enum key of the action/misc key binding to look up

--- Looks up a string within another entity type to determine this label's text
--- @class Component.worldLabelEntityLookup
--- @field type string # `= ""` Entity type to perform the lookup with
--- @field component string # `= ""` Component name to look up
--- @field field string # `= ""` Field name to look up

--- Looks up the character-specific statistics and appends them to the label
--- @class Component.worldLabelCharacterStats
--- @field type string # `= ""` Character type to perform the lookup for

--- Looks up the description of an extra mode
--- @class Component.worldLabelExtraModeIndicator
--- @field modeID integer # `= 0` 

--- Controls whether the name above a playable character is visible. If absent, the name is always visible
--- @class Component.playerNameVisibility
--- @field visible boolean # `= true` 

--- @class Entity
--- @field itemPickupFlyaway Component.itemPickupFlyaway
--- @field itemPickupFlyawayOverride Component.itemPickupFlyawayOverride
--- @field itemStackQuantityLabelWorld Component.itemStackQuantityLabelWorld
--- @field priceTagLabel Component.priceTagLabel
--- @field salePriceTagOffset Component.salePriceTagOffset
--- @field priceTagLabelInlineImage Component.priceTagLabelInlineImage
--- @field priceTagUnaffordableFlyaway Component.priceTagUnaffordableFlyaway
--- @field priceTagSuccessFlyaway Component.priceTagSuccessFlyaway
--- @field damageCountdownFlyaways Component.damageCountdownFlyaways
--- @field itemHintLabel Component.itemHintLabel
--- @field itemHintLabelRebalanced Component.itemHintLabelRebalanced
--- @field shrineHintLabel Component.shrineHintLabel
--- @field shrineHintLabelHideAfterActivation Component.shrineHintLabelHideAfterActivation
--- @field secretShopLabel Component.secretShopLabel
--- @field worldLabel Component.worldLabel
--- @field worldLabelMaxWidth Component.worldLabelMaxWidth
--- @field worldLabelBlink Component.worldLabelBlink
--- @field worldLabelFade Component.worldLabelFade
--- @field worldLabelHideNearFlyaway Component.worldLabelHideNearFlyaway
--- @field worldLabelHideDuringMenu Component.worldLabelHideDuringMenu
--- @field worldLabelVisibleBySetting Component.worldLabelVisibleBySetting
--- @field worldLabelTextPool Component.worldLabelTextPool
--- @field worldLabelTextPoolAppend Component.worldLabelTextPoolAppend
--- @field worldLabelApplyFormatting Component.worldLabelApplyFormatting
--- @field worldLabelTextColor Component.worldLabelTextColor
--- @field worldLabelInputBinding Component.worldLabelInputBinding
--- @field worldLabelEntityLookup Component.worldLabelEntityLookup
--- @field worldLabelCharacterStats Component.worldLabelCharacterStats
--- @field worldLabelExtraModeIndicator Component.worldLabelExtraModeIndicator
--- @field playerNameVisibility Component.playerNameVisibility

return TextLabelComponents
