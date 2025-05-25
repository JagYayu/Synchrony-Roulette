--- @meta

local AudioChannel = {}

AudioChannel.Flag = {
	--- Sound effects that are produced by menus and user interface elements
	CONTEXT_MENU = 1,
	--- Speech and non-speech vocalizations (grunts, yells, roars, etc.)
	VOCALIZATION_ANY = 2,
	--- Spoken words (spells, bosses, announcer)
	VOCALIZATION_SPEECH = 4,
	--- Sounds played due to a remote player's actions
	NETWORK_REMOTE = 8,
	--- Repetitive, player-induced, low-importance sound effects that do not contribute to gameplay (Souls, dig failure)
	IMPORTANCE_LOW = 16,
	--- High-importance sounds that provide a gameplay advantage when localized (miniboss tramples, Thief)
	IMPORTANCE_HIGH = 32,
	--- Quiet, subtle sound effects (dig voice)
	VOLUME_QUIET = 64,
	--- Loud sound effects (boss arena doors, chest appearance, player death, boss vocalizations)
	VOLUME_LOUD = 128,
	--- Long sound effects that last several seconds and/or reverberate
	DURATION_LONG = 256,
	--- Looping sounds that continue playing until their source is silenced
	DURATION_LOOP = 512,
	--- Sounds and vocalizations produced by playable characters
	SOURCE_PLAYER = 1024,
	--- Sounds and vocalizations produced by common enemies
	SOURCE_ENEMY = 2048,
	--- Sounds and vocalizations produced by minibosses
	SOURCE_MINIBOSS = 4096,
	--- Sounds and vocalizations produced by bosses
	SOURCE_BOSS = 8192,
	--- Boss names spoken by the game's announcer
	SOURCE_ANNOUNCER = 16384,
	--- Sounds produced by activating items
	SOURCE_ITEM = 32768,
	--- Sounds produced by triggering traps
	SOURCE_TRAP = 65536,
	--- Sounds produced by interacting with tiles (hot coals, water, tar)
	SOURCE_TILE = 131072,
	--- Sounds produced by interacting with other objects (crates, shrines, chests, etc.)
	SOURCE_OBJECT = 262144,
	--- Sounds played when an entity attacks successfully
	EVENT_ATTACK = 524288,
	--- Sounds played when an entity is about to attack or misses its attack
	EVENT_ACTION = 1048576,
	--- Sounds played when an entity is hit
	EVENT_HIT = 2097152,
	--- Sounds played when an entity is killed
	EVENT_DEATH = 4194304,
	--- Sounds played when an entity is revealed
	EVENT_ROAR = 8388608,
	--- Sounds played when the groove chain changes
	EVENT_GROOVE_CHAIN = 16777216,
	--- Sounds played when a spell is cast
	EVENT_SPELL = 33554432,
}

