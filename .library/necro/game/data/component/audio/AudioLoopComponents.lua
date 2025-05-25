--- @meta

local AudioLoopComponents = {}

--- Defines an audio loop associated with this entity.
--- This does nothing unless the loop is played by another component.
--- @class Component.audioLoop
--- @field soundID integer # `= 0` For internal use.
--- @field sound string # `= ""` 
--- @field volume number # `= 1` 
--- @field useHighestVolume boolean # `= true` 

--- Plays this entity’s `audioLoop` when it spawns.
--- @class Component.audioLoopPlayOnSpawn

--- Plays this entity’s `audioLoop` when it takes damage.
--- @class Component.audioLoopPlayOnHit

--- Limits this entity’s `audioLoop` to be audible only by the latest entity to have damaged it.
--- @class Component.audioLoopAffectAttacker
--- @field target Entity.ID # 
--- @field flyaway localizedString # `= 0` 

--- Stops this entity’s `audioLoop` when it spawns.
--- @class Component.audioLoopStopOnTickle

--- @class Entity
--- @field audioLoop Component.audioLoop
--- @field audioLoopPlayOnSpawn Component.audioLoopPlayOnSpawn
--- @field audioLoopPlayOnHit Component.audioLoopPlayOnHit
--- @field audioLoopAffectAttacker Component.audioLoopAffectAttacker
--- @field audioLoopStopOnTickle Component.audioLoopStopOnTickle

return AudioLoopComponents
