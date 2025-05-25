--- @meta

local GrooveChainComponents = {}

--- Multiplies any gold dropped when this entity kills something.
--- @class Component.coinMultiplier
--- @field multiplier number # `= 1` 

--- Multiplies gold dropped when this entity kills something during a multiplayer session.
--- @class Component.coinMultiplierCoop
--- @field multiplier number # `= 2` 

--- Tracks this entity’s groove chain.
--- @class Component.grooveChain
--- @field killCount integer # `= 0` 
--- @field multiplier integer # `= 1` 
--- @field killsForInitMultiplier integer # `= 1` 
--- @field killsPerMultiplier integer # `= 4` 
--- @field maximumMultiplier integer # `= 3` 

--- Increases this entity’s groove chain when it gets GROOVE_CHAIN credit for a kill (see `Kill.Credit`).
--- @class Component.grooveChainIncreaseOnKill

--- Resets this entity’s groove chain when it takes damage (except self-damage).
--- @class Component.grooveChainDropOnDamage

--- Resets this entity’s groove chain when it takes a trapdoor.
--- @class Component.grooveChainDropOnDescent

--- Resets this entity’s groove chain on any unsuccessful action (INVALID, FAIL, or IDLE).
--- @class Component.grooveChainDropOnInvalidAction

--- @class Component.grooveChainInvalidateFlawlessVictoryOnDrop

--- Creates flyaways when this entity skips beats.
--- @class Component.grooveChainFlyaways
--- @field dropText localizedString # `= "Coin multiplier lost"` 
--- @field skipText localizedString # `= "Beat skipped"` 
--- @field wasIdle boolean # `= true` 

--- Prevents some effects from resetting this entity’s groove chain.
--- @class Component.grooveChainImmunity
--- @field idle boolean # `= false` If true, IDLE actions do not reset this entity’s groove chain.
--- @field action boolean # `= false` If true, IDLE, FAIL, and INVALID actions do not reset this entity’s groove chain.
--- @field full boolean # `= false` If true, nothing resets this entity’s groove chain.

--- Prevents FAIL actions from resettting this entity’s groove chain.
--- @class Component.grooveChainFailImmunity

--- Inflicts damage to this entity when its groove chain gets reset.
--- @class Component.grooveChainInflictDamageOnDrop
--- @field damage integer # `= 1` 
--- @field type Damage.Flag # `= damage.Type.SELF_DAMAGE` 
--- @field maxGrooveType GrooveChain.Type # `= grooveChain.Type.ACTION` 
--- @field killerName localizedString # `= "Missed beat"` 
--- @field active boolean # `= false` 

--- Inflicts damage to the holder when its groove chain gets reset.
--- @class Component.itemGrooveChainInflictDamageOnDrop
--- @field damage integer # `= 1` 
--- @field type Damage.Flag # `= damage.Type.SELF_DAMAGE` 
--- @field maxGrooveType GrooveChain.Type # `= grooveChain.Type.ACTION` 
--- @field killerName localizedString # `= "Missed beat"` 

--- @class Entity
--- @field coinMultiplier Component.coinMultiplier
--- @field coinMultiplierCoop Component.coinMultiplierCoop
--- @field grooveChain Component.grooveChain
--- @field grooveChainIncreaseOnKill Component.grooveChainIncreaseOnKill
--- @field grooveChainDropOnDamage Component.grooveChainDropOnDamage
--- @field grooveChainDropOnDescent Component.grooveChainDropOnDescent
--- @field grooveChainDropOnInvalidAction Component.grooveChainDropOnInvalidAction
--- @field grooveChainInvalidateFlawlessVictoryOnDrop Component.grooveChainInvalidateFlawlessVictoryOnDrop
--- @field grooveChainFlyaways Component.grooveChainFlyaways
--- @field grooveChainImmunity Component.grooveChainImmunity
--- @field grooveChainFailImmunity Component.grooveChainFailImmunity
--- @field grooveChainInflictDamageOnDrop Component.grooveChainInflictDamageOnDrop
--- @field itemGrooveChainInflictDamageOnDrop Component.itemGrooveChainInflictDamageOnDrop

return GrooveChainComponents
