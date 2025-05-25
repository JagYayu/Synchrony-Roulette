--- @meta

local VisibilityComponents = {}

--- @class Component.visibility
--- @field visible boolean # `= false` Whether this entity is currently visible. This can change back and forth.
--- @field revealed boolean # `= true` Whether this entity is revealed. Once revealed, it will stay revealed forever.
--- @field fullyVisible boolean # `= false` 

--- Reveals this entity when it is on a visible and lit tile. Most entities have this.
--- @class Component.visibilityRevealWhenLit

--- Allows this entity to be seen by `proximityVision`. Most entities have this.
--- @class Component.visibilityVisibleOnProximity

--- Makes this entity always visible.
--- @class Component.visibilityAlwaysVisible

--- Makes this entity never visible.
--- @class Component.visibilityAlwaysHidden

--- Makes this entity visible while it is on a revealed tile.
--- @class Component.visibleOnRevealedTile

--- Hides entities with a given component on the same tile as this entity.
--- @class Component.visibilityHideEntities
--- @field component string # `= ""` 

--- Prevents this entity from being automatically revealed during ambushes.
--- @class Component.visibilityNoAmbushReveal

--- Allows this entity to be visible across segments.
--- @class Component.visibilityIgnoreSegments

--- Remembers the past visibility of this entity
--- (used to prevent yetis clapping immediately after becoming visible).
--- @class Component.pastVisibility
--- @field wasVisible boolean # `= false` 

--- Makes nearby entities visible. This doesn’t work through walls, and doesn’t reveal the entities.
--- @class Component.proximityVision
--- @field distance number # `= 4` 

--- Reveals nearby `hiddenUntilProximity` entities.
--- @class Component.proximityReveal
--- @field distance number # `= 1` Inclusive maximum L2 distance.

--- Makes this entity invisible until a `proximityReveal` entity moves near it.
--- @class Component.hiddenUntilProximity
--- @field hidden boolean # `= false` 
--- @field sound string # `= ""` 

--- Marker component.
--- @class Component.visibleByTelepathy

--- Marker component.
--- @class Component.visibleByForesight

--- Marker component.
--- @class Component.visibleByMonocle

--- Marker component.
--- @class Component.contentsVisibleByMonocle

--- @class Entity
--- @field visibility Component.visibility
--- @field visibilityRevealWhenLit Component.visibilityRevealWhenLit
--- @field visibilityVisibleOnProximity Component.visibilityVisibleOnProximity
--- @field visibilityAlwaysVisible Component.visibilityAlwaysVisible
--- @field visibilityAlwaysHidden Component.visibilityAlwaysHidden
--- @field visibleOnRevealedTile Component.visibleOnRevealedTile
--- @field visibilityHideEntities Component.visibilityHideEntities
--- @field visibilityNoAmbushReveal Component.visibilityNoAmbushReveal
--- @field visibilityIgnoreSegments Component.visibilityIgnoreSegments
--- @field pastVisibility Component.pastVisibility
--- @field proximityVision Component.proximityVision
--- @field proximityReveal Component.proximityReveal
--- @field hiddenUntilProximity Component.hiddenUntilProximity
--- @field visibleByTelepathy Component.visibleByTelepathy
--- @field visibleByForesight Component.visibleByForesight
--- @field visibleByMonocle Component.visibleByMonocle
--- @field contentsVisibleByMonocle Component.contentsVisibleByMonocle

return VisibilityComponents
