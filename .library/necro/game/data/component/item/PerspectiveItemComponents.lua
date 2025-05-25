--- @meta

local PerspectiveItemComponents = {}

--- Causes perspective to update when this item is equipped or unequipped.
--- Perspective only applies to the holder and players spectating the holder.
--- @class Component.itemPerspectiveModifier

--- Hides all tiles beyond a given distance to the holder.
--- @class Component.itemLimitTileVisionRadius
--- @field radius number # `= 0` Inclusive maximum L2 distance.

--- Unused.
--- @class Component.itemLimitObjectVisionRadius
--- @field radius number # `= 0` Inclusive maximum L2 distance.

--- Shows the entire map.
--- @class Component.itemGrantAllTileVision

--- Shows all tiles matching the given flag.
--- @class Component.itemGrantTileVision
--- @field tileFlag string # `= ""` 
--- @field illuminate boolean # `= false` If true, matching tiles are shown at maximum brightness (100%). Otherwise, they use the default brightness for revealed tiles (36%).

--- @class Component.itemTileBrightnessChangeRateMultiplier
--- @field multiplier number # `= 1` 

--- Shows an arrow pointing to a given tile marker (like the compass does).
--- @class Component.itemShowTileTargetPointer
--- @field marker integer # `= 0` 

--- Makes some entities visible, regardless of light and line-of-sight.
--- To avoid entities rendering as black silhouettes on a black background,
--- this is usually combined with `itemForceNonSilhouetteVision`.
--- @class Component.itemGrantObjectVision
--- @field component string # `= ""` Only entities with this component are affected.

--- Displays the contents of some containers.
--- @class Component.itemGrantContentsVision
--- @field component string # `= ""` Only containers with that component have their contents displayed. There is currently no way to filter on the contents themselves.

--- Forces some entities to be unsilhouetted.
--- @class Component.itemForceNonSilhouetteVision
--- @field component string # `= ""` Only entities with this component are affected.

--- Forces some entities to be silhouetted. This takes priority over `itemForceNonSilhouetteVision`.
--- @class Component.itemForceSilhouetteVision
--- @field component string # `= ""` Only entities with this component are affected.

--- Shows some entities on the minimap.
--- @class Component.itemGrantMinimapVision
--- @field component string # `= ""` Only entities with this component are affected.

--- Specific to carrots.
--- @class Component.consumableGrantTemporaryLevelTileVision

--- @class Entity
--- @field itemPerspectiveModifier Component.itemPerspectiveModifier
--- @field itemLimitTileVisionRadius Component.itemLimitTileVisionRadius
--- @field itemLimitObjectVisionRadius Component.itemLimitObjectVisionRadius
--- @field itemGrantAllTileVision Component.itemGrantAllTileVision
--- @field itemGrantTileVision Component.itemGrantTileVision
--- @field itemTileBrightnessChangeRateMultiplier Component.itemTileBrightnessChangeRateMultiplier
--- @field itemShowTileTargetPointer Component.itemShowTileTargetPointer
--- @field itemGrantObjectVision Component.itemGrantObjectVision
--- @field itemGrantContentsVision Component.itemGrantContentsVision
--- @field itemForceNonSilhouetteVision Component.itemForceNonSilhouetteVision
--- @field itemForceSilhouetteVision Component.itemForceSilhouetteVision
--- @field itemGrantMinimapVision Component.itemGrantMinimapVision
--- @field consumableGrantTemporaryLevelTileVision Component.consumableGrantTemporaryLevelTileVision

return PerspectiveItemComponents
