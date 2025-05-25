--- @meta

local ProvokableComponents = {}

--- "Provokable" entities change their behavior upon being provoked
--- @class Component.provokable
--- @field active boolean # `= false` 

--- This entity will be provoked upon taking any amount of damage
--- @class Component.provokeOnHit
--- @field physicalDamageOnly boolean # `= false` 
--- @field minimumDamage integer # `= 0` 

--- This entity will be provoked after taking earthquake damage.
--- @class Component.provokeOnEarthquake

--- This entity will be provoked upon an enemy entity trespassing its shop
--- @class Component.provokeOnTrespass

--- This entity will be provoked if it's close to its target
--- @class Component.provokeOnTargetDistance
--- @field distance number # `= 1` 

--- This entity will be provoked if it's close to a `provocationProximityTarget` when running every-frame checks
--- @class Component.provokeOnProximity
--- @field distance number # `= 1` 

--- This entity will be provoked if it's close to a `provocationProximityTarget` when attempting to move
--- @class Component.provokeOnProximityCheckMove
--- @field distance number # `= 1` 
--- @field inhibitMove boolean # `= false` 

--- Can be sensed by entities with `provokeOnProximity`
--- @class Component.provocationProximityTarget

--- This entity will be provoked when it stops being inside a wall
--- @class Component.provokeOnWallRemoval

--- This entity will be provoked when an unactivated shrine dies within its home area
--- @class Component.provokeOnShrineDeath

--- This entity will be provoked after being tickled.
--- @class Component.provokeOnTickle

--- Upon provocation, change this entity's AI
--- @class Component.provokableAIOverride
--- @field id integer # `= 0` 

--- Upon provocation, fear this entity if the attacker’s team doesn’t match
--- @class Component.provokableFearOtherTeams
--- @field team integer # `= 0` 
--- @field active boolean # `= false` 

--- Upon provocation, convert this entity to a different type
--- @class Component.provokableConvert
--- @field targetType string # `= ""` 

--- Upon provocation, changes this entity's attackability
--- @class Component.provokableAttackableFlags
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- Makes this entity non-targetable unless provoked
--- @class Component.provokableTargetable

--- Upon provocation, prevent this entity from acting until end of turn
--- @class Component.provokablePreventActions

--- Upon provocation, disable this entity’s shield
--- @class Component.provokableShieldBreak

--- Upon provocation, starts a secret room fight
--- @class Component.provokableStartFight
--- @field minDistance number # `= 2` 
--- @field maxDistance number # `= 4` 

--- Stuns this entity every turn while it is not provoked.
--- @class Component.sleepWhileUnprovoked
--- @field delay integer # `= 0` 

--- @class Entity
--- @field provokable Component.provokable
--- @field provokeOnHit Component.provokeOnHit
--- @field provokeOnEarthquake Component.provokeOnEarthquake
--- @field provokeOnTrespass Component.provokeOnTrespass
--- @field provokeOnTargetDistance Component.provokeOnTargetDistance
--- @field provokeOnProximity Component.provokeOnProximity
--- @field provokeOnProximityCheckMove Component.provokeOnProximityCheckMove
--- @field provocationProximityTarget Component.provocationProximityTarget
--- @field provokeOnWallRemoval Component.provokeOnWallRemoval
--- @field provokeOnShrineDeath Component.provokeOnShrineDeath
--- @field provokeOnTickle Component.provokeOnTickle
--- @field provokableAIOverride Component.provokableAIOverride
--- @field provokableFearOtherTeams Component.provokableFearOtherTeams
--- @field provokableConvert Component.provokableConvert
--- @field provokableAttackableFlags Component.provokableAttackableFlags
--- @field provokableTargetable Component.provokableTargetable
--- @field provokablePreventActions Component.provokablePreventActions
--- @field provokableShieldBreak Component.provokableShieldBreak
--- @field provokableStartFight Component.provokableStartFight
--- @field sleepWhileUnprovoked Component.sleepWhileUnprovoked

return ProvokableComponents
