--- @meta

local LevelGenerationComponents = {}

--- Reverses the order of zones in the run.
--- @class Component.traitReverseZoneOrder

--- Removes all bosses in the run.
--- @class Component.traitSkipBosses

--- Replaces the final boss in the run with a story boss.
--- @class Component.traitStoryBosses
--- @field bosses table # List of boss types (see `Boss.Type`).
--- @field zone integer # `= 4` In single-zone, the zone at which this character’s story bosses appear.
--- @field priority number # `= 0` Determines which story boss is encountered when multiple characters have story bosses.

--- Prevents "vault" rooms from having any gold on the ground.
--- @class Component.traitNoGoldInVaults

--- Prevents dirt walls with gold from appearing (doesn’t affect shop walls).
--- @class Component.traitNoGoldInWalls

--- Applies an enemy substitution to all enemies on all floors.
--- Unlike other trait components, this also affects late-spawned enemies.
--- @class Component.traitSubstituteEnemies
--- @field type integer # `= 0` 

--- Applies an enemy substitution to some proportion of enemies on regular floors.
--- @class Component.traitSubstituteSomeEnemies
--- @field zoneRatios table # Maps zone number => proportion of the total number of enemies to substitute
--- @field type integer # `= 0` 
--- @field priority number # `= 0` 

--- Removes one item from regular and blood shops.
--- @class Component.traitSmallerShops

--- Adds a sarcophagus on each boss floor.
--- @class Component.traitBossSarcophagus
--- @field type string # `= "Sarcophagus"` 

--- Removes some enemies on regular floors, down to a zone-specific maximum.
--- @class Component.traitInnatePeace
--- @field zoneMaxEnemies table # Maps zone number => max enemies in a regular floor of that zone

--- Replaces all trapdoors with spike traps. Also removes cracked floors.
--- @class Component.traitNoTrapdoors

--- Prevents certain secret rooms from appearing during the run.
--- @class Component.traitBannedSecretRooms
--- @field types table # Set of banned secret room IDs (see `TravelRune.Type`).

--- Replaces part of each regular floor using Z5 tiles and enemies.
--- @class Component.traitZone5Bleed

--- Replaces blademasters with monkeys in regular floors.
--- @class Component.traitNoBlademasters

--- Adds 1 miniboss to each regular floor. Does not stack with Hard Mode’s extra miniboss.
--- @class Component.traitExtraMiniboss

--- Adds 1 enemy per room in regular floors. Does not stack with Hard Mode’s extra enemies.
--- @class Component.traitExtraEnemies

--- Adds 2 spiders to each regular floor in Z1, Z2, and Z3.
--- @class Component.traitAddSpiders

--- Adds a sarcophagus to each regular floor in Z1, Z2, and Z3.
--- @class Component.traitAddSarcophagus

--- Removes sarcophagi from Z4. Does not affect sarcophagi added by `traitAddSarcophagus`.
--- @class Component.traitNoSarcophagus

--- Removes monkeys from Z4.
--- @class Component.traitZone4NoMonkeys

--- Removes spiders from Z4. Also prevents `traitAddSpiders` from adding spiders to Z2 and Z3.
--- @class Component.traitZone4NoSpiders

--- Adds 2 enemies per room in Z1, 1 in Z2, 1 in Z5. Cancelled by `traitInnatePeace`.
--- @class Component.traitExtraEnemiesZ1Z2Z5

--- Deletes all occurences of the given enemy types from all floors.
--- @class Component.enemyBans
--- @field types table # List of enemy type names.

--- Common item pool, used by:
--- 
--- * regular chests
--- * red chest mimics
--- * teh urn’s second and third items
--- * "rat trap" rooms (sometimes)
--- * transmute spell
--- * chance shrine
--- * pain shrine
--- * risk shrine
--- * pace shrine
--- * feast shrine
--- * fire shrine
--- @class Component.itemPoolChest
--- @field weights table # 

--- Shovels, torches, charms, consumables. Used in places that offer 3 items of different types:
--- 
--- * boss flawless reward chests
--- * arena rewards
--- * boss shrine
--- * sacrifice shrine (normal activation only)
--- @class Component.itemPoolRedChest
--- @field weights table # 

--- Spells, rings, scrolls, tomes. See `itemPoolRedChest` for uses.
--- @class Component.itemPoolPurpleChest
--- @field weights table # 

--- Weapons, armors, boots, shields. See `itemPoolRedChest` for uses.
--- @class Component.itemPoolBlackChest
--- @field weights table # 

