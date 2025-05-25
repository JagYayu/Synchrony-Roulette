--- @meta

local TileInteractionComponents = {}

--- Deletes this entity if the tile it’s on is changed to a floor.
--- @class Component.despawnOnWallRemoval

--- Deletes this entity if the tile it’s on is changed in any way.
--- @class Component.despawnOnTileChange

--- Makes this entity intangible while inside a cracked wall.
--- @class Component.intangibleInWalls

--- Makes this entity sink in liquid tiles.
--- @class Component.sinkable
--- @field sunken boolean # `= false` Whether this entity is currently sunken in a liquid tile. Protected field! Do not modify directly, use `Sink.updateSunken` or `Sink.unsink` instead.
--- @field unsinkOnForcedMove boolean # `= false` Whether this entity can unsink when moved forcefully (knockback, wind, etc). This is normally true for players, false for enemies.

--- Lets this entity move out of liquids without slowing down.
--- @class Component.unsinkImmunity

--- Makes this entity take damage when standing on hot coals tiles.
--- @class Component.tileIdleDamageReceiver
--- @field idleTurnCount integer # `= 0` 

--- Makes this entity shrink on goo tiles.
--- @class Component.tileDwarfismReceiver

--- Causes this entity to take damage when moving into lava tiles.
--- @class Component.lavable

--- Lets this entity benefit from electricity from all sources, including wire tiles.
--- @class Component.wired
--- @field level integer # `= 0` Current wire level of this entity. Computed field. Do not modify directly, use an `objectUpdateWireLevel` handler instead.
--- @field attackFlags Attack.Flag # `= attack.Flag.DEFAULT` 

--- Makes this entity’s facing follow any wires it’s walking on.
--- @class Component.wiredRotate
--- @field turnAround boolean # `= false` If true, this entity will use its next action to do a 180° turn instead of moving.

--- Modifies this entity’s speed (`beatDelay.interval`) depending on its wire level.
--- @class Component.wiredBeatDelay
--- @field lastLevel integer # `= 0` 

--- Protects this entity from non-wired damage sources as long as it’s wired.
--- @class Component.wiredShield
--- @field bypassFlags Damage.Flag, damage.Flag.mask(damage.Flag.BYPASS_INVINCIBILITY # `= damage.Flag.ELECTRIC)` 
--- @field sound string # `= ""` 

--- Modifies damage dealt by this entity while on a wire.
--- @class Component.wiredDamageTypeModifier
--- @field requiredFlags Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field addedFlags Damage.Flag # `= damage.Flag.ELECTRIC` 

--- Lets electric arcs propagate through this entity.
--- @class Component.conductive
--- @field canStartArc boolean # `= true` Whether attacking this entity creates an electric arc.

--- Makes this entity count as a tile for the purpose of connectivity checks (doors, etc).
--- @class Component.tileConnectivity
--- @field flag string # `= ""` 

--- Uses a "lazy" logic for removing electric flashes created by this entity.
--- This improves performance, but can cause the flash to visually last longer than normal.
--- @class Component.wireFlashLazyDelay

--- @class Entity
--- @field despawnOnWallRemoval Component.despawnOnWallRemoval
--- @field despawnOnTileChange Component.despawnOnTileChange
--- @field intangibleInWalls Component.intangibleInWalls
--- @field sinkable Component.sinkable
--- @field unsinkImmunity Component.unsinkImmunity
--- @field tileIdleDamageReceiver Component.tileIdleDamageReceiver
--- @field tileDwarfismReceiver Component.tileDwarfismReceiver
--- @field lavable Component.lavable
--- @field wired Component.wired
--- @field wiredRotate Component.wiredRotate
--- @field wiredBeatDelay Component.wiredBeatDelay
--- @field wiredShield Component.wiredShield
--- @field wiredDamageTypeModifier Component.wiredDamageTypeModifier
--- @field conductive Component.conductive
--- @field tileConnectivity Component.tileConnectivity
--- @field wireFlashLazyDelay Component.wireFlashLazyDelay

return TileInteractionComponents
