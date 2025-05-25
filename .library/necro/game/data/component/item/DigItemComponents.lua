--- @meta

local DigItemComponents = {}

--- Increases the holder’s dig strength.
--- Also sets the `shovel` flag on dig events, which affects some interactions (notably Z4 walls).
--- @class Component.shovel
--- @field strength integer # `= 0` 

--- Increases the holder’s dig strength.
--- @class Component.itemDigStrengthIncrease
--- @field increase integer # `= 0` 

--- Increases the holder’s dig strength, up to a limit.
--- @class Component.itemDigStrengthIncreaseCapped
--- @field maximumStrength integer # `= 0` 
--- @field increase integer # `= 0` 

--- Conditionally increases the holder’s dig strength for a limited time.
--- @class Component.itemConditionalDigStrengthIncrease
--- @field increase integer # `= 0` 
--- @field active boolean # `= false` 

--- Activates this item’s `itemConditionalDigStrength` when the item is used.
--- @class Component.itemConditionalDigStrengthOnActivation
--- @field pending boolean # `= false` 

--- Gives the holder’s digs a radius, also digging walls near the one that was initially hit.
--- @class Component.itemDigRadius
--- @field radius number # `= 1.5` Inclusive maximum L2 distance.
--- @field minimumResistance Dig.Strength # `= dig.Strength.EARTH` 

--- Increases the holder’s dig strength based on the holder’s groove chain.
--- @class Component.itemDigStrengthIncreaseHolderGrooveChain
--- @field multiplier integer # `= 1` 

--- Causes various effects when the holder is about to fail digging a wall.
--- @class Component.itemDigUpgradeOnHighResistance
--- @field strength Dig.Strength # `= dig.Strength.SHOP` 
--- @field radius number # `= 0` 
--- @field damage integer # `= 0` Amount of damage dealt to the holder.
--- @field type Damage.Flag # `= damage.Type.BLOOD` Type of damage dealt to the holder.
--- @field consume boolean # `= false` If true, this item is consumed after taking effect.

--- Makes the holder’s digs take multiple hits.
--- @class Component.itemDigMultiHit

--- Performs a dig whenever the holder moves.
--- @class Component.itemAutoDigSurroundingTiles
--- @field radius integer # `= 1` 

--- Casts a spell when the holder digs a wall containing certain entities.
--- @class Component.itemCastOnWallEntityDig
--- @field component string # `= ""` 
--- @field spell string # `= ""` 
--- @field direction integer # `= 0` 

--- @class Entity
--- @field shovel Component.shovel
--- @field itemDigStrengthIncrease Component.itemDigStrengthIncrease
--- @field itemDigStrengthIncreaseCapped Component.itemDigStrengthIncreaseCapped
--- @field itemConditionalDigStrengthIncrease Component.itemConditionalDigStrengthIncrease
--- @field itemConditionalDigStrengthOnActivation Component.itemConditionalDigStrengthOnActivation
--- @field itemDigRadius Component.itemDigRadius
--- @field itemDigStrengthIncreaseHolderGrooveChain Component.itemDigStrengthIncreaseHolderGrooveChain
--- @field itemDigUpgradeOnHighResistance Component.itemDigUpgradeOnHighResistance
--- @field itemDigMultiHit Component.itemDigMultiHit
--- @field itemAutoDigSurroundingTiles Component.itemAutoDigSurroundingTiles
--- @field itemCastOnWallEntityDig Component.itemCastOnWallEntityDig

return DigItemComponents
