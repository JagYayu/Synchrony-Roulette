--- @meta

local PerspectiveComponents = {}

--- Unused.
--- @class Component.limitTileVisionRadius
--- @field radius number # `= 0` 

--- Unused.
--- @class Component.limitObjectVisionRadius
--- @field radius number # `= 0` 

--- Unused.
--- @class Component.limitTileVisionRadiusToActivationRange
--- @field minimumRadius number # `= 2.5` 

--- Unused.
--- @class Component.limitObjectVisionRadiusToActivationRange
--- @field minimumRadius number # `= 2.5` 

--- Unused.
--- @class Component.forceAllTileVision

--- Makes entities with a given component always visible.
--- (Perspective components only take effect when this entity has PERSPECTIVE focus, see `Focus.Flag`).
--- @class Component.forceObjectVision
--- @field component string # `= "sprite"` 

--- Unsilhouettes entities with a given component.
--- @class Component.forceNonSilhouetteVision
--- @field component string # `= "silhouette"` 

--- Makes entities with a given component visible on the minimap while this entity is focused.
--- @class Component.minimapVision
--- @field component string # `= ""` 

--- Specific to nightmares.
--- @class Component.perspectiveInvertShadows

--- Shows outlines around gold coins, controlled by the "Gold outline" setting.
--- @class Component.perspectiveGoldOutline

--- Makes carrots work.
--- @class Component.temporaryLevelTileVision
--- @field active boolean # `= false` 

--- @class Entity
--- @field limitTileVisionRadius Component.limitTileVisionRadius
--- @field limitObjectVisionRadius Component.limitObjectVisionRadius
--- @field limitTileVisionRadiusToActivationRange Component.limitTileVisionRadiusToActivationRange
--- @field limitObjectVisionRadiusToActivationRange Component.limitObjectVisionRadiusToActivationRange
--- @field forceAllTileVision Component.forceAllTileVision
--- @field forceObjectVision Component.forceObjectVision
--- @field forceNonSilhouetteVision Component.forceNonSilhouetteVision
--- @field minimapVision Component.minimapVision
--- @field perspectiveInvertShadows Component.perspectiveInvertShadows
--- @field perspectiveGoldOutline Component.perspectiveGoldOutline
--- @field temporaryLevelTileVision Component.temporaryLevelTileVision

return PerspectiveComponents
