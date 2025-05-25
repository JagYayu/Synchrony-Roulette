--- @meta

local AffectorItemComponents = {}

--- Deletes all spirits when picked up, then prevents them from spawning while equipped.
--- @class Component.itemDeleteApparitions

--- At the start of each floor, removes some enemies.
--- @class Component.itemPeace
--- @field removedEnemies integer # `= 8` 

--- Lowers the effect of `innatePeace`.
--- @class Component.itemWar

--- Sets a run-state flag. Those can impact level generation in various ways.
--- @class Component.itemSetRunFlag
--- @field name string # `= ""` See `RunState.Attribute` for a list of possible values.

--- Makes Shrine of Chance work every time for the holder.
--- @class Component.itemLuck

--- Modifies the contents of crates opened by the holder.
--- @class Component.itemCrateLootUpgrader
--- @field upgrades table # Maps base item name => upgraded item name.

--- Can open locked chests, locked doors, and NPC cages.
--- @class Component.itemKey
--- @field type integer # `= 0` Only locks matching this key type can be opened.

--- Breaks low% status when picked up.
--- @class Component.itemNegateLowPercent
--- @field active boolean # `= true` 

--- @class Entity
--- @field itemDeleteApparitions Component.itemDeleteApparitions
--- @field itemPeace Component.itemPeace
--- @field itemWar Component.itemWar
--- @field itemSetRunFlag Component.itemSetRunFlag
--- @field itemLuck Component.itemLuck
--- @field itemCrateLootUpgrader Component.itemCrateLootUpgrader
--- @field itemKey Component.itemKey
--- @field itemNegateLowPercent Component.itemNegateLowPercent

return AffectorItemComponents
