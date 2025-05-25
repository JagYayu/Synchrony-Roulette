--- @meta

local Controls = {}

Controls.Input = {
	NONE = 0,
	DEFAULT = 1,
	SECONDARY = 2,
}

Controls.KeyType = {
	ACTION = "action",
	MISC = "misc",
}

Controls.Preference = {
	IGNORE_COMBOS = "IGNORE_COMBOS",
	HUD_PREFER_MULTIKEY = "HUD_PREFER_MULTIKEY",
	HAS_LEGACY_CONTROLS = "HAS_LEGACY_CONTROLS",
	MAIN_ALIAS = "MAIN_ALIAS",
	LEGACY_GLYPHS = "LEGACY_GLYPHS",
	IGNORE_REMAP = "IGNORE_REMAP",
	PRESERVE_PLATFORM_CUSTOMIZATIONS = "PRESERVE_PLATFORM_CUSTOMIZATIONS",
}

Controls.Context = {
	NONE = 0,
	IN_GAME = 100,
	IN_GAME_DIAGONAL = 101,
	MENU = 102,
	REPLAY = 103,
	EDITOR = 104,
}

Controls.Misc = {
	MENU_UP = 1,
	MENU_LEFT = 2,
	MENU_DOWN = 3,
	MENU_RIGHT = 4,
	PAUSE = 5,
	SELECT = 6,
	CLOSE = 7,
	QUICK_RESTART = 8,
	OPEN_CHAT = 9,
	SUBMIT_CHAT = 10,
	CLOSE_CHAT = 11,
	SELECT_2 = 12,
	REPLAY_TOGGLE_PAUSE = 13,
	REPLAY_SEEK_FORWARD = 14,
	REPLAY_SEEK_BACKWARD = 15,
	REPLAY_SPEED_UP = 16,
	REPLAY_SPEED_DOWN = 17,
	REPLAY_NEXT_LEVEL = 18,
	REPLAY_PREVIOUS_LEVEL = 19,
	EDITOR_PAINT = 20,
	EDITOR_ERASE = 21,
	EDITOR_SCROLL = 22,
	EDITOR_PICKER = 23,
	EDITOR_ZOOM_IN = 24,
	EDITOR_ZOOM_OUT = 25,
	EDITOR_PLAY = 26,
	EDITOR_FOCUS_OBJECTS = 27,
	EDITOR_FOCUS_TOOLS = 28,
	EDITOR_CATEGORIES = 29,
	EDITOR_SAVE = 30,
	EDITOR_UNDO = 31,
	EDITOR_REDO = 32,
	EDITOR_COPY = 33,
	EDITOR_CUT = 34,
	EDITOR_PASTE = 35,
	EDITOR_DELETE = 36,
	EDITOR_SELECT_ALL = 37,
	EDITOR_MODIFIER = 38,
	SEARCH = 39,
	PLAYER_LIST = 40,
	EDITOR_OPEN = 41,
	MULTIPLAYER_PAUSE = 42,
	PING_CURSOR = 43,
	NecroEdit_OPEN_IN_GAME = 44,
	NecroEdit_CLOSE_IN_GAME = 45,
}

--- Register aliases for some actions (Steam Input requires unique action names across all action sets)
Controls.PlatformAlias = {
	REPLAY_OPEN_MENU = "pi0_alias_replay_replay_open_menu",
	REPLAY_RESTART = "pi0_alias_replay_replay_restart",
	REPLAY_JOIN = "pi0_alias_replay_join",
	MENU_NEXT_PAGE = "pi0_alias_menu_next_page",
	MENU_PREVIOUS_PAGE = "pi0_alias_menu_previous_page",
	EDITOR_CURSOR_UP = "pi0_alias_editor_editor_cursor_up",
	EDITOR_CURSOR_DOWN = "pi0_alias_editor_editor_cursor_down",
	EDITOR_CURSOR_LEFT = "pi0_alias_editor_editor_cursor_left",
	EDITOR_CURSOR_RIGHT = "pi0_alias_editor_editor_cursor_right",
}

function Controls.formatMultiKey(keyList) end

function Controls.isModifierMultiKey(keyOrList) end

function Controls.getFriendlyName(keyName) end

function Controls.getMiscKeyBind(miscKeyID) end

function Controls.isPlatformInputActive() end

function Controls.getFriendlyMiscKeyBind(miscKeyID) end

function Controls.getAliasedFriendlyMiscKeyBind(miscKeyID, platformAlias) end

function Controls.getMiscKeyBinds(miscKeyID) end

function Controls.miscKey(miscKeyID) end

function Controls.consumeMiscKey(miscKeyID) end

function Controls.getActionKeyBind(actionKeyID, controllerID) end

function Controls.getActionKeyBinds(actionKeyID, controllerID) end

function Controls.actionKey(actionKeyID, controllerID) end

function Controls.consumeActionKey(actionKeyID, controllerID) end

function Controls.getKeyBinds(inputID, keyType, keyID) end

function Controls.getKeyBind(inputID, keyType, keyID, aliasID) end

function Controls.setKeyBind(inputID, keyType, keyID, aliasID, keyName) end

function Controls.setPreference(inputID, key, value) end

function Controls.getPreference(inputID, key) end

function Controls.addInput(inputID) end

function Controls.getInputCount() end

function Controls.setControllerInput(controllerID, inputID) end

function Controls.getControllerInput(controllerID) end

function Controls.isControllerInputUnique(controllerID) end

function Controls.getControllersForInput(inputID) end

function Controls.getAxis(axisName, platformDeviceIndex) end

function Controls.getBindableKeyInfo(keyType, keyID) end

function Controls.getConflictingKeys(inputID, keyType, keyID, keyName, swapCandidate) end

function Controls.getBindableKeys() end

function Controls.lookUpMappedKey(keyName) end

function Controls.clearCache() end

function Controls.clearGlyphCache() end

function Controls.resolveKeys(controllerID, pressedKeys) end

function Controls.getHeldActions(controllerID) end

function Controls.getPressedActions(controllerID) end

function Controls.getPressedAction(controllerID) end

function Controls.getPendingComboActions(controllerID) end

function Controls.getPendingComboAction(controllerID) end

function Controls.consumeAnyAction() end

function Controls.getPlatformInputDeviceIndex(inputID) end

function Controls.showPlatformInputConfigurator(inputID, context) end

function Controls.getInputMapName(inputID) end

function Controls.resetToDefault(inputID, keyType) end

function Controls.initializePlatformInputMap(index) end

function Controls.getPlatformInputParentContext(contextID) end

function Controls.showPlatformVirtualKeyboard(mode, rect) end

function Controls.hidePlatformVirtualKeyboard() end

return Controls
