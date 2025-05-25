--- @meta

local LightComponents = {}

--- Fires the `lightSourceUpdate` event whenever necessary (on move, tangible, equip, etc).
--- All components that grant light or vision should declare this as a dependency.
--- @class Component.lightSource

--- Emits light around this entity.
--- @class Component.lightSourceRadial
--- @field innerRadius integer # `= 0` Anything within the inner radius is fully lit. Protected field! Do not modify directly, use `LightSource.setRadius` instead.
--- @field outerRadius integer # `= 0` Anything beyond the outer radius receives no light at all Protected field! Do not modify directly, use `LightSource.setRadius` instead.
--- @field active boolean # `= false` Protected field! Do not modify directly, use `LightSource.update` instead.
--- @field brightness integer # `= vision.BRIGHTNESS_LIGHT_SOURCE` 

--- Changes this item’s `lightSourceRadial` properties depending on whether it’s held or dropped.
--- @class Component.lightSourceRadialHoldable
--- @field innerRadiusHeld integer # `= 0` 
--- @field outerRadiusHeld integer # `= 0` 
--- @field innerRadiusDropped integer # `= 0` 
--- @field outerRadiusDropped integer # `= 0` 

--- Darkens tiles and silhouettes entities around this entity. No gameplay effect.
--- @class Component.shadowSource
--- @field radius integer # `= 0` 
--- @field active boolean # `= true` 

--- Prevents this light source from being disabled by Shrine of Darkness.
--- @class Component.lightSourceIgnoreDarkness

--- Marker component.
--- @class Component.wallLight

--- @class Entity
--- @field lightSource Component.lightSource
--- @field lightSourceRadial Component.lightSourceRadial
--- @field lightSourceRadialHoldable Component.lightSourceRadialHoldable
--- @field shadowSource Component.shadowSource
--- @field lightSourceIgnoreDarkness Component.lightSourceIgnoreDarkness
--- @field wallLight Component.wallLight

return LightComponents
