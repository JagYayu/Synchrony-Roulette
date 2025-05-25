--- @meta

local LevelEditorComponents = {}

--- Overrides the name used for this entity in the level editor.
--- When this is absent, `friendlyName` is used instead.
--- @class Component.editorName
--- @field name localizedString # `= 0` 

--- Hides this entity from the level editor.
--- @class Component.editorHidden

--- Hides this entity from the level editor by default, but show it with "Show advanced objects".
--- @class Component.editorAdvanced

--- Puts this entity in the "Crate" category of the level editor.
--- @class Component.editorCategoryCrate

--- Puts this entity in the "Chest" category of the level editor.
--- @class Component.editorCategoryChest

--- Puts this entity in the "Trap" category of the level editor.
--- @class Component.editorCategoryTrap

--- Puts this entity in the "Special" category of the level editor.
--- @class Component.editorCategorySpecial

--- Lets this entity be placed as a priceTag in the level editor.
--- @class Component.editorPriceTagAutoLink

--- When moving/deleting this entity in the level editor, automatically moves/deletes its children.
--- @class Component.editorLinkParentEntity
--- @field children table # List of entity IDs of children entities.

--- Lets this entity be linked to an `editorLinkParentEntity` entity.
--- @class Component.editorLinkChildEntity
--- @field parent Entity.ID # 

--- @class Entity
--- @field editorName Component.editorName
--- @field editorHidden Component.editorHidden
--- @field editorAdvanced Component.editorAdvanced
--- @field editorCategoryCrate Component.editorCategoryCrate
--- @field editorCategoryChest Component.editorCategoryChest
--- @field editorCategoryTrap Component.editorCategoryTrap
--- @field editorCategorySpecial Component.editorCategorySpecial
--- @field editorPriceTagAutoLink Component.editorPriceTagAutoLink
--- @field editorLinkParentEntity Component.editorLinkParentEntity
--- @field editorLinkChildEntity Component.editorLinkChildEntity

return LevelEditorComponents
