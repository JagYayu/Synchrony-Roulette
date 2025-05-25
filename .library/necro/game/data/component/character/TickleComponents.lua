--- @meta

local TickleComponents = {}

--- Drops this entity’s contents when it is tickled (requires `storage`).
--- @class Component.tickleScatterStorage

--- Grants kill credit to the attacker when this entity is tickled (see `Kill.credit`).
--- Any flag that is in `grant` but not `remove` can be infinitely farmed by repeatedly tickling.
--- @class Component.tickleGrantKillCredit
--- @field grant Kill.Credit, kill.Credit.mask(kill.Credit.CURRENCY, kill.Credit.GROOVE_CHAIN # `= kill.Credit.SPELL_COOLDOWN)` 
--- @field remove Kill.Credit, kill.Credit.mask(kill.Credit.CURRENCY # `= kill.Credit.SPELL_COOLDOWN)` 

--- Inflicts damage to this entity when it is tickled.
--- @class Component.tickleTakeDamage

--- Counts how many times this entity has been tickled.
--- @class Component.tickleCounter
--- @field count integer # `= 0` 

--- Converts the entity when tickled.
--- @class Component.tickleConvert
--- @field targetType string # `= ""` 

--- Defeats the boss entity when tickled, ending the boss fight.
--- @class Component.tickleDefeatBoss

--- @class Entity
--- @field tickleScatterStorage Component.tickleScatterStorage
--- @field tickleGrantKillCredit Component.tickleGrantKillCredit
--- @field tickleTakeDamage Component.tickleTakeDamage
--- @field tickleCounter Component.tickleCounter
--- @field tickleConvert Component.tickleConvert
--- @field tickleDefeatBoss Component.tickleDefeatBoss

return TickleComponents
