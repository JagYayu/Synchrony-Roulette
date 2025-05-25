--- @meta

local Render = {}

--- @enum Render.Transform
Render.Transform = {
	NONE = 0,
	CAMERA = 1,
	UI = 2,
	EDITOR = 3,
}

--- @enum Render.Group
Render.Group = {
	GAME = 1,
}

--- @enum Render.Buffer
Render.Buffer = {
	--- @return VertexBuffer.ID
	extend = function(_, _) end,
	data = {},
	valueList = {},
	--- Z-ordered in-game visuals
	WALL = 1,
	OBJECT = 2,
	SHADOW = 3,
	PARTICLE = 4,
	ATTACHMENT = 5,
	TEXT_LABEL = 6,
	SWIPE_BACK = 7,
	--- Z-ordered, camera-transformed render buffer for mods
	CUSTOM = 8,
	--- Non-Z-ordered in-game visuals
	FLOOR = 9,
	--- Merge target - cannot be drawn to directly
	MERGE_TARGET_GAME = 10,
	HEALTH_BAR = 11,
	TEXT_LABEL_FRONT = 12,
	SWIPE = 13,
	PLAYER_NAME = 14,
	FLYAWAY = 15,
	OVERLAY = 16,
	--- Legacy game render buffer (system.game.Graphics)
	LEGACY = 17,
	--- UI visuals
	UI_BEAT_BARS = 18,
	UI_HUD = 19,
	UI_BOSS_SPLASH = 20,
	UI_LOBBY = 21,
	UI_EDITOR_OBJECTS = 22,
	UI_EDITOR = 23,
	UI_MENU = 24,
	UI_POPUP_MENU = 25,
	UI_CHAT = 26,
	--- Legacy UI render buffer (system.game.Graphics)
	UI_LEGACY = 27,
	--- Unordered, camera-independent render buffer for mods
	UI_CUSTOM = 28,
	UI_OVERLAY = 29,
	--- For camera-transformed debug visuals
	UI_DEBUG_OBJECTS = 30,
	UI_DEBUG = 31,
}

Render.Corner = {
	TOP_LEFT = { -0.5, -0.5 },
	TOP_RIGHT = { 0.5, -0.5 },
	BOTTOM_LEFT = { -0.5, 0.5 },
	BOTTOM_RIGHT = { -0.5, 0.5 },
	CENTER = { 0, 0 },
}

--- @param bufferID integer|VertexBuffer
--- @return VertexBuffer
function Render.getBuffer(bufferID) end

function Render.setTransform(transformID, matrix) end

--- @return table
function Render.getTransform(transformID) end

function Render.objectRect(x, y, w, h) end

--- @param x number
--- @param y number
--- @return integer x
--- @return integer y
function Render.tileCenter(x, y) end

--- Returns the rendering origin for the given tile
--- @param x number
--- @param y number
--- @return number x
--- @return number y
function Render.tileRenderingOrigin(x, y) end

function Render.tileCorner(x, y, corner) end

function Render.tileRect(x, y, w, h) end

--- Deprecated
function Render.drawTextInWorld(args) end

function Render.getVideoLatency() end

--- Returns the integer position of the tile located at the specified screenspace coordinates.
--- @param x number X-position in screen coordinates
--- @param y number Y-position in screen coordinates
--- @return integer tileX X-position of the tile at specified coordinates
--- @return integer tileY Y-position of the tile at specified coordinates
function Render.getTileAt(x, y) end

return Render
