--- @meta

local Focus = {}

Focus.Flag = {
	--- Assigned to local players and spectator targets as a catch-all for unspecified modded player focus states.
	--- Represents all uses of the legacy functions `player.getFocusedEntities()`/`player.isFocusedEntity()`.
	--- Otherwise, this flag is never checked by Synchrony's own code.
	DEFAULT = 1,
	--- Causes the camera to follow this entity in "Track local players" mode.
	CAMERA = 2,
	--- Possibly marks the segment this entity is currently within as visible, rendering it and playing sounds within it.
	--- Note that the effective segment visibility may vary depending on the segment visibility mode.
	--- Effective segment visibility should always be checked using the `SegmentVisibility` module.
	SEGMENT_VISIBILITY = 4,
	--- Displays the HUD for this entity.
	HUD = 8,
	--- Displays screen flashes for this entity.
	OVERLAY = 16,
	--- Displays local flyaway texts, such as "exit stairs unlocked".
	FLYAWAY = 32,
	--- Considers the entity as a possible "nearest player" for perspective-dependent text labels (price tags).
	TEXT_LABEL = 64,
	--- Skips displaying this entity's player name, as it is considered well-known and does not need to be displayed.
	--- In other words, setting this flag *hides* the player name. This flag is inverted mostly for performance reasons,
	--- avoiding the need to assign non-zero focus flags to all non-local player entities.
	LOCALLY_KNOWN_PLAYER_NAME = 128,
	--- Displays entity-specific in-world graphics and indicators, such as the "No Return" tile.
	OBJECT_VISIBILITY = 256,
	--- Uses this entity's groove chain and beatmap parity to render the Disco Floor.
	--- If multiple entities are specified, the entity with the highest groove chain or lowest ID is used.
	DISCO_FLOOR = 512,
	--- Includes this entity's components and items for perspective calculations.
	PERSPECTIVE = 1024,
	--- Plays local sound effects and voices, such as the item pickup sound and exit stair unlock cheer.
	--- This also affects audio filters and loops.
	SOUND_PLAYBACK = 2048,
	--- Uses this entity to determine the relative listener position for spatialized sound effects.
	--- If multiple entities are specified, the average direction is used for orientation, while sound attenuation is
	--- based on distance to the closest listener.
	SOUND_LISTENER = 4096,
	--- Scans these entities' surrounding tiles to adjust music layer volumes (Zone 3 hot/cold).
	--- If multiple entities are specified, their layer volume weights are averaged.
	MUSIC_LAYER = 8192,
	--- Uses this entity's beatmap for displaying the beat bars.
	--- If multiple entities are specified, the entity with the fastest beatmap and highest number of skipped beats is
	--- used, with non-rhythm entities counted as infinitely slow.
	BEAT_BARS = 16384,
	--- Uses this entity's beatmap for timing in-world visuals (animation speed, singing, etc.).
	--- Uses the same multi-entity rules as BEAT_BARS.
	BEAT_VISUALS = 32768,
	--- Allows sound effects associated with these entities to bypass the noise control system.
	NOISE_CONTROL_BYPASS = 65536,
	--- Hides this entity's health bar. Rationale for this flag's inversion is similar to LOCALLY_KNOWN_PLAYER_NAME.
	HIDE_HEALTH_BAR = 131072,
	--- Uses this entity's position to determine whether to play screenshake effects.
	SCREEN_SHAKE = 262144,
	--- Allows freeze frame effects associated with this entity to play.
	FREEZE_FRAME = 524288,
}

Focus.Type = {
	--- Represents no focus flags
	NONE = 0,
	--- Represents all flags for locally controlled entities (currently contains all flags)
	LOCAL = -1,
	--- Represents all flags for single-target spectating (all regular focus flags, but player names are displayed)
	SPECTATE_SINGLE = -131201,
	--- Represents all flags for multi-target spectating (reduces visual and auditory noise)
	SPECTATE_MULTIPLE = -721041,
	--- Represents all flags for intangible entities in local co-op (only their HUD remains visible)
	INTANGIBLE = 8,
	--- Represents all focus flags
	ALL = -1,
}

--- @return Entity[]
function Focus.getAll(flag) end

function Focus.getFirst(flag) end

--- @return Entity
function Focus.getNearest(x, y, flag) end

function Focus.getNearestWithDistance(x, y, flag) end

function Focus.check(entity, flag) end

function Focus.update() end

return Focus