AudioChannel.VolumeSetting = {
	--- Any sound effects that are audible during gameplay
	CONTEXT_GAMEPLAY = "CONTEXT_GAMEPLAY",
	--- Sound effects that are produced by menus and user interface elements
	CONTEXT_MENU = "CONTEXT_MENU",
	--- Non-voice sound effects (weapon hits, traps, tiles)
	TYPE_NOISE = "TYPE_NOISE",
	--- Speech and non-speech vocalizations for any characters
	VOCALIZATION_ANY = "VOCALIZATION_ANY",
	--- Non-speech vocalizations (grunts, yells, roars, etc.)
	VOCALIZATION_NON_SPEECH = "VOCALIZATION_NON_SPEECH",
	--- Spoken words (spells, bosses, announcer)
	VOCALIZATION_SPEECH = "VOCALIZATION_SPEECH",
	--- Sounds and vocalizations produced by playable characters
	SOURCE_PLAYER = "SOURCE_PLAYER",
	SOURCE_PLAYER_GAMEPLAY = "SOURCE_PLAYER_GAMEPLAY",
	SOURCE_PLAYER_ATTACK = "SOURCE_PLAYER_ATTACK",
	SOURCE_PLAYER_HIT = "SOURCE_PLAYER_HIT",
	SOURCE_PLAYER_DEATH = "SOURCE_PLAYER_DEATH",
	SOURCE_PLAYER_SPELL = "SOURCE_PLAYER_SPELL",
	SOURCE_PLAYER_GROOVE_CHAIN = "SOURCE_PLAYER_GROOVE_CHAIN",
	SOURCE_PLAYER_PING = "SOURCE_PLAYER_PING",
	--- Sounds and vocalizations produced by common enemies
	SOURCE_ENEMY = "SOURCE_ENEMY",
	SOURCE_ENEMY_ACTION = "SOURCE_ENEMY_ACTION",
	SOURCE_ENEMY_ATTACK = "SOURCE_ENEMY_ATTACK",
	SOURCE_ENEMY_HIT = "SOURCE_ENEMY_HIT",
	SOURCE_ENEMY_DEATH = "SOURCE_ENEMY_DEATH",
	SOURCE_ENEMY_ROAR = "SOURCE_ENEMY_ROAR",
	--- Sounds and vocalizations produced by minibosses
	SOURCE_MINIBOSS = "SOURCE_MINIBOSS",
	SOURCE_MINIBOSS_ACTION = "SOURCE_MINIBOSS_ACTION",
	SOURCE_MINIBOSS_ATTACK = "SOURCE_MINIBOSS_ATTACK",
	SOURCE_MINIBOSS_HIT = "SOURCE_MINIBOSS_HIT",
	SOURCE_MINIBOSS_DEATH = "SOURCE_MINIBOSS_DEATH",
	SOURCE_MINIBOSS_ROAR = "SOURCE_MINIBOSS_ROAR",
	--- Sounds and vocalizations produced by bosses
	SOURCE_BOSS = "SOURCE_BOSS",
	SOURCE_BOSS_ACTION = "SOURCE_BOSS_ACTION",
	SOURCE_BOSS_ATTACK = "SOURCE_BOSS_ATTACK",
	SOURCE_BOSS_HIT = "SOURCE_BOSS_HIT",
	SOURCE_BOSS_DEATH = "SOURCE_BOSS_DEATH",
	SOURCE_BOSS_ROAR = "SOURCE_BOSS_ROAR",
	--- Boss names spoken by the game's announcer
	SOURCE_ANNOUNCER = "SOURCE_ANNOUNCER",
	--- Sounds produced by activating items
	SOURCE_ITEM = "SOURCE_ITEM",
	--- Sounds produced by triggering traps
	SOURCE_TRAP = "SOURCE_TRAP",
	--- Sounds produced by interacting with tiles (hot coals, water, tar)
	SOURCE_TILE = "SOURCE_TILE",
	--- Sounds produced by interacting with other objects (crates, shrines, chests, etc.)
	SOURCE_OBJECT = "SOURCE_OBJECT",
	--- Sounds played due to a local player's actions
	NETWORK_LOCAL = "NETWORK_LOCAL",
	--- Sounds played due to a remote player's actions
	NETWORK_REMOTE = "NETWORK_REMOTE",
	--- Repetitive, player-induced, low-importance sound effects that do not contribute to gameplay (Souls, dig failure)
	IMPORTANCE_LOW = "IMPORTANCE_LOW",
	--- All sound effects without low/high importance
	IMPORTANCE_NORMAL = "IMPORTANCE_NORMAL",
	--- High-importance sounds that provide a gameplay advantage when localized (miniboss tramples, Thief)
	IMPORTANCE_HIGH = "IMPORTANCE_HIGH",
	--- Quiet, subtle sound effects (dig voice)
	VOLUME_QUIET = "VOLUME_QUIET",
	--- All sound effects without quiet/loud volume
	VOLUME_AVERAGE = "VOLUME_AVERAGE",
	--- Loud sound effects (boss arena doors, chest appearance, player death, boss vocalizations)
	VOLUME_LOUD = "VOLUME_LOUD",
	--- Sound bites that quickly reach their peak and end shortly afterwards
	DURATION_SHORT = "DURATION_SHORT",
	--- Long sound effects that last several seconds and/or reverberate
	DURATION_LONG = "DURATION_LONG",
	--- Looping sounds that continue playing until their source is silenced
	DURATION_LOOP = "DURATION_LOOP",
}

function AudioChannel.updateVolumes() end

function AudioChannel.resolve(channel) end

--- @param settingName AudioChannel.VolumeSetting
--- @param factor number
function AudioChannel.setMultiplier(settingName, factor) end

--- @param settingName AudioChannel.VolumeSetting
--- @return number
function AudioChannel.getMultiplier(settingName) end

function AudioChannel.match(settingName, channel) end

function AudioChannel.getVolume(channel) end

function AudioChannel.getCustomVolumeRules() end

return AudioChannel
