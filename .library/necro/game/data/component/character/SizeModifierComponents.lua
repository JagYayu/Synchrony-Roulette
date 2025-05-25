--- @meta

local SizeModifierComponents = {}

--- Status effect. The effects of being giant are determined purely by other components.
--- @class Component.gigantism
--- @field remainingTurns integer # `= 0` 
--- @field permanent boolean # `= false` 

--- Increases this entity’s dig strength while it is giant.
--- @class Component.gigantismDigStrengthIncrease
--- @field increase integer # `= 1` 

--- Gives a default radius to this entity’s digs while it is giant.
--- This doesn’t affect digs that already have a radius.
--- @class Component.gigantismDigRadius
--- @field radius number # `= 1.5` 
--- @field minimumResistance Dig.Strength # `= dig.Strength.EARTH` 

--- Multiplies damage dealt by this entity while it is giant.
--- @class Component.gigantismAttackDamageMultiplier
--- @field damageType Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field multiplier integer # `= 2` 

--- Multiplies damage received by this entity while it is giant.
--- @class Component.gigantismIncomingDamageMultiplier
--- @field bypassFlags Damage.Flag # `= damage.Flag.SELF_DAMAGE` 
--- @field multiplier number # `= 0.5` 

--- Multiplies this entity’s max and current health while it is giant.
--- @class Component.gigantismHealthMultiplier
--- @field multiplier integer # `= 2` 

--- Lets this entity move out of liquids without slowing down while it is giant.
--- @class Component.gigantismTileUnsinkImmunity

--- Makes this entity immune to hot coals while it is giant.
--- @class Component.gigantismTileIdleDamageImmunity

--- Modifies this entity’s attackability while it is giant.
--- @class Component.gigantismAttackableFlags
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- Modifies this entity’s movement type while it is giant.
--- @class Component.gigantismMoveFlags
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- Replaces this entity’s normal gold drop if it dies while being giant.
--- @class Component.gigantismDeathCurrencyDropOverride
--- @field currencyType string # `= "gold"` 
--- @field amount integer # `= 0` 

--- Possibly causes this entity to drop an item if it dies while being giant.
--- @class Component.gigantismDeathItemDropChance
--- @field itemName string # `= ""` 
--- @field probability number # `= 0` 
--- @field removeCurrencyDrop boolean # `= false` If true, when the item drops, no gold is dropped.

--- Status effect. The effects of being shrunk are determined purely by other components.
--- @class Component.dwarfism
--- @field remainingTurns integer # `= 0` 
--- @field permanent boolean # `= false` 
--- @field wasShrunk boolean # `= false` 

--- Prevents this entity from attacking while it is shrunk.
--- @class Component.dwarfismDisallowAttacks

--- Creates a flyaway when this entity becomes shrunk.
--- @class Component.dwarfismFlyaway
--- @field text localizedString # `= "Shrunk!"` 

--- Overrides this entity’s dig strength while it is shrunk.
--- @class Component.dwarfismDigStrengthOverride
--- @field strength Dig.Strength # `= dig.Strength.EARTH` 

--- Overrides this entity’s dig strength while it is shrunk.
--- @class Component.dwarfismIncomingDamageMultiplier
--- @field bypassFlags Damage.Flag # `= damage.Flag.SELF_DAMAGE` 
--- @field multiplier number # `= 2` 

--- Prevents this entity from being shrunk while it is giant.
--- @class Component.gigantismOverrideDwarfism

--- @class Entity
--- @field gigantism Component.gigantism
--- @field gigantismDigStrengthIncrease Component.gigantismDigStrengthIncrease
--- @field gigantismDigRadius Component.gigantismDigRadius
--- @field gigantismAttackDamageMultiplier Component.gigantismAttackDamageMultiplier
--- @field gigantismIncomingDamageMultiplier Component.gigantismIncomingDamageMultiplier
--- @field gigantismHealthMultiplier Component.gigantismHealthMultiplier
--- @field gigantismTileUnsinkImmunity Component.gigantismTileUnsinkImmunity
--- @field gigantismTileIdleDamageImmunity Component.gigantismTileIdleDamageImmunity
--- @field gigantismAttackableFlags Component.gigantismAttackableFlags
--- @field gigantismMoveFlags Component.gigantismMoveFlags
--- @field gigantismDeathCurrencyDropOverride Component.gigantismDeathCurrencyDropOverride
--- @field gigantismDeathItemDropChance Component.gigantismDeathItemDropChance
--- @field dwarfism Component.dwarfism
--- @field dwarfismDisallowAttacks Component.dwarfismDisallowAttacks
--- @field dwarfismFlyaway Component.dwarfismFlyaway
--- @field dwarfismDigStrengthOverride Component.dwarfismDigStrengthOverride
--- @field dwarfismIncomingDamageMultiplier Component.dwarfismIncomingDamageMultiplier
--- @field gigantismOverrideDwarfism Component.gigantismOverrideDwarfism

return SizeModifierComponents
