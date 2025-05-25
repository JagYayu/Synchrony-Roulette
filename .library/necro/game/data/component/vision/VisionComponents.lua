--- @meta

local VisionComponents = {}

--- Grants vision to tiles within line-of-sight.
--- @class Component.visionRaycast
--- @field active boolean # `= false` 
--- @field fovMask Vision.FoV, vision.FoV.mask(vision.FoV.DEFAULT # `= vision.FoV.UNSILHOUETTE)` 

--- Grants vision to nearby tiles, even through walls.
--- @class Component.visionRadial
--- @field radius integer # `= 0` 
--- @field active boolean # `= false` 
--- @field fovMask Vision.FoV # `= vision.FoV.DEFAULT` 

--- Grants vision to nearby tiles, even through walls. Scales with the holder’s groove chain.
--- @class Component.visionRadialGrooveChain
--- @field radiusBase integer # `= 0` 
--- @field radiusMultiplier integer # `= 0` 

--- Limits vision effects from the holder and all of the holder’s other items.
--- @class Component.itemBlockVision
--- @field fovMask Vision.FoV # `= vision.FoV.DEFAULT` 

--- Prevents this item from giving vision while it is not held.
--- @class Component.enableVisionOnPickup

--- @class Entity
--- @field visionRaycast Component.visionRaycast
--- @field visionRadial Component.visionRadial
--- @field visionRadialGrooveChain Component.visionRadialGrooveChain
--- @field itemBlockVision Component.itemBlockVision
--- @field enableVisionOnPickup Component.enableVisionOnPickup

return VisionComponents
