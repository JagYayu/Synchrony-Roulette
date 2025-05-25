--- @meta

local MinimapComponents = {}

--- Displays this entity on the minimap.
--- @class Component.minimapStaticPixel
--- @field depth MinimapTheme.Depth # `= minimapTheme.Depth.NONE` 
--- @field color integer # `= 0` 
--- @field alwaysVisible boolean # `= true` 

--- Displays this entity on the minimap, but make it blink if it’s focused.
--- @class Component.minimapBlinkingPixel
--- @field texture string # `= ""` 
--- @field visible boolean # `= true` 

--- Specific to the "Nocturna minimap" quirk.
--- @class Component.minimapPersistColorPreConvert
--- @field color integer # `= minimapTheme.Color.ENEMY` 

--- @class Entity
--- @field minimapStaticPixel Component.minimapStaticPixel
--- @field minimapBlinkingPixel Component.minimapBlinkingPixel
--- @field minimapPersistColorPreConvert Component.minimapPersistColorPreConvert

return MinimapComponents
