--- @meta

local SpellRedirectionComponents = {}

--- Allows this spellcast to be redirected.
--- @class Component.spellcastRedirectable

--- When this spell is redirected by an item, consume a stack of that item.
--- @class Component.spellcastRedirectableConsumeReflector

--- If this entity is hit by a redirectable spell, the spell is re-cast in a different direction.
--- @class Component.spellRedirector

--- If the holder of this item is hit by a redirectable spell, the spell is re-cast in a different direction.
--- @class Component.spellRedirectorItem

--- Consumes a stack of this item upon a successful redirect.
--- @class Component.spellRedirectorItemConsume

--- Re-casts reflected spells on behalf of the redirector entity.
--- @class Component.spellRedirectorCastBySelf

--- Re-casts reflected spells on behalf of the redirector item's holder.
--- @class Component.spellRedirectorCastByHolder

--- Adds a delay before casting the reflected spell.
--- @class Component.spellRedirectorDelay
--- @field time number # `= 0.09375` 

--- Applies a directional offset to redirected spells.
--- @class Component.spellRedirectorReflect
--- @field rotation Action.Rotation # `= action.Rotation.MIRROR` 

--- Redirects only spells that arrive from a specific direction.
--- @class Component.spellRedirectorReflectFacing
--- @field rotationMap table # Maps incoming relative direction to outgoing relative direction (default: reflect frontal hits)

--- Redirects single-target spells targeting the entity, causing them to be retargeted at the caster instead
--- @class Component.spellRedirectorReflectSingleTarget

--- Allows spells to pass through the reflector instead of being culled.
--- @class Component.spellRedirectorReflectPermeable

--- @class Entity
--- @field spellcastRedirectable Component.spellcastRedirectable
--- @field spellcastRedirectableConsumeReflector Component.spellcastRedirectableConsumeReflector
--- @field spellRedirector Component.spellRedirector
--- @field spellRedirectorItem Component.spellRedirectorItem
--- @field spellRedirectorItemConsume Component.spellRedirectorItemConsume
--- @field spellRedirectorCastBySelf Component.spellRedirectorCastBySelf
--- @field spellRedirectorCastByHolder Component.spellRedirectorCastByHolder
--- @field spellRedirectorDelay Component.spellRedirectorDelay
--- @field spellRedirectorReflect Component.spellRedirectorReflect
--- @field spellRedirectorReflectFacing Component.spellRedirectorReflectFacing
--- @field spellRedirectorReflectSingleTarget Component.spellRedirectorReflectSingleTarget
--- @field spellRedirectorReflectPermeable Component.spellRedirectorReflectPermeable

return SpellRedirectionComponents