--- Common item pool, used by:
--- 
--- * locked chests
--- * blue and white chest mimics
--- * crates, barrels, and gargoyles (sometimes)
--- @class Component.itemPoolLockedChest
--- @field weights table # 

--- Common item pool, used by:
--- 
--- * regular shops
--- * super secret shops
--- * thief
--- @class Component.itemPoolShop
--- @field weights table # 

--- Used by locked shops.
--- @class Component.itemPoolLockedShop
--- @field weights table # 

--- Used by teh urn’s first item.
--- @class Component.itemPoolUrn
--- @field weights table # 

--- Common item pool, used by:
--- 
--- * blood shop
--- * glass shop
--- * conjurer
--- * transmogrifier
--- @class Component.itemPoolSecret
--- @field weights table # 

--- Non-magic food only. Used by:
--- 
--- * food shop’s first item
--- * "rat trap" rooms (sometimes)
--- * crates, barrels, and gargoyles (sometimes)
--- @class Component.itemPoolFood
--- @field weights table # 

--- Used by food shop’s second item.
--- @class Component.itemPoolHearts
--- @field weights table # 

--- Used by crates and barrels (sometimes).
--- @class Component.itemPoolCrate
--- @field weights table # 

--- Used by crate mimics and barrel mimics.
--- @class Component.itemPoolCrateMimic
--- @field weights table # 

--- Used by war shrine.
--- @class Component.itemPoolWar
--- @field weights table # 

--- Used by uncertainty shrine.
--- @class Component.itemPoolUncertainty
--- @field weights table # 

--- Used by enchant scroll.
--- @class Component.itemPoolEnchant
--- @field weights table # 

--- Used by need scroll.
--- @class Component.itemPoolNeed
--- @field weights table # 

--- Not a regular item pool! Used by "vault" rooms.
--- A random `key` is picked among all `itemPoolVault` items, items with that `key` are sorted
--- by `priority`, and the first unbanned one is used.
--- @class Component.itemPoolVault
--- @field key integer # `= 0` 
--- @field priority integer # `= 0` 

--- Prevents this item from being generated by transmute spell.
--- @class Component.itemExcludeFromTransmute

--- Prevents this item from being generated in boss flawless reward chests.
--- @class Component.itemExcludeFromBossChests

--- Marker component.
--- @class Component.enemyPoolZone1

--- Marker component.
--- @class Component.enemyPoolZone2

--- Marker component.
--- @class Component.enemyPoolZone3

--- Marker component.
--- @class Component.enemyPoolZone4

--- Marker component.
--- @class Component.enemyPoolZone5

--- Marker component.
--- @class Component.enemyPoolMiniboss

--- Marker component.
--- @class Component.enemyPoolBoss

--- Marker component.
--- @class Component.enemyPoolSpecial

--- Marker component.
--- @class Component.enemyPoolNPC

--- Marker component.
--- @class Component.enemyPoolShopkeeper

--- Marker component.
--- @class Component.enemyPoolNormal

--- Allows this enemy to be randomly made giant on regular floors.
--- @class Component.enemyCanBeLord

--- Allows this enemy to be deleted by `traitInnatePeace`.
--- @class Component.enemyCullableByInnatePeace

--- Allows this enemy to be deleted by `itemPeace`.
--- @class Component.enemyCullableByPeaceRing

--- Defines how this enemy is affected by enemy substitutions.
--- @class Component.enemySubstitutable

--- Ignores this enemy for the purposes of `traitSubstituteSomeEnemies`.
--- @class Component.enemyExcludeFromSubstitutionCount

--- @class Component.trainable
--- @field tileset string # `= ""` 
--- @field order number # `= 0` 
--- @field name localizedString # `= 0` 

--- Marks a different item as seen when this item is generated.
--- This is used by variants (for example, generating RingCourageUncertain marks RingCourage seen).
--- @class Component.itemGenerationKey
--- @field name string # `= ""` 

--- Duplication-specific workaround.
--- @class Component.generateItemsOnce
--- @field active boolean # `= true` 

--- Immediately marks seen the contents of this entity (for example, blood shopkeeper’s blood drum).
--- @class Component.storageMarkSeen

--- Fills this entity with a random item as it spawns, using a given item pool.
--- @class Component.storageGenerateItemPool
--- @field quantity integer # `= 1` 
--- @field chanceType string # `= ""` 
--- @field levelBonus integer # `= 0` 

