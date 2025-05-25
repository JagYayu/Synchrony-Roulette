--- @meta

local MusicComponents = {}

--- Increases the volume of a music layer while the listener is near this entity
--- @class Component.musicLayerAddVolume
--- @field active boolean # `= true` 
--- @field effective boolean # `= false` 
--- @field layerTag integer # `= 0` 
--- @field innerRadius number # `= 0` 
--- @field outerRadius number # `= 1` 
--- @field innerVolume number # `= 1` 
--- @field outerVolume number # `= 1` 

--- Multiplies the music layer modifier's minimum and maximum volume by the "Shopkeeper volume" setting
--- @class Component.musicLayerApplyVolumeSettings

--- Multiplies the music layer modifier's inner and outer radii by the "Shopkeeper distance multiplier" setting
--- @class Component.musicLayerApplyRadiusSettings

--- Reduces the volume added by `musicLayerAddVolume` if this entity is in a separate, closed-off room
--- @class Component.musicLayerCheckOpenRoom
--- @field volume number # `= 1` 

--- Overrides the song's vocal track type if this entity exists at the start of the level
--- @class Component.musicLayerVocalOverride
--- @field vocals string # `= ""` 

--- Converts this entity based on the local player's vocal settings
--- @class Component.upgradeByVocalSettings
--- @field upgrades table # 

--- Upon provocation, disables any active music layer modifiers
--- @class Component.musicLayerDeactivateOnProvoke

--- Creates flyaways at timings determined by this entity’s music layer.
--- @class Component.musicLayerFlyaway
--- @field text string # `= ui.Symbol.EIGHTH_NOTES` 

--- @class Entity
--- @field musicLayerAddVolume Component.musicLayerAddVolume
--- @field musicLayerApplyVolumeSettings Component.musicLayerApplyVolumeSettings
--- @field musicLayerApplyRadiusSettings Component.musicLayerApplyRadiusSettings
--- @field musicLayerCheckOpenRoom Component.musicLayerCheckOpenRoom
--- @field musicLayerVocalOverride Component.musicLayerVocalOverride
--- @field upgradeByVocalSettings Component.upgradeByVocalSettings
--- @field musicLayerDeactivateOnProvoke Component.musicLayerDeactivateOnProvoke
--- @field musicLayerFlyaway Component.musicLayerFlyaway

return MusicComponents
