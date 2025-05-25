--- @meta

local SpellItemComponents = {}

--- Note that components in this file apply to spell **items**, not to actual spells (also known as spellcasts).
--- 
--- Adds a cooldown to this item, requiring the holder to kill a number of enemies before using this item again.
--- Only kills with `SPELL_COOLDOWN` credit count towards this (see `Kill.Credit`).
--- @class Component.spellCooldownKills
--- @field cooldown integer # `= 10` 
--- @field remainingKills integer # `= 0` 

--- Adds a cooldown to this item, requiring the holder to wait a number of beats before using this item again.
--- @class Component.spellCooldownTime
--- @field cooldown integer # `= 10` 
--- @field remainingTurns integer # `= 0` 

--- Displays this item’s cooldowns in the holder’s HUD.
--- @class Component.itemHUDCooldown
--- @field opacity number # `= 0.5` 

--- Allows the holder to use this item again while it is on cooldown, at the cost of some health.
--- @class Component.spellBloodMagic
--- @field damage integer # `= 1` 
--- @field killerName localizedString # `= "Blood Magic"` 

--- Flashes the holder’s screen when this item is used.
--- @class Component.itemScreenFlash

--- Makes all `spellCooldownKills` items of the holder recharge faster.
--- @class Component.itemIncreaseKillSpellCooldownRate
--- @field multiplier integer # `= 1` 

--- Upgrades spells cast using this item.
--- @class Component.spellUpgrade
--- @field upgradeType string # `= ""` 

--- Upgrades spells cast by the holder using any item.
--- @class Component.itemUpgradeSpellCasts
--- @field upgradeType string # `= ""` 

--- Upgrades spells cast by the holder using items in certain slots.
--- @class Component.itemUpgradeSlotSpellCasts
--- @field slots table # Set of affected slot names.
--- @field upgradeType string # `= ""` 

--- Upgrades spells cast by the holder using `spellReusable` items.
--- @class Component.itemUpgradeReusableSpellCasts
--- @field upgradeType string # `= ""` 

--- Marker component (used by `itemUpgradeReusableSpellCasts`).
--- @class Component.spellReusable

--- @class Entity
--- @field spellCooldownKills Component.spellCooldownKills
--- @field spellCooldownTime Component.spellCooldownTime
--- @field itemHUDCooldown Component.itemHUDCooldown
--- @field spellBloodMagic Component.spellBloodMagic
--- @field itemScreenFlash Component.itemScreenFlash
--- @field itemIncreaseKillSpellCooldownRate Component.itemIncreaseKillSpellCooldownRate
--- @field spellUpgrade Component.spellUpgrade
--- @field itemUpgradeSpellCasts Component.itemUpgradeSpellCasts
--- @field itemUpgradeSlotSpellCasts Component.itemUpgradeSlotSpellCasts
--- @field itemUpgradeReusableSpellCasts Component.itemUpgradeReusableSpellCasts
--- @field spellReusable Component.spellReusable

return SpellItemComponents