--- Fills this entity with a random item as it spawns, using the generation rules for crate contents.
--- @class Component.storageGenerateCrate
--- @field itemProbability number # `= 0.55` Probability that the item is rolled from `itemPoolLockedChest`.
--- @field foodProbability number # `= 0.45` Probability that the item is rolled from `itemPoolFood`. If neither of those checks pass, the item is rolled from `itemPoolCrate`.
--- @field enemyTypes table # 

--- Fills this entity with one or more random items, using fully customizable generation rules.
--- @class Component.storageGenerateComplex
--- @field generationArgs table # List of generation arguments, each one in the format documented at `ItemGeneration.ChoiceArguments`.

--- Used by shrines to pre-generate their contents, for seed variance minimization.
--- @class Component.itemGenerationQueue
--- @field items table # 
--- @field types table # List of `ItemGeneration.QueueType`.

--- Registers this entity as a travel rune that transports players to the secret shop and back to the main level.
--- @class Component.generateSecretRoom
--- @field id integer # `= 0` Unique ID that identifies the travel rune and the associated secret shop. To ensure uniqueness, this value must be obtained via `local id = travelRune.Type.extend('NAME')`. It should then be used as the second argument in `event.generateSecretRoom.add()` to provide a handler for generating the actual secret room (via `secretRoomGeneration.common()`).
--- @field wallType string # `= "DirtWallCracked"` Tile type name to use for the cracked entrance tile.

--- Automatically adds this travel rune and its associated secret room in All Zones Mode in a random regular level.
--- @class Component.generateSecretRoomInRun
--- @field priority number # `= 0` Overrides the order in which travel runes are associated with levels. A high priority causes the travel rune to be placed before lower priorities, allowing for restricted-level secret shops (such as the Blood Shop) to outprioritize other shop types. This ensures that these types of secret shops always find a valid level to be placed within.

--- Prevents this travel rune and its associated secret room from appearing in Single Zone Mode.
--- @class Component.generateSecretRoomExcludeFromSingleZone

--- Prevents this travel rune and its associated secret room from spawning outside of a range of zones/floors.
--- @class Component.generateSecretRoomRestrictLevel
--- @field minZone integer # `= 1` 
--- @field maxZone integer # `= 1` 
--- @field minFloor integer # `= 1` 
--- @field maxFloor integer # `= 3` 

--- Generates items for this shopkeeper’s shop, as controlled by the `generateShopItems` event.
--- @class Component.shopkeeperGenerateItems
--- @field priceMultiplier number # `= 1` 
--- @field forceEnable boolean # `= false` 

--- Uses normal shop generation rules for `shopkeeperGenerateItems`.
--- @class Component.generateShopNormal

--- Uses blood shop generation rules for `shopkeeperGenerateItems`.
--- @class Component.generateShopBlood
--- @field component string # `= "weaponMaterialGold"` 

--- Uses glass shop generation rules for `shopkeeperGenerateItems`.
--- @class Component.generateShopGlass
--- @field items table # 
--- @field component string # `= "weaponMaterialGlass"` 

--- Uses glass shop generation rules for `shopkeeperGenerateItems`.
--- @class Component.generateShopFood

--- Uses super secret shop generation rules for `shopkeeperGenerateItems`.
--- @class Component.generateShopMedic

--- Generates items near this entity, using arena rewards generation rules.
--- @class Component.generateArenaItems
--- @field forceEnable boolean # `= false` 

--- Prevents cracked walls from being generated on the same tile as this entity.
--- @class Component.tileCrackedWallPlacementInhibitor

--- Prevents cracked walls from being generated next to floors with this entity on them.
--- @class Component.tileCrackedWallAdjacencyInhibitor

