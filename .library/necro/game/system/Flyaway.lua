--- @meta

local Flyaway = {}

--- Holds attributes for flyaway text objects.
--- @class Flyaway.Parameters
--- @field text string Text string to display as a flyaway
--- @field entity? Entity Entity above which to spawn the flyaway
--- @field x? integer Horizontal position at which to spawn the flyaway (ignored if a valid entity is specified)
--- @field y? integer Vertical position at which to spawn the flyaway (ignored if a valid entity is specified)
--- @field delay? number Number of seconds to wait before showing the flyaway (defaults to 0)
--- @field duration? number Number of seconds to display the flyaway for (defaults to 2)
--- @field distance? number Number of pixels the delay should travel before disappearing (defaults to 24)
--- @field fadeOut? number Proportion of the flyaway's lifetime after which it should begin fading out (defaults to 0.5)
--- @field offsetX? number Horizontal offset for the flyaway's text (defaults to 0)
--- @field offsetY? number Vertical offset for the flyaway's text (defaults to 0)
--- @field alignX? number Horizontal alignment for the flyaway's text (defaults to 0.5, or center-aligned)
--- @field alignY? number Vertical alignment for the flyaway's text (defaults to 1, or bottom-aligned)
--- @field size? number Font size override for the flyaway (defaults to the font's native size)
--- @field hud? boolean If true, spawns the flyaway relative to the HUD instead of in the world
--- @field buffer? Render.Buffer Rendering buffer to draw the flyaway in (defaults to `Render.Buffer.FLYAWAY`)
--- @field animationID? integer

--- Returns a list of all active in-game flyaways
--- @return Flyaway.Parameters[]
function Flyaway.getAll() end

--- Returns a list of all active local (HUD) flyaways
--- @return Flyaway.Parameters[]
function Flyaway.getLocal() end

--- Spawns a flyaway text with the specified parameters, which is only visible from the perspective of the specified
--- entity.
--- @param parameters Flyaway.Parameters
function Flyaway.createIfFocused(parameters) end

--- Spawns a flyaway text with the specified parameters, which is visible for all entities.
--- @param parameters Flyaway.Parameters
function Flyaway.create(parameters) end

--- Creates a musical note symbol as a flyaway, similar to the Shopkeeper's singing or Melody's Golden Lute
--- @param entity Entity Entity at which to spawn the note
--- @param offsetX? number Horizontal offset to move the note by
--- @param offsetY? number Vertical offset to move the note by
function Flyaway.createNote(entity, offsetX, offsetY) end

return Flyaway
