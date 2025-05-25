--- @meta

local AttachmentComponents = {}

--- Marks this entity as an attachment. Attachments follow their parent entity everywhere.
--- @class Component.attachment
--- @field parent Entity.ID # 

--- Causes this entity to copy the visibility of its parent entity.
--- Requires `attachment` to work.
--- @class Component.attachmentCopyVisibility

--- Causes this entity to copy the sprite position of its parent entity, with an optional offset.
--- Requires `attachment` to work.
--- @class Component.attachmentCopySpritePosition
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field offsetZ number # `= 0` 

--- Causes this entity to copy the scale, mirroring, color, crop, and rotation of its parent entity.
--- Requires `attachment` to work.
--- @class Component.attachmentCopySpriteEffects

--- Causes this entity to copy the animation frame of its parent entity.
--- Requires `attachment` to work.
--- @class Component.attachmentCopyAnimation

--- @class Entity
--- @field attachment Component.attachment
--- @field attachmentCopyVisibility Component.attachmentCopyVisibility
--- @field attachmentCopySpritePosition Component.attachmentCopySpritePosition
--- @field attachmentCopySpriteEffects Component.attachmentCopySpriteEffects
--- @field attachmentCopyAnimation Component.attachmentCopyAnimation

return AttachmentComponents
