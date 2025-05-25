--- @meta

local ItemComponents = {}

--- Marks this entity as an item, meaning it can be picked up and equipped.
--- 
--- The description of item components usually refers to "the holder", meaning the entity who
--- has equipped this item. While this item is unequipped, those components have no effect.
--- @class Component.item
--- @field holder Entity.ID # The entity whose `inventory` this item is a part of. Protected field! Do not modify directly, use `Inventory.add` or `Inventory.drop` instead.
--- @field dropped boolean # `= true` If true, this item is on the ground. Otherwise, it is part of an entity’s `inventory` or `storage`. (Not equivalent to `holder == 0` because `storage` doesn’t set `holder`).
--- @field equipped boolean # `= false` If true, this item is equipped and providing its effects to the holder. An item can be unequipped even while in an entity’s inventory, typically because that entity can’t use this item (such as Nocturna’s bat-form). Protected field! Do not modify directly, use `Inventory.equip` or `Inventory.drop` instead.
--- @field suppressPickup boolean # `= false` Prevents this item from being picked up or destroyed as long as an `itemCollector` entity is on the same tile.
--- @field singleChoice Entity.ID # When this item is picked up, all other items with the same `singleChoice` value are deleted.

--- Assigns a slot to this item. An inventory can only contain a limited number of items with the same slot.
--- @class Component.itemSlot
--- @field name string # `= ""` 
--- @field priority integer # `= 0` Used to sort items within the same slot.

--- Marks "regular" items, distinguishing them from internal items like deployed familiars.
--- @class Component.itemCommon

--- Allows this item to be sold and determines its price in various currencies.
--- @class Component.itemPrice
--- @field coins integer # `= 0` 
--- @field blood integer # `= 0` 
--- @field diamonds integer # `= 0` 

--- Deletes this item on pickup if the holder already has an identical item in inventory.
--- This behavior can be controlled with the "Item overrides" setting.
--- @class Component.itemOverrideDuplicates

--- Deletes this item on pickup if the holder has another item with the same slot and a higher `tier`.
--- This behavior can be controlled with the "Item overrides" setting.
--- @class Component.itemOverrideLowerTiers
--- @field tier integer # `= 0` 

--- Unequips this item while the holder is intangible, preventing its effects from lingering
--- after the holder dies or spectates. This is normally used on torches and familiars.
--- @class Component.itemRequireTangibleHolder

--- Makes this item tangible while equipped. Items are normally intangible while in an entity’s inventory,
--- regardless of equipped status.
--- @class Component.itemTangibleWhileEquipped

--- Allows this item to be destroyed by spells (such as explosions).
--- @class Component.itemDestructible

--- Drops this item on the ground when its holder dies.
--- @class Component.itemDropOnDeath

--- Marker component indicating that this item can modify the capacity of another item slot.
--- This causes all slot capacities to be re-checked after this item is stashed while switching characters.
--- @class Component.itemCapacityModifier

--- Increases the number of items the holder can have in a given slot.
--- @class Component.itemBag
--- @field actionSlotCapacity integer # `= 1` 
--- @field slotImage string # `= "ext/gui/hud_slot_action2_empty.png"` 

--- Specific to the holster.
--- @class Component.itemHolster
--- @field slot string # `= ""` 
--- @field content Entity.ID # 
--- @field sticky boolean # `= false` Can be temporarily set to prevent items from falling out when dropping the holster.
--- @field slotImage string # `= "ext/gui/hud_slot_weapon2.png"` 
--- @field emptySlotImage string # `= "ext/gui/hud_slot_weapon2_empty.png"` 
--- @field slotLabel localizedString # `= "Holster"` 

--- Plays a sound when this item is picked up.
--- @class Component.itemPickupSound
--- @field sound string # `= "pickupGeneral"` 

--- Plays an animation when this item is picked up, moving it smoothly from the world to the HUD.
--- @class Component.itemPickupAnimation
--- @field factor number # `= 0.8` 
--- @field duration number # `= 0.5` 
--- @field delay number # `= 0` 

--- Similar to `itemPickupAnimation`, but going towards the currency HUD instead of the inventory HUD.
--- @class Component.diamondPickupAnimation
--- @field factor number # `= 0.8` 
--- @field duration number # `= 0.5` 

--- Replaces the HUD icon for activating certain items.
--- @class Component.itemReplaceActionVisual
--- @field mapping table # Maps real item name => visual item name.

--- Makes this item a "stack", treating a single entity as representing any number of identical copies.
--- @class Component.itemStack
--- @field mergeKey string # `= ""` 
--- @field quantity integer # `= 1` 

--- @class Component.itemStackLimitQuantity
--- @field limit integer # `= inventory.INFINITY` 

--- Merges this item with other items in the same inventory.
--- @class Component.itemStackMergeOnPickup

--- Merges this item with other items on the same tile.
--- @class Component.itemStackMergeInWorld

--- Specific to the "Courage duping" quirk.
--- @class Component.itemStackDupable
--- @field active boolean # `= true` 

--- Grants another item to the holder when this item is picked up for the first time.
--- @class Component.itemGrantBonusItem
--- @field type string # `= ""` 
--- @field granted boolean # `= false` 

