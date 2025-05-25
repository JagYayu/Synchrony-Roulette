--- @meta

local ShrineComponents = {}

--- Fires the `shrine` event when this entity is interacted with.
--- @class Component.shrine
--- @field name string # `= ""` This name is used as the key for the `shrine` event.
--- @field inactiveDrop table # List of item names. The first item unbanned for a random player will be used.
--- @field activeDrop table # List of item names. The first item unbanned for the interactor will be used.
--- @field active boolean # `= false` 

--- Activates this shrine when a `sacrificable` entity dies near it.
--- @class Component.shrineActivateOnDeath
--- @field miniboss boolean # `= false` 
--- @field remainingActivations integer # `= 5` 

--- If an entity with `sacrificableCopyItems` activates this shrine, mixes the victim's items into the reward pool.
--- @class Component.shrineActivateOnDeathCopyVictimItems
--- @field victim Entity.ID # 
--- @field slots table # 
--- @field dropOverride string # `= ""` 

--- Activates this shrine when an `interactor` entity takes damage near it.
--- @class Component.shrineActivateOnHit
--- @field bigHit boolean # `= false` 
--- @field remainingActivations integer # `= 5` 

--- Makes risk shrine work on this entity.
--- @class Component.riskDamage
--- @field flyaway localizedString # `= "Thorn! (Shrine of Risk)"` 
--- @field killerName localizedString # `= "Shrine of Risk"` 
--- @field damage integer # `= 1` 
--- @field type Damage.Flag # `= damage.Type.BLOOD` 
--- @field active boolean # `= false` 
--- @field pending boolean # `= false` 

--- Makes pace shrine work on this entity.
--- @class Component.paceUser
--- @field beatLimit integer # `= 65` 
--- @field flyaway localizedString # `= "Sloth! (Shrine of Pace)"` 
--- @field killerName localizedString # `= "Shrine of Pace"` 
--- @field damage integer # `= 1` 
--- @field type Damage.Flag # `= damage.Type.BLOOD` 
--- @field active boolean # `= false` 
--- @field activeNextFloor boolean # `= false` 

--- Counts towards shrine of sacrifice’s activation when this entity dies near it.
--- @class Component.sacrificable

--- Triggers shrine of sacrifice’s alternate rewards when this entity dies near it.
--- @class Component.sacrificableInstantReward

--- Overrides Shrine of Sacrifice's rewards with slot-specific copies of this entity's inventory when sacrificed.
--- @class Component.sacrificableCopyItems

--- Lets this shrine be generated during all-zones runs.
--- @class Component.shrinePoolAllZones
--- @field weight number # `= 0` 

--- Lets this shrine be generated during single-zone runs.
--- @class Component.shrinePoolSingleZone
--- @field weight number # `= 0` 

--- Prevents this shrine from being generated inside the shriner.
--- @class Component.shrinePoolExcludeFromShriner

--- Prevents this shrine from being generated in single-player.
--- @class Component.shrinePoolExcludeFromSinglePlayer

--- Prevents this item from being deleted by the Shrine of Phasing.
--- @class Component.itemPreservedByPhasingShrine

--- Prevents this item from being deleted by the non-Amplified Shrine of Peace.
--- @class Component.itemPreservedByPeaceShrine

--- @class Entity
--- @field shrine Component.shrine
--- @field shrineActivateOnDeath Component.shrineActivateOnDeath
--- @field shrineActivateOnDeathCopyVictimItems Component.shrineActivateOnDeathCopyVictimItems
--- @field shrineActivateOnHit Component.shrineActivateOnHit
--- @field riskDamage Component.riskDamage
--- @field paceUser Component.paceUser
--- @field sacrificable Component.sacrificable
--- @field sacrificableInstantReward Component.sacrificableInstantReward
--- @field sacrificableCopyItems Component.sacrificableCopyItems
--- @field shrinePoolAllZones Component.shrinePoolAllZones
--- @field shrinePoolSingleZone Component.shrinePoolSingleZone
--- @field shrinePoolExcludeFromShriner Component.shrinePoolExcludeFromShriner
--- @field shrinePoolExcludeFromSinglePlayer Component.shrinePoolExcludeFromSinglePlayer
--- @field itemPreservedByPhasingShrine Component.itemPreservedByPhasingShrine
--- @field itemPreservedByPeaceShrine Component.itemPreservedByPeaceShrine

return ShrineComponents
