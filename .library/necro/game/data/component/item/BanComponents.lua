--- @meta

local BanComponents = {}

--- Bans all items in given slots, using the same ban flags for all slots.
--- If individual flags are needed for each slot, use `inventoryBannedItemSlots` instead.
--- @class Component.inventoryCursedSlots
--- @field slots table # Set of slot names.
--- @field banFlags ItemBan.Flag # `= itemBan.Type.LOCK` Ban flags to apply to all slots.

--- Bans all items in given slots.
--- @class Component.inventoryBannedItemSlots
--- @field slots table # Maps slot name => ban flags for all items in that slot.

--- Bans all items having given components.
--- @class Component.inventoryBannedItems
--- @field components table # Maps component name => ban flags for all items having that component.

--- Bans specific items by name.
--- @class Component.inventoryBannedItemTypes
--- @field types table # Maps item name => ban flags for that item.

--- Prevents this entity from picking up banned undroppable items (charms, heart containers, …)
--- @class Component.inventoryUndroppableBan
--- @field requiredFlags ItemBan.Flag # `= itemBan.Flag.GENERATE_ITEM_POOL` 
--- @field addedFlags ItemBan.Flag # `= itemBan.Flag.PICKUP` 

--- Damages this entity when it picks up an item with the `PICKUP_DEATH` ban flag (see `ItemBan.Flag`).
--- @class Component.itemCollectorBannedPickupDamage
--- @field damage integer # `= 999` 
--- @field type Damage.Flag # `= damage.Type.SUICIDE` 
--- @field killerName localizedString # `= 0` 

--- This item is used for internal event handling, cannot be removed via normal means and is effectively invisible
--- @class Component.itemNonRemovable

--- Items that don't benefit characters locked to half a heart of health
--- @class Component.itemBanHealthlocked

--- Items that occupy the weapon slot or are only useful with non-unique weapons
--- @class Component.itemBanWeaponlocked

--- Items that don't benefit characters with free shops
--- @class Component.itemBanShoplifter

--- Items that don't benefit characters without a strength-based damage source (typically a weapon)
--- @class Component.itemBanNoDamage

--- Items that occupy the THROW or ITEM_2 actions, making them inaccessible to diagonal characters
--- @class Component.itemBanDiagonal

--- Items that allow moving more than one tile at once
--- @class Component.itemBanMoveAmplifier

--- Items that don't benefit characters allergic to gold
--- @class Component.itemBanPoverty

--- Items that are actively detrimental for characters allergic to gold
--- @class Component.itemBanPovertyDetrimental

--- Items that instantly kill characters allergic to gold
--- @class Component.itemBanKillPoverty

--- Items that allow inflicting damage in any way at all, making them unsuitable for pacifist characters
--- @class Component.itemBanPacifist

--- Items that are bound to the character and cannot be dropped
--- @class Component.itemBanInnateSpell

--- Items that are banned for characters that ignore the rhythm, or during No Beat Mode.
--- @class Component.itemBanRhythmless

--- Items that are banned specifically for Aria, for balancing reasons (e.g. Risk Charm)
--- @class Component.itemBanAria

--- Items that are banned specifically for Dorian, for balancing reasons (e.g. Ring of Gold)
--- @class Component.itemBanDorian

--- Items that are banned specifically for Eli, for balancing reasons (e.g. Bomb Charm)
--- @class Component.itemBanEli

--- Items that are banned specifically for Diamond, for balancing reasons (e.g. Broadswords)
--- @class Component.itemBanDiamond

--- Items that are banned specifically for Mary, for balancing reasons (e.g. Blast Helm)
--- @class Component.itemBanMary

--- Items that are banned specifically for Tempo, for balancing reasons (e.g. Enchant Scroll)
--- @class Component.itemBanTempo

--- Items that are banned specifically for Coda.
--- @class Component.itemBanCoda

--- Items that are banned specifically for Melody.
--- @class Component.itemBanMelody

--- Items that are banned during Ensemble mode.
--- @class Component.itemBanEnsembleMode

--- Shrines that don't benefit characters locked to half a heart of health.
--- @class Component.shrineBanHealthlocked

--- Shrines that are banned for characters with a cursed weapon slot.
--- @class Component.shrineBanWeaponlocked

--- Shrines that are banned for some characters with a cursed shovel slot.
--- @class Component.shrineBanShovellocked

--- Shrines that are banned for characters that ignore the rhythm, or during No Beat Mode.
--- @class Component.shrineBanRhythmless

--- Shrines that are banned for pacifist characters.
--- @class Component.shrineBanPacifist

--- Shrines that are banned for diagonally-moving characters.
--- @class Component.shrineBanDiamond

--- Shrines that are banned specifically for Tempo.
--- @class Component.shrineBanTempo

--- Shrines that are banned during Ensemble mode.
--- @class Component.shrineBanEnsembleMode

--- @class Entity
--- @field inventoryCursedSlots Component.inventoryCursedSlots
--- @field inventoryBannedItemSlots Component.inventoryBannedItemSlots
--- @field inventoryBannedItems Component.inventoryBannedItems
--- @field inventoryBannedItemTypes Component.inventoryBannedItemTypes
--- @field inventoryUndroppableBan Component.inventoryUndroppableBan
--- @field itemCollectorBannedPickupDamage Component.itemCollectorBannedPickupDamage
--- @field itemNonRemovable Component.itemNonRemovable
--- @field itemBanHealthlocked Component.itemBanHealthlocked
--- @field itemBanWeaponlocked Component.itemBanWeaponlocked
--- @field itemBanShoplifter Component.itemBanShoplifter
--- @field itemBanNoDamage Component.itemBanNoDamage
--- @field itemBanDiagonal Component.itemBanDiagonal
--- @field itemBanMoveAmplifier Component.itemBanMoveAmplifier
--- @field itemBanPoverty Component.itemBanPoverty
--- @field itemBanPovertyDetrimental Component.itemBanPovertyDetrimental
--- @field itemBanKillPoverty Component.itemBanKillPoverty
--- @field itemBanPacifist Component.itemBanPacifist
--- @field itemBanInnateSpell Component.itemBanInnateSpell
--- @field itemBanRhythmless Component.itemBanRhythmless
--- @field itemBanAria Component.itemBanAria
--- @field itemBanDorian Component.itemBanDorian
--- @field itemBanEli Component.itemBanEli
--- @field itemBanDiamond Component.itemBanDiamond
--- @field itemBanMary Component.itemBanMary
--- @field itemBanTempo Component.itemBanTempo
--- @field itemBanCoda Component.itemBanCoda
--- @field itemBanMelody Component.itemBanMelody
--- @field itemBanEnsembleMode Component.itemBanEnsembleMode
--- @field shrineBanHealthlocked Component.shrineBanHealthlocked
--- @field shrineBanWeaponlocked Component.shrineBanWeaponlocked
--- @field shrineBanShovellocked Component.shrineBanShovellocked
--- @field shrineBanRhythmless Component.shrineBanRhythmless
--- @field shrineBanPacifist Component.shrineBanPacifist
--- @field shrineBanDiamond Component.shrineBanDiamond
--- @field shrineBanTempo Component.shrineBanTempo
--- @field shrineBanEnsembleMode Component.shrineBanEnsembleMode

return BanComponents
