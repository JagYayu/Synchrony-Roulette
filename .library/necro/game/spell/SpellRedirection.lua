--- @meta

local SpellRedirection = {}

--- Fired whenever a spellcast is redirected
--- @class Event.SpellRedirect
--- @field entity Entity The entity performing the redirection and deciding its traits (typically a "reflector" object)
--- @field caster Entity The entity on behalf of which the redirected spell is cast, influencing kill credit and team
--- @field target Entity Entity that was being targeted by the oriignal spellcast (e.g. player holding a Reflect Shield)
--- @field spell Entity Entity prototype of the spell being cast
--- @field direction Action.Direction? Outgoing direction into which the redirected spell will be cast
--- @field original Event.Spellcast Parameter table of the original `event.spellcast` invocation (can be modified)
--- @field suppressed boolean? If `true`, prevents the spell from being redirected
--- @field x integer X position on which the redirection occurred
--- @field y integer Y position on which the redirection occurred

--- Stores info about how a spell was redirected
--- @class SpellRedirect.Redirection
--- @field origX integer X position from which the spell was originally cast
--- @field origY integer Y position from which the spell was originally cast
--- @field count integer Number of times this spell has been redirected
--- @field id Entity.ID ID of the entity that last redirected this spell

return SpellRedirection
