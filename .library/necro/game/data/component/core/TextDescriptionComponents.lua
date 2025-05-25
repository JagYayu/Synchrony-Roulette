--- @meta

local TextDescriptionComponents = {}

--- Special message to show when this character is unlocked.
--- If this component is absent, the generic "You've unlocked ..." message is shown instead.
--- @class Component.textCharacterUnlockMessage
--- @field text localizedString # `= 0` 

--- Brief description of how to unlock this character. Shown as a flyaway when stepping on their locked lobby stairs.
--- @class Component.textCharacterUnlockHint
--- @field text localizedString # `= 0` 

--- Brief description of this character's playstyle. Shown in a menu when selecting this character.
--- @class Component.textCharacterSelectionMessage
--- @field text localizedString # `= 0` 

--- @class Entity
--- @field textCharacterUnlockMessage Component.textCharacterUnlockMessage
--- @field textCharacterUnlockHint Component.textCharacterUnlockHint
--- @field textCharacterSelectionMessage Component.textCharacterSelectionMessage

return TextDescriptionComponents
