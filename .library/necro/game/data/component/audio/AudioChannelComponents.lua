--- @meta

local AudioChannelComponents = {}

--- @class Component.audioChannel
--- @field mask AudioChannel.Flag # `= audioChannel.Flag.SOURCE_OBJECT` 

--- @class Component.audioChannelApplyToDigFail
--- @field mask integer # `= 0` 

--- @class Component.audioChannelApplyToVoice
--- @field mask AudioChannel.Flag # `= audioChannel.Flag.VOCALIZATION_ANY` 

--- @class Component.audioChannelApplyToSpellcast
--- @field mask integer # `= 0` 

--- @class Component.audioChannelSpellcastIgnoreCaster

--- @class Entity
--- @field audioChannel Component.audioChannel
--- @field audioChannelApplyToDigFail Component.audioChannelApplyToDigFail
--- @field audioChannelApplyToVoice Component.audioChannelApplyToVoice
--- @field audioChannelApplyToSpellcast Component.audioChannelApplyToSpellcast
--- @field audioChannelSpellcastIgnoreCaster Component.audioChannelSpellcastIgnoreCaster

return AudioChannelComponents
