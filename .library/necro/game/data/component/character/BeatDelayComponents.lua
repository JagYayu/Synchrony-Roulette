--- @meta

local BeatDelayComponents = {}

--- Slows down this entity.
--- While beatDelay is non-0, this entity only performs IDLE actions (this can be bypassed in some cases).
--- Any action with a result other than FAIL ticks down the beat delay, wrapping back from 0 to `interval` - 1.
--- @class Component.beatDelay
--- @field interval integer # `= 1` 
--- @field counter integer # `= 0` 

--- Specific to spiders.
--- @class Component.failOnIdle

--- Prevents this entity from acting for a set number of beats.
--- @class Component.stun
--- @field counter integer # `= 0` Remaining number of stun beats.

--- Allows this entity to ignore beat delay for certain actions if it is player-controlled.
--- @class Component.beatDelayBypass
--- @field actions table # Set of actions.

--- Tracks the number of beats (turns where this entity has been active) since the start of the floor.
--- @class Component.beatCounter
--- @field counter integer # `= 0` 

--- Overrides beat delay before converting from this type to another type.
--- @class Component.preConvertBeatDelay
--- @field counter integer # `= 0` 

--- Overrides beat delay after converting from another type to this type.
--- @class Component.postConvertBeatDelay
--- @field counter integer # `= 0` 

--- Causes this entity to become stunned after certain action results.
--- @class Component.stunOnResults
--- @field duration table # Maps move results => stun durations

--- Causes this entity to become stunned when its charge ends.
--- @class Component.stunOnChargeEnd
--- @field duration integer # `= 2` 

--- Adds a delay to specific actions.
--- When this entity attempts one of those actions, it will instead queue the action to be
--- performed a given number of beats later.
--- This action delay ticks down independently from beat delay.
--- @class Component.actionDelay
--- @field actions table # Only the actions that are keys in this table are delayed. Maps action => table with the following fields:  * delay: number of beats the action is delayed by, minus one (default = 0, meaning it’s delayed by one beat) * beatDelay: sets this entity’s beat delay when this action is queued (optional) * facing: sets this entity’s facing direction when this action is queued (optional) * sound: sound played when this action is queued (optional)
--- @field delay integer # `= 0` Remaining number of beats until the queued action is performed.
--- @field currentAction integer # `= 0` Currently queued action. IDLE (0) means no action is queued.

--- Prevents actionDelay from ticking down on beats where this entity has beat delay.
--- @class Component.actionDelayRespectBeatDelay

--- @class Entity
--- @field beatDelay Component.beatDelay
--- @field failOnIdle Component.failOnIdle
--- @field stun Component.stun
--- @field beatDelayBypass Component.beatDelayBypass
--- @field beatCounter Component.beatCounter
--- @field preConvertBeatDelay Component.preConvertBeatDelay
--- @field postConvertBeatDelay Component.postConvertBeatDelay
--- @field stunOnResults Component.stunOnResults
--- @field stunOnChargeEnd Component.stunOnChargeEnd
--- @field actionDelay Component.actionDelay
--- @field actionDelayRespectBeatDelay Component.actionDelayRespectBeatDelay

return BeatDelayComponents
