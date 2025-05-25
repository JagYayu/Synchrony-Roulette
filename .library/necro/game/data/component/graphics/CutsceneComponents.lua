--- @meta

local CutsceneComponents = {}

--- @class Component.creditsAppearance
--- @field order number # `= 0` 
--- @field punnyName localizedString # `= 0` 

--- @class Component.creditsSpriteOffset
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field offsetZ number # `= 0` 

--- @class Component.creditsAppearanceFacingOverride
--- @field direction integer # `= 0` 

--- @class Component.creditsEnvironmentTiles
--- @field tileset string # `= "Zone1"` 
--- @field minX integer # `= -2` 
--- @field minY integer # `= -2` 
--- @field maxX integer # `= 2` 
--- @field maxY integer # `= 2` 

--- @class Component.creditsEnvironmentTilesCustom
--- @field tiles table # 

--- @class Component.creditsEnvironmentEntities
--- @field actors table # 

--- @class Component.creditsIgnoreTellAnimation

--- @class Component.creditsWalkDiagonally

--- @class Entity
--- @field creditsAppearance Component.creditsAppearance
--- @field creditsSpriteOffset Component.creditsSpriteOffset
--- @field creditsAppearanceFacingOverride Component.creditsAppearanceFacingOverride
--- @field creditsEnvironmentTiles Component.creditsEnvironmentTiles
--- @field creditsEnvironmentTilesCustom Component.creditsEnvironmentTilesCustom
--- @field creditsEnvironmentEntities Component.creditsEnvironmentEntities
--- @field creditsIgnoreTellAnimation Component.creditsIgnoreTellAnimation
--- @field creditsWalkDiagonally Component.creditsWalkDiagonally

return CutsceneComponents
