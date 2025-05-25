--- @meta

local AudioFilterComponents = {}

--- Defines an audio filter associated with this entity.
--- This does nothing unless the filter is applied by another component.
--- @class Component.audioFilter
--- @field soundGain number # `= 1` 
--- @field soundGainHF number # `= 1` 
--- @field soundGainLF number # `= 1` 
--- @field musicGain number # `= 1` 
--- @field musicGainHF number # `= 1` 
--- @field musicGainLF number # `= 1` 

--- Applies this entity’s `audioFilter` to the latest entity to have damaged it.
--- @class Component.audioFilterAffectAttacker
--- @field target Entity.ID # 

--- @class Entity
--- @field audioFilter Component.audioFilter
--- @field audioFilterAffectAttacker Component.audioFilterAffectAttacker

return AudioFilterComponents
