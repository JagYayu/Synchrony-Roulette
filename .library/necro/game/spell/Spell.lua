--- @meta

local Spell = {}

--- Fired whenever a spell is cast
--- @class Event.Spellcast
--- @field entity Entity Entity prototype of the spell being cast
--- @field caster Entity Entity casting the spell
--- @field x integer The X position at which the spell is being cast
--- @field y integer The Y position at which the spell is being cast
--- @field direction Action.Direction Direction in which the spell is cast, or `NONE` for non-directional casts
--- @field tiles Tile.Coord[] List of tile coordinates affected by this spell
--- @field targetCount integer Number of entities targeted/affected by this spell, typically used for on-hit sfx/gfx
--- @field suppressed boolean? If `true`, stops further processing of most spellcast handlers
--- @field target Entity? Optional entity that is targeted exclusively by this spell, overriding `tiles`
--- @field silent boolean? If `true`, prevents this spell from emitting sound effects
--- @field item Entity? Spell item using which this spell was cast (may be `nil` for non-item casts)
--- @field multicastCopy boolean? Set to `true` for spell copies cast from `spellcastMulticast` or via spell redirection
--- @field redirect SpellRedirect.Redirection? If this spell was cast via redirection, stores info about its origins
--- @field attacker Entity? Stores the attacker for spells cast via `castOnHit` and similar components
--- @field spell Entity Alias for `entity`

function Spell.castAt(caster, spellType, x, y, direction, params) end

function Spell.cast(caster, spellType, direction, params) end

function Spell.spawn(caster, entityType, x, y, data) end

function Spell.payBloodCost(entity, cost, killerName) end

return Spell
