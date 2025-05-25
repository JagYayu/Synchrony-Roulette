--- @meta

local Settings = {}

--- @alias Settings.CheatFlag boolean|fun(value:any,context:LeaderboardContext):boolean

--- @class SettingsArgs
--- @field id string Dot-separated identifier for this setting
--- @field treeKey string Dot-separated tree key for this setting, used for settings menu grouping (defaults to id)
--- @field alias string Dot-separated fallback identifier for legacy settings
--- @field name string Name by which this setting is displayed in menus
--- @field desc string Optional description for this setting, which is displayed in menus upon selection
--- @field default any Default value for this setting
--- @field scope Settings.Scope Scope of this setting, controls storage and synchronization
--- @field cloud Settings.Cloud Platform synchronization mode for this setting (defaults to STARTUP)
--- @field association Settings.Association User account association mode for this setting (defaults to AUTO)
--- @field order number Order in which this setting appears within menus (defaults to math.huge)
--- @field visibility Settings.Visibility Menu visibility of this setting
--- @field format function Formatting function to convert the current value to its human-readable representation
--- @field enableIf function Enable condition for the setting's menu entry (defaults to always enabled)
--- @field type Settings.Type Type of this setting. Typically overridden by registration functions
--- @field serializer function Serialization function to convert the value to its JSON representation
--- @field deserializer function Deserialization function to convert a JSON representation back into a value
--- @field merge function Merging function to combine settings when both an old and a new value are present
--- @field setter function Function to be called when this setting is modified
--- @field tag Settings.Tag|Settings.Tag[] Tags the setting for certain use-cases, modifying its run-time behavior
--- @field layers Settings.Layer[] Ordered list of "layers" that can override the value of this setting
--- @field writeLayer Settings.Layer Layer to write the value back to, in case it is modified directly
--- @field transient boolean If true, this setting is skipped when saving presets
--- @field autoRegister boolean If true, this setting's global variable is registered automatically
--- @field cheat Settings.CheatFlag Boolean or callback indicating a cheat, disqualifying leaderboard submissions

--- @class SettingsActionArgs : SettingsArgs
--- @field action function Function to perform when this settings entry is selected

--- @class SettingsGroupArgs : SettingsArgs
--- @field entryOrder string[] Sorting order for (unprefixed) keys in this settings group
--- @field prefixAll boolean Prefixes all subsequent settings defined in the same script with this group's id

--- @class SettingsChoiceEntry
--- @field value any Value representing this choice option
--- @field name string Name by which this choice option is displayed in menus (default: stringified value)
--- @field desc string Optional description for this choice option, which is displayed in menus upon selection

--- @class SettingsChoiceArgs : SettingsArgs
--- @field choices SettingsChoiceEntry[]
--- @field choiceMapping table

--- @class SettingsEnumArgs : SettingsChoiceArgs
--- @field enum table Enumeration table (see system.utils.Enum) containing the entries available for choice

--- @class SettingsNumberArgs : SettingsArgs
--- @field minimum number Inclusive lower bound for the setting's value (default: negative infinity)
--- @field maximum number Inclusive upper bound for the setting's value (default: positive infinity)
--- @field step number Step size for increasing/decreasing the setting's value (default: 1)
--- @field smoothStep number Step size for changing the setitng's value when using a slider (defaults to step size)
--- @field stepper function Custom handler function for step sizes
--- @field sliderMinimum? number Optional visual lower bound for the setting's slider in the options menu
--- @field sliderMaximum? number Optional visual upper bound for the setting's slider in the options menu
--- @field editAsString boolean Allows editing the setting's value via text input

--- @class SettingsStringArgs : SettingsArgs
--- @field maxLength number Inclusive upper bound for the length of the setting's value

--- @class SettingsRegistrationCategory

Settings.Scope = {
	--- Game session setting, displayed in the host player's "Game settings" menu, synchronized over the network.
	SHARED = 1,
	--- Local setting, displayed in the game's "Options" menu, not synchronized (should not affect gameplay!)
	USER = 2,
	--- Overridable setting: displayed in both the "Options" and "Game settings" menu, representing an optionally
	--- server-side enforced client setting (such as a required zoom level)
	OVERRIDABLE = 3,
}

Settings.Type = {
	--- Null setting (group, action): this setting does not hold data
	NONE = 0,
	--- Arbitrary setting: this setting can hold any data
	ANY = 1,
	--- Choice setting (boolean, enum): the user can select one from a list of pre-supplied choices
	CHOICE = 2,
	--- Numeric setting: the user can increase or decrease the setting by fixed steps, or enter a custom value
	NUMBER = 3,
	--- String setting: the user can enter a custom string
	STRING = 4,
}

Settings.Visibility = {
	--- Restricted: the setting cannot be accessed by any module other than the one defining it
	RESTRICTED = 0,
	--- Hidden: the setting is never shown in the options/settings menus (default for untyped settings)
	HIDDEN = 1,
	--- Advanced: the setting is only displayed in Advanced mode
	ADVANCED = 2,
	--- Visible: the setting is always visible (default for typed settings)
	VISIBLE = 3,
}

