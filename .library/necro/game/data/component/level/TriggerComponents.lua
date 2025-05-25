--- @meta

local TriggerComponents = {}

--- Adds an event parameter whenever the trap is triggered for the first time in a given turnID by an entity.
--- Duplicate presses caused by rollback are ignored.
--- @class Component.trapClientTrigger

--- If this trap's delay was pre-empted, the action of the acting player is inhibited
--- @class Component.trapInhibitPreemptiveAction

--- @class Component.trapStartRun
--- @field mode string # `= "AllZones"` 
--- @field fileName string # `= ""` 
--- @field zone integer # `= 0` 
--- @field options table # 

--- @class Component.trapStartDailyChallenge
--- @field mode string # `= ""` 

--- @class Component.trapSelectCharacter
--- @field character string # `= ""` 

--- @class Component.trapOpenMenu
--- @field menu string # `= ""` 

--- @class Component.trapRequireZoneUnlock
--- @field zone integer # `= 1` 
--- @field lockedTileType string # `= "LobbyLockedStairs"` 

--- @class Component.trapRequireUnlock
--- @field unlockType Progression.UnlockType # `= progression.UnlockType.ENEMY_TRAINING` 
--- @field unlockName string # `= ""` 
--- @field lockedTileType string # `= "LobbyLockedStairs"` 

--- @class Component.trapRequireModeUnlock
--- @field mode integer # `= 0` 

--- @class Component.trapUnlockWithDiamonds
--- @field cost integer # `= 3` 
--- @field unlockType Progression.UnlockType # `= progression.UnlockType.ENEMY_TRAINING` 
--- @field unlockName string # `= ""` 
--- @field lockedTileType string # `= "StairsDiamond3"` 
--- @field unlockedMessageKey string # `= ""` 

--- @class Component.trapRequirePrimaryPlayer

--- @class Component.trapConfirmation
--- @field active boolean # `= true` 

--- @class Component.trapConfirmationMenu
--- @field messageKey string # `= "label.lobby.confirm.generic"` i18n reference key for this confirmation menu's message
--- @field messageEntityType string # `= ""` Entity type for which a string value is substituted into this confirmation menu's message
--- @field messageComponent string # `= "friendlyName"` Component name to look up for the specified entity type
--- @field messageField string # `= "name"` Field name to look up in the specified component
--- @field bestiaryEntityType string # `= ""` Entity type whose bestiary image is shown alongside the confirmation menu's message
--- @field bestiaryBackground boolean # `= false` If true, renders a background gradient for the confirmation menu's bestiary image

--- @class Component.trapConfirmationMenuProgressionCurrency
--- @field active boolean # `= true` 
--- @field currencyType string # `= currency.Type.DIAMOND` 

--- Adds a local co-op player when triggered while only one player is active.
--- Removes a local co-op player when triggered while co-op is already active.
--- @class Component.trapToggleLocalCoop
--- @field labelKeySinglePlayer string # `= "label.lobby.stair.singlePlayer"` 
--- @field labelKeyCoop string # `= "label.lobby.stair.localCoop"` 

--- @class Component.trapOpenCharacterSelector

--- @class Component.trapOpenLobby

--- @class Component.trapOpenModeSelector

--- @class Component.trapJanitorNext

--- @class Component.trapJanitorReset

--- Checks if the lobby room this entity is traveling to needs to be populated.
--- @class Component.trapPopulateLobbyRoom

--- Overrides run state attributes upon stepping on the trigger.
--- @class Component.trapModifyRunState
--- @field state table # 

--- Temporarily loads a mod when stepping on the trigger. The mod is unloaded upon returning to the lobby.
--- Only bundled mods can be loaded this way.
--- @class Component.trapLoadMod
--- @field modName string # `= ""` 
--- @field confirmationMessage localizedString # `= 0` 
--- @field confirmationMessageOverride string # `= ""` 
--- @field requireMultiplayer boolean # `= false` 
--- @field lazyUnload boolean # `= false` 

--- Unloads a mod when stepping on the trigger. Only bundled mods can be unloaded this way.
--- @class Component.trapUnloadMod
--- @field delay number # `= 0.2` 
--- @field modName string # `= ""` 

--- Saves the Ensemble Mode character choices when this trap is hit.
--- @class Component.trapEnsembleModeStart

--- Enables/disables an extra mode when this entity is interacted with by an eligible player (typically the host)
--- @class Component.interactableToggleExtraMode
--- @field extraModeID integer # `= 0` 
--- @field active boolean # `= false` 

--- Visually indicates the unlock/enable state of an extra mode on this entity's sprite
--- @class Component.interactableToggleExtraModeSpriteChange

--- @class Entity
--- @field trapClientTrigger Component.trapClientTrigger
--- @field trapInhibitPreemptiveAction Component.trapInhibitPreemptiveAction
--- @field trapStartRun Component.trapStartRun
--- @field trapStartDailyChallenge Component.trapStartDailyChallenge
--- @field trapSelectCharacter Component.trapSelectCharacter
--- @field trapOpenMenu Component.trapOpenMenu
--- @field trapRequireZoneUnlock Component.trapRequireZoneUnlock
--- @field trapRequireUnlock Component.trapRequireUnlock
--- @field trapRequireModeUnlock Component.trapRequireModeUnlock
--- @field trapUnlockWithDiamonds Component.trapUnlockWithDiamonds
--- @field trapRequirePrimaryPlayer Component.trapRequirePrimaryPlayer
--- @field trapConfirmation Component.trapConfirmation
--- @field trapConfirmationMenu Component.trapConfirmationMenu
--- @field trapConfirmationMenuProgressionCurrency Component.trapConfirmationMenuProgressionCurrency
--- @field trapToggleLocalCoop Component.trapToggleLocalCoop
--- @field trapOpenCharacterSelector Component.trapOpenCharacterSelector
--- @field trapOpenLobby Component.trapOpenLobby
--- @field trapOpenModeSelector Component.trapOpenModeSelector
--- @field trapJanitorNext Component.trapJanitorNext
--- @field trapJanitorReset Component.trapJanitorReset
--- @field trapPopulateLobbyRoom Component.trapPopulateLobbyRoom
--- @field trapModifyRunState Component.trapModifyRunState
--- @field trapLoadMod Component.trapLoadMod
--- @field trapUnloadMod Component.trapUnloadMod
--- @field trapEnsembleModeStart Component.trapEnsembleModeStart
--- @field interactableToggleExtraMode Component.interactableToggleExtraMode
--- @field interactableToggleExtraModeSpriteChange Component.interactableToggleExtraModeSpriteChange

return TriggerComponents
