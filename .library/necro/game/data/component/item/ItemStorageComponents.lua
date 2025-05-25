--- @meta

local ItemStorageComponents = {}

--- Keeps track of the container storing this entity.
--- *Not* required for this entity to be storable.
--- @class Component.storable
--- @field container Entity.ID # 

--- Storage container that can hold any type of entity (by numeric ID) or prototype (by type name).
--- @class Component.storage
--- @field items table # List of entity IDs or entity type names (can mix both).

--- Drops the contents of this container when it dies.
--- @class Component.storageDropOnDeath
--- @field offsets table # 
--- @field scatterCollisionMask Collision.Type # `= collision.Type.NONE` 
--- @field bypassFlags integer # `= 0` 
--- @field killCredit Kill.Credit # `= kill.CREDIT_NONE` 
--- @field tweenType MoveAnimations.Type # `= moveAnimations.Type.HOP` 

--- Prevents items dropped by this container from being immediately picked up.
--- @class Component.storageSuppressPickup

--- @class Component.storageConvertNonItemsOnDescent
--- @field replacementType string # `= ""` 

--- Lets this entity’s contents be upgraded by `itemCrateLootUpgrader` items.
--- @class Component.storageContentUpgradeable

--- When this entity is killed, if its contents are banned for the killer, replaces them with something else.
--- @class Component.storageCheckBans
--- @field fallback string # `= ""` 

--- Storage container that allows an entity to temporarily store items without equipping them. By attaching this
--- component to an item, a single entity can hold multiple different types of stashes with their own semantics.
--- @class Component.itemStash

--- Marker component.
--- @class Component.crateLike

--- Marker component.
--- @class Component.chestLike

--- @class Entity
--- @field storable Component.storable
--- @field storage Component.storage
--- @field storageDropOnDeath Component.storageDropOnDeath
--- @field storageSuppressPickup Component.storageSuppressPickup
--- @field storageConvertNonItemsOnDescent Component.storageConvertNonItemsOnDescent
--- @field storageContentUpgradeable Component.storageContentUpgradeable
--- @field storageCheckBans Component.storageCheckBans
--- @field itemStash Component.itemStash
--- @field crateLike Component.crateLike
--- @field chestLike Component.chestLike

return ItemStorageComponents