Settings.Tag = {
	--- Entity-schema-relevant: allows the setting to be used in entity schema events, reloading the schema on change
	ENTITY_SCHEMA = 1,
	--- Tile-schema-relevant: allows the setting to be used in tile schema events, reloading the schema on change
	TILE_SCHEMA = 2,
	--- Lobby-relevant: allows the setting to be used in the lobby generation event, regenerating the lobby on change
	LOBBY_LEVEL = 3,
	--- Item-ban-relevant: allows the setting to be used in item ban checks, clearing the ban cache on change
	ITEM_BAN = 4,
}

Settings.Layer = {
	--- Default value specified in the setting's own declaration
	DEFAULT = 1,
	--- Dynamically computed default value (config migration, Steam username, etc.)
	IMPORT = 2,
	--- Locally chosen value by the user, saved to config file
	LOCAL = 3,
	--- Value selected by the host player (but not yet committed) for the current game session
	REMOTE_PENDING = 4,
	--- Value assigned by the server for the current game session
	REMOTE_OVERRIDE = 5,
	--- Value temporarily overwritten by a script
	SCRIPT_OVERRIDE = 6,
}

Settings.Association = {
	--- Store separate values per user account. If user account has no value, inherit device value (last saved user).
	--- This is the default mode, and should be used for most settings.
	AUTO = 1,
	--- Store separate values per user account. Don't inherit device value.
	--- This mode should be used for progression or stats settings that should never be shared across accounts.
	USER = 2,
	--- Share the same value across all user accounts.
	--- This mode should be used for device-dependent settings, like latency options.
	DEVICE = 3,
}

Settings.Cloud = {
	--- Value is not synchronized to the platform cloud, and only stored locally.
	OFF = 1,
	--- Value is uploaded to the platform cloud, but only read once when initializing an otherwise empty setting.
	INIT = 2,
	--- Value is uploaded to the platform cloud, and read on each startup. This is the default mode.
	SYNC = 3,
	--- Value is uploaded to the platform cloud, and can be read in real-time.
	REALTIME = 4,
}

Settings.Format = {
}

--- Collection of registration functions for shared settings. These are displayed in the host player's "Game settings"
--- menu, synchronized over the network.
--- @type SettingsRegistrationCategory
Settings.shared = {
}

--- Collection of registration functions for entity schema settings. These are displayed in the host player's "Game
--- settings" menu, synchronized over the network and reload the ECS schema on change, allowing them to be used in
--- entity schema registrations.
--- @type SettingsRegistrationCategory
Settings.entitySchema = {
}

--- Collection of registration functions for local settings. These may are displayed in the game's "Options" menu,
--- and may differ across clients. These settings should not affect gameplay!
--- @type SettingsRegistrationCategory
Settings.user = {
}

--- Collection of registration functions for overridable settings. These are displayed displayed in both the "Options"
--- and "Game settings" menu, representing an optionally server-side enforced client setting (such as a required zoom
--- level). These settings should not affect gameplay!
--- @type SettingsRegistrationCategory
Settings.overridable = {
}

--- Assigns a default key prefix for all settings defined in this file
function Settings.prefixAll(prefix) end

function Settings.Format.MULTIPLIER(value) end

function Settings.Format.PERCENT(value) end

function Settings.Format.TIME(value) end

function Settings.shared.action(parameters) end

function Settings.shared.bool(parameters) end

function Settings.shared.choice(parameters) end

function Settings.shared.enum(parameters) end

function Settings.shared.group(parameters) end

--- @return Action.Direction
function Settings.shared.number(parameters) end

function Settings.shared.percent(parameters) end

function Settings.shared.string(parameters) end

function Settings.shared.table(parameters) end

function Settings.shared.time(parameters) end

function Settings.entitySchema.action(parameters) end

function Settings.entitySchema.bool(parameters) end

function Settings.entitySchema.choice(parameters) end

function Settings.entitySchema.enum(parameters) end

function Settings.entitySchema.group(parameters) end

function Settings.entitySchema.number(parameters) end

function Settings.entitySchema.percent(parameters) end

function Settings.entitySchema.string(parameters) end

function Settings.entitySchema.table(parameters) end

function Settings.entitySchema.time(parameters) end

function Settings.user.action(parameters) end

function Settings.user.bool(parameters) end

function Settings.user.choice(parameters) end

function Settings.user.enum(parameters) end

function Settings.user.group(parameters) end

function Settings.user.number(parameters) end

function Settings.user.percent(parameters) end

function Settings.user.string(parameters) end

function Settings.user.table(parameters) end

function Settings.user.time(parameters) end

function Settings.overridable.action(parameters) end

function Settings.overridable.bool(parameters) end

--- @return any
function Settings.overridable.choice(parameters) end

function Settings.overridable.enum(parameters) end

function Settings.overridable.group(parameters) end

--- @return number
function Settings.overridable.number(parameters) end

--- @return number
function Settings.overridable.percent(parameters) end

function Settings.overridable.string(parameters) end

--- @return table
function Settings.overridable.table(parameters) end

function Settings.overridable.time(parameters) end

return Settings
