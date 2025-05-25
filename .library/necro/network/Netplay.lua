--- @meta

local Netplay = {}

Netplay.MessageType = {
	--- @return integer
	extend = function(_, _) end,
	--
	LOGIN = 1,
	CLOCK_SYNC = 2,
	PLAYER_ATTRIBUTE = 3,
	PLAYER_ATTRIBUTE_LIST = 4,
	CHAT = 5,
	GAME_STATE = 6,
	PLAYER_INPUT = 7,
	DISCONNECT = 8,
	LATENCY_LIST = 9,
	RESOURCE = 10,
	SEQUENCE_SYNC = 11,
	SNAPSHOT_BROADCAST = 12,
	SNAPSHOT_REQUEST = 13,
	SNAPSHOT_RESPONSE = 14,
	HOST_CHANGE = 15,
	ROOM_CHANGE = 16,
	FAST_FORWARD = 17,
	LOCAL_COOP_ADD_PLAYER = 18,
	LOCAL_COOP_REMOVE_PLAYER = 19,
	LOCAL_COOP_PLAYER_INPUT = 20,
	LOCAL_COOP_PLAYER_ATTRIBUTE = 21,
	ROOM_ATTRIBUTE = 22,
	INPUT_UNLOCK_REQUEST = 23,
	LEVEL_COMPLETION_HINT = 24,
	SERVER_ATTRIBUTE = 25,
	RESOURCE_LOG_RESET = 26,
	PING_TOOL = 27,
	NecroEdit_ClearRooms = "NecroEdit_ClearRooms",
	NecroEdit_DeleteRoom = "NecroEdit_DeleteRoom",
	NecroEdit_Download = "NecroEdit_Download",
	NecroEdit_JoinRoom = "NecroEdit_JoinRoom",
	NecroEdit_MoveRoom = "NecroEdit_MoveRoom",
	NecroEdit_NewRoom = "NecroEdit_NewRoom",
	NecroEdit_Preview = "NecroEdit_Preview",
	NecroEdit_Redo = "NecroEdit_Redo",
	NecroEdit_RenameRoom = "NecroEdit_RenameRoom",
	NecroEdit_Step = "NecroEdit_Step",
	NecroEdit_Undo = "NecroEdit_Undo",
}

Netplay.GameState = {
	UNINITIALIZED = 0,
	LOBBY = 1,
	IN_GAME = 2,
}

Netplay.Resource = {
	DUNGEON = 1,
	GAME_SETTINGS = 2,
	MOD_LIST = 3,
	RNG_SEED = 4,
	REPLAY = 5,
	PROGRESSION = 6,
}

Netplay.PlayerAttribute = {
	--- The player's unique numeric ID. Starts at 1 and increments for each player in the server.
	ID = 1,
	--- Flag indicating whether the player is currently connected.
	CONNECTED = 2,
	--- Flag indicating whether the player has sent a log-in packet.
	LOGGED_IN = 3,
	--- The player's client ID on the server-side network socket.
	CLIENT_ID = 4,
	--- The player's server-unique secret session token, allowing them to rejoin into their previous session.
	REJOIN_TOKEN = 5,
	--- The ID of the room the player is currently or was most recently in.
	ROOM_ID = 6,
	--- The ID of the room the player is currently in. Set to nil for disconnected players.
	ACTIVE_ROOM_ID = 7,
	--- The player's username. Populated as soon as the client logs into the server.
	NAME = 8,
	--- Client-server roundtrip latency in milliseconds.
	LATENCY = 9,
	--- User-settable string containing the name of the current character choice in the lobby.
	CHARACTER = 10,
	--- (Deprecated!) Contains the player's character selection at the start of the run.
	INIT_CHARACTER = 11,
	--- User-settable flag indicating whether the player has locked in their character choice and is ready to start.
	READY = 12,
	--- User-settable table mapping resource IDs to loaded versions. Must be equal for all players to start the game.
	RESOURCE_VERSIONS = 13,
	--- Flag indicating whether the player is currently fast-forwarding the game state to catch up with other players.
	FAST_FORWARD_ACTIVE = 14,
	--- The ID of the "parent" player (for purposes of local co-op). Set to nil for individual or parent players.
	LOCAL_COOP_PARENT = 15,
	--- The ID of the previous "parent" player (for purposes of local co-op). Preserved even after co-op dissociation.
	LOCAL_COOP_PREVIOUS_PARENT = 16,
	--- The list of IDs of all "child" players (for purposes of local co-op). Set to nil for individual players.
	LOCAL_COOP_CHILDREN = 17,
	--- The list of hashes of all loaded mods. Must be equal for all players to start the game.
	MOD_HASHES = 18,
	--- If true, prevents the player from showing up in the client-side player list.
	HIDDEN = 19,
	--- Peer-to-peer communication ID of the player (typically the Steam ID).
	PEER_ID = 20,
	--- If true, this player is not associated with a network connection and does not require synchronization.
	PUPPET = 21,
	--- If true, this player is spectating and will not have their character spawn in at the start of the run.
	SPECTATING = 22,
	--- Requests for the cutscene with the specified ID to be skipped.
	CUTSCENE_SKIP = 23,
	--- Indicates that this player is experiencing networking issues, causing their inputs to be dropped.
	INPUT_LOCKED = 24,
	--- Marks this player as having cheated via console commands. Requires a rejoin/restart to clear.
	DEBUG_CONSOLE_USED = 25,
	--- Stores the player's platform ID (typically the Steam ID).
	PLATFORM_ID = 26,
	--- Stores user statistics from the beginning of the run.
	STATISTICS = 27,
	--- Tracks failed attempts at forcing a disconnected user into spectator mode.
	AUTO_SPECTATE_PENDING = 28,
	--- Includes/excludes the player from counting towards the lobby's player count limit.
	OCCUPY_SLOT = 29,
	--- Stores a session-specific random integer that allows this user to link to its own secondary clients.
	SESSION_SECRET = 30,
	--- Stores the network clock timestamp at which this player is next allowed to use the ping tool.
	PING_COOLDOWN = 31,
	CharacterSkins_SKIN = "CharacterSkins_SKIN",
}

