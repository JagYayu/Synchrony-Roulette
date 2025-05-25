--- @meta

local HUDLayout = {}

HUDLayout.SizePolicy = {
	--- Use margins and slot data (count, size and spacing) to compute exact size
	EXACT = 1,
	--- Take all available space that is not occupied by blocking HUD elements
	GROW = 2,
	--- Use computed size of the parent along same axis
	PARENT = 3,
}

HUDLayout.MirrorCondition = {
	NONE = 0,
	--- True if only one HUD layout is active (single focused player)
	SINGLE_HUD = 1,
	--- True if multiple HUD layouts are active (multiple focused players)
	MULTI_HUD = 2,
	--- True if this HUD layout is a multi-row view (>= 3 HUDs)
	MULTI_ROW = 4,
	--- True if this is the topmost row in multi-HUD mode
	ROW_TOP = 8,
	--- True if this is a middle row in multi-HUD mode (requires >= 7 HUDs)
	ROW_MIDDLE = 16,
	--- True if this is the bottommost row in multi-HUD mode
	ROW_BOTTOM = 32,
	--- True if this is the leftmost column in multi-HUD mode
	COLUMN_LEFT = 64,
	--- True if this is a middle column in multi-HUD mode (requires >= 7 HUDs)
	COLUMN_MIDDLE = 128,
	--- True if this is the rightmost column in multi-HUD mode
	COLUMN_RIGHT = 256,
	--- True if horizontal HUD mirroring is enabled in the settings
	MIRROR_X_ENABLED = 512,
	--- True if vertical HUD mirroring is enabled in the settings
	MIRROR_Y_ENABLED = 1024,
	--- True if horizontal HUD slot mirroring is enabled in the settings
	MIRROR_SLOT_X_ENABLED = 2048,
	--- True if vertical HUD slot mirroring is enabled in the settings
	MIRROR_SLOT_Y_ENABLED = 4096,
	--- True if this HUD region is reflected
	REFLECTED = 8192,
	--- Never true
	NEVER = 1073741824,
}

HUDLayout.Alignment = {
	BOTTOM_CENTER = { 0, 1 },
	TOP_LEFT = { -1, -1 },
	CENTER_LEFT = { -1, 0 },
	BOTTOM_LEFT = { -1, 1 },
	TOP_CENTER = { 0, -1 },
	CENTER = { 0, 0 },
	TOP_RIGHT = { 1, -1 },
	CENTER_RIGHT = { 1, 0 },
	BOTTOM_RIGHT = { 1, 1 },
}

HUDLayout.Element = {
	SCREEN = "screen",
	CURRENCY = "currency",
	HEALTH = "health",
	SPELLS = "spells",
	EQUIPMENT = "equipment",
	CHARMS = "charms",
	ACTIONS = "actions",
	LEVEL = "level",
	MINIMAP = "minimap",
	TIMER = "timer",
	GROOVE_CHAIN = "grooveChain",
	HEARTBEAT = "heartbeat",
	DAMAGE_COUNTDOWN = "damageCountdown",
	SPECTATOR_CONTROLS = "spectatorControls",
	SPECTATOR_TARGET = "spectatorTarget",
	RUN_SUMMARY_PROMPT = "runSummaryPrompt",
	SUBTITLES = "subtitles",
	NETWORK = "network",
	PLAYER_LIST = "playerList",
	CryptArena_ScoreDisplay = "CryptArena_ScoreDisplay",
}

function HUDLayout.updateElements() end

function HUDLayout.register(element) end

function HUDLayout.new(screenRect) end

return HUDLayout