--- Prevents the holder from picking up other items identical to this one.
--- @class Component.itemBlockDuplicatePickup

--- Tracks whether this item was granted to the holder upon spawning, or was picked up later in the world.
--- @class Component.itemInitial
--- @field active boolean # `= false` 

--- Excludes this item from character switch inventory resets.
--- @class Component.itemPreserveOnCharacterSwitch

--- Prevents this item from being carried over across character switches.
--- @class Component.itemDeleteOnCharacterSwitch

--- Specific to leaping/lunging.
--- @class Component.itemToggleable
--- @field active boolean # `= true` 
--- @field activeSlotImage string # `= "ext/gui/hud_slot_boots.png"` 
--- @field inactiveSlotImage string # `= "ext/gui/hud_slot_boots.png"` 
--- @field slotLabel localizedString # `= "On/off"` 

--- Converts this item to a different type when it is activated.
--- @class Component.itemConvertible
--- @field targetType string # `= ""` 

--- Lets this item be activated by its holder.
--- @class Component.itemActivable
--- @field active boolean # `= false` 
--- @field activeSlotImage string # `= "ext/gui/hud_slot_throw2.png"` 

--- Creates a flyaway when this item is activated.
--- @class Component.itemFlyawayOnActivation
--- @field text string # `= ""` 

--- Keeps track of a "combo", which increases when this item is activated,
--- and resets when the holder performs another action.
--- @class Component.itemComboable
--- @field combo integer # `= 0` 
--- @field reset boolean # `= false` 

--- Deals damage to the holder when this item is activated.
--- @class Component.itemDamageOnActivation
--- @field damage integer # `= 0` 
--- @field type Damage.Flag # `= damage.Type.BLOOD` 

--- Makes the holder hop in place when this item is activated.
--- @class Component.itemHopInPlace

--- Resets the holder’s `damageCountdown` when this item is activated.
--- @class Component.itemResetDamageCountdown
--- @field active boolean # `= true` 

--- Spawns a follower when this item is activated.
--- @class Component.itemSpawnFollower
--- @field type string # `= ""` 

--- Lets the holder pickup single-choice items without deleting other items in the same group.
--- Also lets the holder pickup arena rewards without starting the arena fight.
--- @class Component.itemIgnoreSingleChoice
--- @field ignored Entity.ID # 
--- @field turnID integer # `= 0` 

--- Marker component (used by Need).
--- @class Component.itemBaseDagger

--- Marker component (used by Need).
--- @class Component.itemBaseShovel

--- Marker component (used by Need).
--- @class Component.itemTagPotion

--- Marker component (used by Need).
--- @class Component.itemTagCoupon

--- @class Entity
--- @field item Component.item
--- @field itemSlot Component.itemSlot
--- @field itemCommon Component.itemCommon
--- @field itemPrice Component.itemPrice
--- @field itemOverrideDuplicates Component.itemOverrideDuplicates
--- @field itemOverrideLowerTiers Component.itemOverrideLowerTiers
--- @field itemRequireTangibleHolder Component.itemRequireTangibleHolder
--- @field itemTangibleWhileEquipped Component.itemTangibleWhileEquipped
--- @field itemDestructible Component.itemDestructible
--- @field itemDropOnDeath Component.itemDropOnDeath
--- @field itemCapacityModifier Component.itemCapacityModifier
--- @field itemBag Component.itemBag
--- @field itemHolster Component.itemHolster
--- @field itemPickupSound Component.itemPickupSound
--- @field itemPickupAnimation Component.itemPickupAnimation
--- @field diamondPickupAnimation Component.diamondPickupAnimation
--- @field itemReplaceActionVisual Component.itemReplaceActionVisual
--- @field itemStack Component.itemStack
--- @field itemStackLimitQuantity Component.itemStackLimitQuantity
--- @field itemStackMergeOnPickup Component.itemStackMergeOnPickup
--- @field itemStackMergeInWorld Component.itemStackMergeInWorld
--- @field itemStackDupable Component.itemStackDupable
--- @field itemGrantBonusItem Component.itemGrantBonusItem
--- @field itemBlockDuplicatePickup Component.itemBlockDuplicatePickup
--- @field itemInitial Component.itemInitial
--- @field itemPreserveOnCharacterSwitch Component.itemPreserveOnCharacterSwitch
--- @field itemDeleteOnCharacterSwitch Component.itemDeleteOnCharacterSwitch
--- @field itemToggleable Component.itemToggleable
--- @field itemConvertible Component.itemConvertible
--- @field itemActivable Component.itemActivable
--- @field itemFlyawayOnActivation Component.itemFlyawayOnActivation
--- @field itemComboable Component.itemComboable
--- @field itemDamageOnActivation Component.itemDamageOnActivation
--- @field itemHopInPlace Component.itemHopInPlace
--- @field itemResetDamageCountdown Component.itemResetDamageCountdown
--- @field itemSpawnFollower Component.itemSpawnFollower
--- @field itemIgnoreSingleChoice Component.itemIgnoreSingleChoice
--- @field itemBaseDagger Component.itemBaseDagger
--- @field itemBaseShovel Component.itemBaseShovel
--- @field itemTagPotion Component.itemTagPotion
--- @field itemTagCoupon Component.itemTagCoupon

return ItemComponents
