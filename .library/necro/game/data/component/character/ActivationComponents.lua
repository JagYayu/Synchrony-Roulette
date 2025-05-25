--- @meta

local ActivationComponents = {}

--- Non-player entities with this component can only act if they’re either aggroed
--- or within activation range (see `activationRange`).
--- @class Component.aggro
--- @field active boolean # `= false` Whether this entity is currently aggroed.

--- Causes this entity to become aggroed when it is revealed. This is the most common aggro condition.
--- @class Component.aggroOnReveal

--- Causes this entity to become aggroed when it moves.
--- @class Component.aggroOnMove

--- Causes this entity to become aggroed immediately when spawning in a secret room.
--- @class Component.aggroOnSecretRoomSpawn

--- Decreases this entity’s beatDelay.counter when it aggroed.
--- @class Component.aggroSetBeatDelay

--- Causes this entity to become unaggroed when its confusion status ends.
--- @class Component.deaggroOnUnconfuse
--- @field active boolean # `= false` 

--- Non-player entities can only act if they’re either aggroed or within activation range (see `aggro`).
--- @class Component.activationRange
--- @field radius integer # `= 3` Inclusive maximum L2 distance from its target at which this entity is considered "in activation range".

--- Makes this entity active on every turn, regardless of player input.
--- @class Component.alwaysActive

--- Makes this entity copy its activation from a player (by default, the nearest one).
--- @class Component.copyActivation
--- @field activator Entity.ID # 

--- Makes this entity copy its activation from its caster instead of the nearest player.
--- Requires `copyActivation` and `spawnable`.
--- @class Component.copyActivationFromCaster

--- Makes this entity copy its activation from the boss.
--- @class Component.copyActivationFromBoss

--- @class Entity
--- @field aggro Component.aggro
--- @field aggroOnReveal Component.aggroOnReveal
--- @field aggroOnMove Component.aggroOnMove
--- @field aggroOnSecretRoomSpawn Component.aggroOnSecretRoomSpawn
--- @field aggroSetBeatDelay Component.aggroSetBeatDelay
--- @field deaggroOnUnconfuse Component.deaggroOnUnconfuse
--- @field activationRange Component.activationRange
--- @field alwaysActive Component.alwaysActive
--- @field copyActivation Component.copyActivation
--- @field copyActivationFromCaster Component.copyActivationFromCaster
--- @field copyActivationFromBoss Component.copyActivationFromBoss

return ActivationComponents
