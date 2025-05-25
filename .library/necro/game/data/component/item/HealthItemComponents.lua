--- @meta

local HealthItemComponents = {}

--- Increases the holder's maximum health while equipped.
--- @class Component.itemIncreaseMaxHealth
--- @field maxHealth integer # `= 0` 
--- @field healthGained integer # `= 0` 

--- Heals the holder upon first pickup of the item
--- @class Component.itemHealOnFirstPickup
--- @field health integer # `= 0` 
--- @field done boolean # `= false` 

--- Heals the holder upon entering a level
--- @class Component.itemHealOnLevelChange
--- @field health integer # `= 0` 

--- Damages the holder upon picking up the item
--- @class Component.itemDamageOnPickup
--- @field damage integer # `= 0` 
--- @field type Damage.Flag # `= damage.Type.BLOOD` 
--- @field active boolean # `= true` 

--- Grants the holder the ability to overheal from consuming food items
--- @class Component.itemEnableFoodOverheal

--- Consumes the item when its holder overheals with a food item
--- @class Component.itemConsumeOnFoodOverheal

--- Heals the consumer
--- @class Component.consumableHeal
--- @field health integer # `= 0` 
--- @field maxHealth integer # `= 0` 
--- @field cursedHealth integer # `= 0` 
--- @field invincibility integer # `= 1` 
--- @field overheal boolean # `= false` 
--- @field silent boolean # `= false` 
--- @field noParticles boolean # `= false` 

--- Curses some of the consumer's hearts
--- @class Component.consumableCurseHealth
--- @field health integer # `= 0` 

--- Forwards healing gained from this consumable to an attached item stash, if applicable.
--- @class Component.itemHeartContainerStashable

--- Tags the item as "food", allowing its consumption to be affected by food-specific traits (gluttony)
--- @class Component.consumableFood

--- When making a kill with this item equipped, the kill regeneration kill counter is incremented
--- @class Component.itemIncrementRegenerationKillCounter
--- @field increment integer # `= 1` 

--- Causes this item to be automatically consumed when the holder is about to die from damage.
--- If consuming this item heals the holder, this will prevent the death.
--- @class Component.itemConsumeOnLethalHit
--- @field bypassFlags Damage.Flag # `= damage.Flag.BYPASS_DEATH_TRIGGERS` 

--- @class Entity
--- @field itemIncreaseMaxHealth Component.itemIncreaseMaxHealth
--- @field itemHealOnFirstPickup Component.itemHealOnFirstPickup
--- @field itemHealOnLevelChange Component.itemHealOnLevelChange
--- @field itemDamageOnPickup Component.itemDamageOnPickup
--- @field itemEnableFoodOverheal Component.itemEnableFoodOverheal
--- @field itemConsumeOnFoodOverheal Component.itemConsumeOnFoodOverheal
--- @field consumableHeal Component.consumableHeal
--- @field consumableCurseHealth Component.consumableCurseHealth
--- @field itemHeartContainerStashable Component.itemHeartContainerStashable
--- @field consumableFood Component.consumableFood
--- @field itemIncrementRegenerationKillCounter Component.itemIncrementRegenerationKillCounter
--- @field itemConsumeOnLethalHit Component.itemConsumeOnLethalHit

return HealthItemComponents
