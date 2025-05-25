--- @meta

local ProgressionComponents = {}

--- Allows this entity to use items from the Diamond Dealer.
--- @class Component.initialInventoryUnlockReceiver
--- @field pending boolean # `= true` 

--- Allows this entity to bring Weaponmaster’s weapons to training.
--- @class Component.initialInventoryTrainingWeaponReceiver
--- @field pending boolean # `= true` 

--- Makes this item unlockable. Items without this component are always unlocked.
--- @class Component.itemUnlockable
--- @field key string # `= ""` 

--- Adds this item to the Janitor’s item pool.
--- @class Component.itemCleanable

--- Adds this item to the Diamond Dealer’s item pool, and defines its price.
--- @class Component.itemDiamondDealable
--- @field diamonds integer # `= 0` 

--- Permanently remember when an item of this type has been picked up.
--- This is used to unlock weapons for the weaponmaster, and to stop single-zone
--- diamond hoards from appearing more than once.
--- @class Component.itemUnlockOnPickup
--- @field key string # `= ""` 

--- Increases the holder’s coin multiplier.
--- @class Component.itemIncreaseCoinMultiplier
--- @field multiplier number # `= 0.5` 

--- Allows this item to be offered by the Weaponmaster.
--- @class Component.itemTraining
--- @field active boolean # `= false` 

--- Marks this item as being progression-specific (like permanent hearts).
--- @class Component.itemLobbyProgressionUnlock

--- Unlocks this enemy for training when it dies.
--- @class Component.enemyUnlockOnDeath
--- @field key string # `= ""` Specifies which entity type to unlock when killing this enemy. This is a mutable field to allow for its value to be preserved on conversion.

--- Unlocks this enemy for training as soon as it spawns (used for story bosses).
--- @class Component.enemyUnlockOnSpawn

--- Specific to pixies.
--- @class Component.spellcastUnlockCaster

--- This character has extra health in game modes where progression is enabled.
--- @class Component.progressionBonusHealth
--- @field health integer # `= 2` 

--- Characters without this component are unlocked by default
--- @class Component.playableCharacterUnlockable

--- Hint given when stepping on a locked character staircase
--- @class Component.playableCharacterUnlockHint
--- @field text localizedString # `= 0` 

--- Lobby NPCs without this component are unlocked by default
--- @class Component.npcUnlockable
--- @field keyType integer # `= 0` 
--- @field cagedFlyaway1 localizedString # `= "Help me!"` 
--- @field cagedFlyaway2 localizedString # `= "Buy the golden key!"` 
--- @field freedFlyaway1 localizedString # `= "Thank you!!!"` 
--- @field freedFlyaway2 localizedString # `= "See you in the lobby"` 
--- @field freed boolean # `= false` 

--- Unlocks the character upon completing a certain zone (with an optional character requirement)
--- @class Component.playableCharacterUnlockOnZoneCompletion
--- @field zone integer # `= 1` 
--- @field character string # `= ""` 

--- Unlocks the character upon defeating the story boss with the specified requirement character
--- @class Component.playableCharacterUnlockOnRunCompletion
--- @field character string # `= ""` 

--- Unlocks the character upon completing an All Zones run
--- @class Component.playableCharacterUnlockOnModeCompletion
--- @field modeID string # `= ""` 

--- Unlocks the character upon completing an All Chars run
--- @class Component.playableCharacterUnlockOnAllCharsCompletion

--- Unlocks any NPC on the same tile as this entity when interacting with it.
--- @class Component.interactableUnlockNPC

--- Unlocks the sold item when paying for this price tag.
--- @class Component.priceTagUnlockItem
--- @field item Entity.ID # 
--- @field unlockTypes table # 

--- Deletes the sold item after unlocking it.
--- @class Component.priceTagUnlockItemAutoDespawn

--- Shows "You have unspent diamonds" reminder when the player leaves the lobby with enough
--- diamonds to pay for this price tag.
--- @class Component.priceTagWarnOnLobbyLeave

--- @class Entity
--- @field initialInventoryUnlockReceiver Component.initialInventoryUnlockReceiver
--- @field initialInventoryTrainingWeaponReceiver Component.initialInventoryTrainingWeaponReceiver
--- @field itemUnlockable Component.itemUnlockable
--- @field itemCleanable Component.itemCleanable
--- @field itemDiamondDealable Component.itemDiamondDealable
--- @field itemUnlockOnPickup Component.itemUnlockOnPickup
--- @field itemIncreaseCoinMultiplier Component.itemIncreaseCoinMultiplier
--- @field itemTraining Component.itemTraining
--- @field itemLobbyProgressionUnlock Component.itemLobbyProgressionUnlock
--- @field enemyUnlockOnDeath Component.enemyUnlockOnDeath
--- @field enemyUnlockOnSpawn Component.enemyUnlockOnSpawn
--- @field spellcastUnlockCaster Component.spellcastUnlockCaster
--- @field progressionBonusHealth Component.progressionBonusHealth
--- @field playableCharacterUnlockable Component.playableCharacterUnlockable
--- @field playableCharacterUnlockHint Component.playableCharacterUnlockHint
--- @field npcUnlockable Component.npcUnlockable
--- @field playableCharacterUnlockOnZoneCompletion Component.playableCharacterUnlockOnZoneCompletion
--- @field playableCharacterUnlockOnRunCompletion Component.playableCharacterUnlockOnRunCompletion
--- @field playableCharacterUnlockOnModeCompletion Component.playableCharacterUnlockOnModeCompletion
--- @field playableCharacterUnlockOnAllCharsCompletion Component.playableCharacterUnlockOnAllCharsCompletion
--- @field interactableUnlockNPC Component.interactableUnlockNPC
--- @field priceTagUnlockItem Component.priceTagUnlockItem
--- @field priceTagUnlockItemAutoDespawn Component.priceTagUnlockItemAutoDespawn
--- @field priceTagWarnOnLobbyLeave Component.priceTagWarnOnLobbyLeave

return ProgressionComponents
