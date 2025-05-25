--- @meta

local SoulLinkComponents = {}

--- @class Component.soulLinkable

--- @class Component.soulLink
--- @field target Entity.ID # 
--- @field locked boolean # `= false` 

--- @class Component.soulLinkFocus
--- @field flags Focus.Flag # `= focus.Flag.CAMERA` 
--- @field forward Entity.ID # 

--- @class Component.soulLinkTravel

--- @class Component.soulLinkCurrency
--- @field type string # `= currency.Type.GOLD` 
--- @field synced boolean # `= false` 

--- @class Component.soulLinkGrooveChain

--- @class Component.soulLinkInventory
--- @field slots table # 

--- @class Component.soulLinkInventoryHUD
--- @field elements table # 

--- @class Component.soulLinkHealth
--- @field synced boolean # `= false` 
--- @field multiplier number # `= 1` 

--- @class Component.soulLinkHealthLimit
--- @field limit integer # `= 20` 

--- @class Component.soulLinkSpellcasts

--- @class Component.soulLinkKillCredit
--- @field mask Kill.Credit # `= kill.CREDIT_ALL` 

--- @class Component.soulLinkCollision
--- @field add integer # `= 0` 

--- @class Entity
--- @field soulLinkable Component.soulLinkable
--- @field soulLink Component.soulLink
--- @field soulLinkFocus Component.soulLinkFocus
--- @field soulLinkTravel Component.soulLinkTravel
--- @field soulLinkCurrency Component.soulLinkCurrency
--- @field soulLinkGrooveChain Component.soulLinkGrooveChain
--- @field soulLinkInventory Component.soulLinkInventory
--- @field soulLinkInventoryHUD Component.soulLinkInventoryHUD
--- @field soulLinkHealth Component.soulLinkHealth
--- @field soulLinkHealthLimit Component.soulLinkHealthLimit
--- @field soulLinkSpellcasts Component.soulLinkSpellcasts
--- @field soulLinkKillCredit Component.soulLinkKillCredit
--- @field soulLinkCollision Component.soulLinkCollision

return SoulLinkComponents
