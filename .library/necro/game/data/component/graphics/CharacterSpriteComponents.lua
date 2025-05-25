--- @meta

local CharacterSpriteComponents = {}

--- Maps this entity's health and cursed health to half hearts (using player-style heart sprites)
--- @class Component.healthBarHalfHearts

--- Maps this entity's health to full hearts (using enemy-style heart sprites)
--- @class Component.healthBarFullHearts

--- Displays this entity's health bar above it in the world
--- @class Component.healthBar
--- @field visible boolean # `= false` 
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field spacingX number # `= 0` 
--- @field spacingY number # `= 0` 
--- @field columns integer # `= 10` 
--- @field alignRight boolean # `= false` 

--- Hides this entity's in-world health bar while its health is at maximum
--- @class Component.healthBarHideOnFullHealth
--- @field overridable boolean # `= true` 

--- Always shows this entity's in-world health bar once it has taken damage
--- @class Component.healthBarShowOnDamage
--- @field visible boolean # `= false` 

--- Hides this entity's in-world health bar if player health bars are disabled
--- @class Component.healthBarHideByPlayerSetting

--- Displays this entity's health bar in the HUD
--- @class Component.healthBarHUD

--- Defines the image shown when selecting this entity in training mode.
--- @class Component.bestiary
--- @field image string # `= ""` 
--- @field focusX number # `= 0` 
--- @field focusY number # `= 0` 

--- Specific to ogres.
--- @class Component.clonkingSprite
--- @field sprites table # 

--- Defines a sprite that can be used by `useCloneSprite` entities.
--- @class Component.cloneSprite
--- @field texture string # `= ""` 
--- @field width integer # `= 24` 
--- @field height integer # `= 24` 
--- @field offsetX integer # `= 0` 
--- @field offsetY integer # `= 0` 
--- @field mirrorOffsetX integer # `= 0` 

--- Overrides this entity’s sprite, copying from a random entity’s `cloneSprite`.
--- @class Component.useCloneSprite

--- Draws an outline around this entity if it’s silhouetted and standing on a revealed tile.
--- The outline’s intensity is controlled by the "Enemy outlines" setting.
--- @class Component.silhouetteOutline

--- Displays a target indicator around this entity whenever its target change.
--- @class Component.targetRing

--- Always displays a target indicator around this entity.
--- @class Component.targetRingPermanent

--- @class Component.spriteUniqueIndex
--- @field key string # `= ""` 
--- @field index integer # `= 0` 

--- @class Entity
--- @field healthBarHalfHearts Component.healthBarHalfHearts
--- @field healthBarFullHearts Component.healthBarFullHearts
--- @field healthBar Component.healthBar
--- @field healthBarHideOnFullHealth Component.healthBarHideOnFullHealth
--- @field healthBarShowOnDamage Component.healthBarShowOnDamage
--- @field healthBarHideByPlayerSetting Component.healthBarHideByPlayerSetting
--- @field healthBarHUD Component.healthBarHUD
--- @field bestiary Component.bestiary
--- @field clonkingSprite Component.clonkingSprite
--- @field cloneSprite Component.cloneSprite
--- @field useCloneSprite Component.useCloneSprite
--- @field silhouetteOutline Component.silhouetteOutline
--- @field targetRing Component.targetRing
--- @field targetRingPermanent Component.targetRingPermanent
--- @field spriteUniqueIndex Component.spriteUniqueIndex

return CharacterSpriteComponents
