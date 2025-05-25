--- @meta

local SpriteComponents = {}

--- @class Component.sprite
--- @field texture string # `= ""` 
--- @field width integer # `= 24` 
--- @field height integer # `= 24` 
--- @field x number # `= 0` 
--- @field y number # `= 0` 
--- @field textureShiftX integer # `= 0` 
--- @field textureShiftY integer # `= 0` 
--- @field scale number # `= 1` Computed field. Do not modify directly, use an `objectUpdateScale` handler instead.
--- @field mirrorX integer # `= 1` 1 = not horizontally mirrored, -1 = horizontally mirrored, other values are unsupported.
--- @field mirrorY integer # `= 1` 1 = not vertically mirrored, -1 = vertically mirrored, other values are unsupported.
--- @field color integer # `= -1` 
--- @field visible boolean # `= true` 
--- @field mirrorOffsetX integer # `= 0` Additional offset applied to the sprite while it is horizontally mirrored.
--- @field originX number # `= 0` Point around which the sprite is scaled.
--- @field originY number # `= 10` 

--- @class Component.extraSprite
--- @field texture string # `= ""` 
--- @field width integer # `= 24` 
--- @field height integer # `= 24` 
--- @field textureShiftX integer # `= 0` 
--- @field textureShiftY integer # `= 0` 
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field offsetZ number # `= 0` 
--- @field visible boolean # `= true` 

--- Displays another entity instead of this entity when it is seen inside a container (monocle).
--- @class Component.contentsSprite
--- @field name string # `= ""` 

--- @class Component.spriteSheet
--- @field frameX integer # `= 1` 
--- @field frameY integer # `= 1` 

--- @class Component.spriteSheetRowWrap
--- @field frames integer # `= 1` 

--- Marker component to indicate that this entity's spritesheet is left-facing by default, instead of right-facing
--- @class Component.spriteSheetLeftFacing

--- @class Component.silhouette
--- @field active boolean # `= false` 
--- @field inactiveFrameY integer # `= 1` 
--- @field activeFrameY integer # `= 2` 

--- Forces this entity to be silhouetted while intangible, instead of unsilhouetted
--- @class Component.silhouetteForceWhileIntangible

--- Allows cropping this entity’s sprite.
--- @class Component.croppedSprite
--- @field right integer # `= 0` 
--- @field top integer # `= 0` 
--- @field left integer # `= 0` 
--- @field bottom integer # `= 0` 

--- Allows rotating this entity’s sprite.
--- @class Component.rotatedSprite
--- @field originX number # `= 0` 
--- @field originY number # `= 0` 
--- @field angle number # `= 0` 

--- @class Component.shadow
--- @field texture string # `= "ext/entities/TEMP_shadow_standard.png"` 
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field offsetZ number # `= -900` 
--- @field originX number # `= 0` 
--- @field originY number # `= 10` 
--- @field scale number # `= 1` 
--- @field visible boolean # `= true` 

--- @class Component.shadowPosition
--- @field x number # `= 0` 
--- @field y number # `= 0` 

--- @class Component.visualExtent
--- @field x number # `= 0` 
--- @field y number # `= 0` 
--- @field z number # `= 0` 
--- @field width number # `= 24` 
--- @field height number # `= 24` 
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field offsetZ number # `= 0` 

--- Offset applied to this entity’s sprite in the legacy character selector.
--- (Unrelated to the actual lobby.)
--- @class Component.lobbyOffset
--- @field x number # `= 0` 
--- @field y number # `= 0` 

--- Stores the offsets for the entity’s sprite.
--- @class Component.positionalSprite
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 

--- Determiens when this entity is rendered. Higher z-order means this entity is rendered
--- later, and is thus "above" other entities.
--- @class Component.rowOrder
--- @field z number # `= 0` 

--- Decides this entity’s frameX at random when it spawns.
--- @class Component.spriteRandomVariant
--- @field variantCount integer # `= 0` 
--- @field frameX integer # `= 1` 

--- Decides this entity’s horizontal mirroring at random when it spawns.
--- @class Component.spriteRandomOrientation

--- Adds a random offset to this entity when it spawns.
--- @class Component.spriteRandomOffset
--- @field maxX integer # `= 0` 
--- @field maxY integer # `= 0` 
--- @field x integer # `= 0` 
--- @field y integer # `= 0` 

--- Resets any dynamic sprite changes whenever a resynchronization occurs (e.g. loading a saved game).
--- @class Component.spriteResetOnResync

--- Avoids recomputing this entity's sprite position per tick, improving performance for large entity counts.
--- @class Component.spriteStaticPosition

--- Allows showing an outline around this entity, controlled by the "Gold outline" setting.
--- @class Component.spriteGoldOutline

--- @class Entity
--- @field sprite Component.sprite
--- @field extraSprite Component.extraSprite
--- @field contentsSprite Component.contentsSprite
--- @field spriteSheet Component.spriteSheet
--- @field spriteSheetRowWrap Component.spriteSheetRowWrap
--- @field spriteSheetLeftFacing Component.spriteSheetLeftFacing
--- @field silhouette Component.silhouette
--- @field silhouetteForceWhileIntangible Component.silhouetteForceWhileIntangible
--- @field croppedSprite Component.croppedSprite
--- @field rotatedSprite Component.rotatedSprite
--- @field shadow Component.shadow
--- @field shadowPosition Component.shadowPosition
--- @field visualExtent Component.visualExtent
--- @field lobbyOffset Component.lobbyOffset
--- @field positionalSprite Component.positionalSprite
--- @field rowOrder Component.rowOrder
--- @field spriteRandomVariant Component.spriteRandomVariant
--- @field spriteRandomOrientation Component.spriteRandomOrientation
--- @field spriteRandomOffset Component.spriteRandomOffset
--- @field spriteResetOnResync Component.spriteResetOnResync
--- @field spriteStaticPosition Component.spriteStaticPosition
--- @field spriteGoldOutline Component.spriteGoldOutline

return SpriteComponents
