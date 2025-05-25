--- @meta

local Vision = {}

Vision.FoV = {
	DEFAULT = 1,
	UNSILHOUETTE = 2,
	--- Temporary! This will be removed once full per-player FoV masks are implemented
	INVISIBLE = 4,
}

function Vision.rebuildShadowMap() end

function Vision.rebuildPerspectiveRevealedTiles() end

--- Returns true if the tile at the specified position is currently within any player's field of view
--- @return boolean
function Vision.isVisible(x, y, mask) end

--- Returns true if the tile at the specified position has been visible and sufficiently lit up in a certain FoV group
function Vision.isRevealed(x, y, mask) end

--- Returns true if the tile at the specified position has been visible and sufficiently lit up from the focused player's
--- perspective.
function Vision.isVisuallyRevealed(x, y) end

--- Reveal the tile at the specified position
function Vision.reveal(x, y, mask) end

--- Unreveal the tile at the specified position
function Vision.unreveal(x, y, mask) end

--- Returns the brightness of the tile at the specified position
function Vision.getEffectiveBrightness(x, y) end

--- Modifies the brightness of the tile at the specified position
function Vision.setEffectiveBrightness(x, y, brightness) end

--- Returns the light level (affected by all nearby light sources, but not visibility or revelation) of the tile at the
--- specified position
function Vision.getLightLevel(x, y) end

function Vision.isLit(x, y) end

--- Returns true if the tile at the specified position is sufficiently visible and lit up for enemies on it to aggro
function Vision.isVisibleAndLit(x, y, mask) end

--- Deprecated
function Vision.isVisuallyLit(x, y) end

--- Returns true if the tile at the specified position is in a nightmare's shadow
function Vision.isShadowed(x, y) end

--- Returns true if the tile at the specified position is forced to minimum brightness by perspective
function Vision.isPerspectiveShadowed(x, y) end

--- Returns true if the tile at the specified position is forced to full brightness by perspective
function Vision.isIlluminated(x, y) end

--- Returns true if the tile at the specified position is opaque
function Vision.isOpaque(x, y) end

--- Adds a light source to the level with the specified parameters. As light sources created using this function are not
--- tracked, care must be taken to match the exact parameters when removing or moving the light source, as otherwise,
--- residual spots of light will remain in the level.
function Vision.addLightSource(position, light) end

--- Removes a light source from the level with the specified parameters. As light sources removed using this function
--- are not tracked, care must be taken to match the exact parameters specified when the light source was created, as
--- otherwise, residual spots of light will remain in the level.
function Vision.removeLightSource(position, light) end

function Vision.clearLightSources() end

function Vision.rebuildIlluminatedTiles() end

function Vision.queueFieldOfViewUpdate() end

function Vision.updateInstantly() end

return Vision