--- @class Entity
--- @field traitReverseZoneOrder Component.traitReverseZoneOrder
--- @field traitSkipBosses Component.traitSkipBosses
--- @field traitStoryBosses Component.traitStoryBosses
--- @field traitNoGoldInVaults Component.traitNoGoldInVaults
--- @field traitNoGoldInWalls Component.traitNoGoldInWalls
--- @field traitSubstituteEnemies Component.traitSubstituteEnemies
--- @field traitSubstituteSomeEnemies Component.traitSubstituteSomeEnemies
--- @field traitSmallerShops Component.traitSmallerShops
--- @field traitBossSarcophagus Component.traitBossSarcophagus
--- @field traitInnatePeace Component.traitInnatePeace
--- @field traitNoTrapdoors Component.traitNoTrapdoors
--- @field traitBannedSecretRooms Component.traitBannedSecretRooms
--- @field traitZone5Bleed Component.traitZone5Bleed
--- @field traitNoBlademasters Component.traitNoBlademasters
--- @field traitExtraMiniboss Component.traitExtraMiniboss
--- @field traitExtraEnemies Component.traitExtraEnemies
--- @field traitAddSpiders Component.traitAddSpiders
--- @field traitAddSarcophagus Component.traitAddSarcophagus
--- @field traitNoSarcophagus Component.traitNoSarcophagus
--- @field traitZone4NoMonkeys Component.traitZone4NoMonkeys
--- @field traitZone4NoSpiders Component.traitZone4NoSpiders
--- @field traitExtraEnemiesZ1Z2Z5 Component.traitExtraEnemiesZ1Z2Z5
--- @field enemyBans Component.enemyBans
--- @field itemPoolChest Component.itemPoolChest
--- @field itemPoolRedChest Component.itemPoolRedChest
--- @field itemPoolPurpleChest Component.itemPoolPurpleChest
--- @field itemPoolBlackChest Component.itemPoolBlackChest
--- @field itemPoolLockedChest Component.itemPoolLockedChest
--- @field itemPoolShop Component.itemPoolShop
--- @field itemPoolLockedShop Component.itemPoolLockedShop
--- @field itemPoolUrn Component.itemPoolUrn
--- @field itemPoolSecret Component.itemPoolSecret
--- @field itemPoolFood Component.itemPoolFood
--- @field itemPoolHearts Component.itemPoolHearts
--- @field itemPoolCrate Component.itemPoolCrate
--- @field itemPoolCrateMimic Component.itemPoolCrateMimic
--- @field itemPoolWar Component.itemPoolWar
--- @field itemPoolUncertainty Component.itemPoolUncertainty
--- @field itemPoolEnchant Component.itemPoolEnchant
--- @field itemPoolNeed Component.itemPoolNeed
--- @field itemPoolVault Component.itemPoolVault
--- @field itemExcludeFromTransmute Component.itemExcludeFromTransmute
--- @field itemExcludeFromBossChests Component.itemExcludeFromBossChests
--- @field enemyPoolZone1 Component.enemyPoolZone1
--- @field enemyPoolZone2 Component.enemyPoolZone2
--- @field enemyPoolZone3 Component.enemyPoolZone3
--- @field enemyPoolZone4 Component.enemyPoolZone4
--- @field enemyPoolZone5 Component.enemyPoolZone5
--- @field enemyPoolMiniboss Component.enemyPoolMiniboss
--- @field enemyPoolBoss Component.enemyPoolBoss
--- @field enemyPoolSpecial Component.enemyPoolSpecial
--- @field enemyPoolNPC Component.enemyPoolNPC
--- @field enemyPoolShopkeeper Component.enemyPoolShopkeeper
--- @field enemyPoolNormal Component.enemyPoolNormal
--- @field enemyCanBeLord Component.enemyCanBeLord
--- @field enemyCullableByInnatePeace Component.enemyCullableByInnatePeace
--- @field enemyCullableByPeaceRing Component.enemyCullableByPeaceRing
--- @field enemySubstitutable Component.enemySubstitutable
--- @field enemyExcludeFromSubstitutionCount Component.enemyExcludeFromSubstitutionCount
--- @field trainable Component.trainable
--- @field itemGenerationKey Component.itemGenerationKey
--- @field generateItemsOnce Component.generateItemsOnce
--- @field storageMarkSeen Component.storageMarkSeen
--- @field storageGenerateItemPool Component.storageGenerateItemPool
--- @field storageGenerateCrate Component.storageGenerateCrate
--- @field storageGenerateComplex Component.storageGenerateComplex
--- @field itemGenerationQueue Component.itemGenerationQueue
--- @field generateSecretRoom Component.generateSecretRoom
--- @field generateSecretRoomInRun Component.generateSecretRoomInRun
--- @field generateSecretRoomExcludeFromSingleZone Component.generateSecretRoomExcludeFromSingleZone
--- @field generateSecretRoomRestrictLevel Component.generateSecretRoomRestrictLevel
--- @field shopkeeperGenerateItems Component.shopkeeperGenerateItems
--- @field generateShopNormal Component.generateShopNormal
--- @field generateShopBlood Component.generateShopBlood
--- @field generateShopGlass Component.generateShopGlass
--- @field generateShopFood Component.generateShopFood
--- @field generateShopMedic Component.generateShopMedic
--- @field generateArenaItems Component.generateArenaItems
--- @field tileCrackedWallPlacementInhibitor Component.tileCrackedWallPlacementInhibitor
--- @field tileCrackedWallAdjacencyInhibitor Component.tileCrackedWallAdjacencyInhibitor

return LevelGenerationComponents