Netplay.RoomAttribute = {
	--- Playback speed factor. Mostly used for replays.
	TEMPO_MULTIPLIER = 1,
	--- Game state synchronization checksum.
	CHECKSUM = 2,
	--- If true, player list entries are retained in the room even after the players disconnect.
	PLAYER_LIST_RETENTION = 3,
	--- Contains information about the currently active cutscne.
	CUTSCENE = 4,
	--- If true, the host player is not allowed to edit the game settings or mod list of this room.
	READ_ONLY_SETTINGS = 5,
	--- Specifies the minimum turnID for inputs to be accepted.
	INPUT_LOCK_THRESHOLD = 6,
	--- Contains the index of the most recently processed replay resource queue entry.
	REPLAY_RESOURCE_INDEX = 7,
	--- Contains the current level sequence, storing generation parameters for each level in the dungeon.
	LEVEL_SEQUENCE = 8,
	--- Contains a sequence sync table for a decisive run summary (victory/game over).
	RUN_SUMMARY_SYNC = 9,
	--- Stores the version number on which this session was started. This is used for cross-version savestate support.
	INITIAL_VERSION = 10,
	NecroEdit_AutoDelete = "NecroEdit_AutoDelete",
	NecroEdit_CommitTurn = "NecroEdit_CommitTurn",
	NecroEdit_Creator = "NecroEdit_Creator",
	NecroEdit_IMC = "NecroEdit_IMC",
	NecroEdit_LChecksum = "NecroEdit_LChecksum",
	NecroEdit_LData = "NecroEdit_LData",
	NecroEdit_LName = "NecroEdit_LName",
	NecroEdit_MC = "NecroEdit_MC",
	NecroEdit_MUD = "NecroEdit_MUD",
	NecroEdit_Parent = "NecroEdit_Parent",
	NecroEdit_RoomList = "NecroEdit_RoomList",
	NecroEdit_Root = "NecroEdit_Root",
	NecroEdit_Type = "NecroEdit_Type",
	NecroEdit_UID = "NecroEdit_UID",
	NecroEdit_UndoRedo = "NecroEdit_UndoRedo",
}

--- Represents server-global metadata attributes that can be queried without joining the server.
--- Maps directly to Steam lobby attributes.
Netplay.ServerAttribute = {
	--- Name of the server, displayed in the game browser
	NAME = 1,
	--- Version string for the current server
	VERSION = 2,
	--- Maximum number of players that are allowed to join the server
	MAX_PLAYERS = 3,
	--- Semicolon-separated list of colon-separated mod/version pairs ("ModA:1.0.0;ModB:2.0.1")
	MODS = 4,
	--- UNIX timestamp for the speedrun timer's start time, or, if paused, the character 'p' + seconds on the timer
	TIMER = 5,
	--- The current level's name (e.g. "1-1", "2-4")
	LEVEL = 6,
	--- ID of the current game mode being played
	MODE = 7,
	--- Semicolon-separated list of player character entity names
	CHARACTERS = 8,
	--- Ping estimation location via Steam SDR
	PING_LOCATION = 9,
	--- Number of players in the server
	PLAYERS = 10,
	--- Original platform this lobby is hosted on (for cross-play purposes)
	PLATFORM = 11,
	--- The current level's color
	LEVEL_COLOR = 12,
	--- Visibility of the current lobby
	LOBBY_VISIBILITY = 13,
	--- Unique session ID across platforms
	SESSION_UNIQUE_ID = 14,
}

--- Distinct channels for independently ordered message sequences. Channel 0 (NONE) is not ordered.
Netplay.Channel = {
	NONE = 0,
	GAME = 1,
	CHAT = 2,
	--- Same as GAME to work around ordering issues when joining rooms
	RESOURCES = 1,
}

Netplay.SocketType = {
	LOCAL = 0,
	UDP = 1,
	STEAM = 2,
	STEAM_MULTI = 3,
	GALAXY = 4,
	TCP = 5,
}

function Netplay.getMessage(ev) end

function Netplay.makeMessage(messageType, messageData) end

function Netplay.isPartialResourceUpdate(message) end

function Netplay.applyResourceUpdate(targetResource, message) end

return Netplay
