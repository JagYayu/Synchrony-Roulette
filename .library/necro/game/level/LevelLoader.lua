--- @meta

local LevelLoader = {}

--- @class Event.LevelLoad : Level.Data.Legacy

--- Common attributes present in both the abstract level resource and runtime level info (`CurrentLevel` module)
--- @class Level.Base
--- @field number integer 1-indexed sequential identifier of this level in the whole run. Increases across sub-runs
--- @field depth integer The depth number of this level. Starts at 1 and increments with each new zone
--- @field zone integer The zone number of this level. Corresponds to the tileset, layout and music of this level
--- @field floor integer Floor number within the current zone. Starts at 1 when entering a zone, increments per level
--- @field boss Boss.Type Boss type for this level, or 0 (NONE) for regular levels
--- @field loopID integer 1-index loop counter, tracking how many sub-runs have been performed within this run
--- @field isFinal boolean Tags this level as the final one in the run, ending the run in a victory upon completion
--- @field isLoopFinal boolean Tags this level as the final one in the current loop, potentially restarting a new loop
--- @field isProcedural boolean Tags this level as procedurally generated, allowing certain post-processing to apply
--- @field name? string Optional name describing this level, which can be displayed in the UI
--- @field nameColor? integer Color to use when displaying this level's name in the UI
--- @field playerOptions? Level.PlayerOptions Overrides player spawning behavior for this level
--- @field restartTarget? table Overrides the "quick restart" functionality to redirect to a different game mode
--- @field music Soundtrack.Song Contains info about which song to play on this level

--- @class Level.Data : Level.Base
--- @field tileMapping Level.TileMapping|LevelUtils.TileIDMap Maps integers in segment tile lists to actual tile types
--- @field borderTile? integer If set to a valid tile mapping index, surrounds the level in a specific border tile type
--- @field segments Level.Segment[] Defines the level's tile layout as individual rectangular segments
--- @field entities Level.Entity[] Defines a list of entities to spawn at the start of the level
--- @field runState? RunState Contains a partial runState table, which is merged into the run's current state table
--- @field cutscenes? table[] List of cutscenes to play when entering this level
--- @field customBoss? boolean If set to true, it will not be regenerated procedurally, even if it is a boss level
--- @field customRules? table Supplies a set of custom rules to activate for this dungeon
--- @field cameraMode? CameraTarget.Mode Camera mode override for this level

--- Contains legacy compatibility fields for level data
--- @class Level.Data.Legacy : Level.Data
--- @field num? integer Alias for `number`
--- @field musicZone? integer Alias for `music.zone` with type `Soundtrack.TrackType.ZONE`
--- @field musicFloor? integer Alias for `music.floor` with type `Soundtrack.TrackType.ZONE`
--- @field musicSpecial? Soundtrack.TrackType Alias for `music.type`

--- @class Level.Entity
--- @field type string Name of the entity type to spawn
--- @field x integer X-position of the tile to spawn the entity at
--- @field y integer Y-position of the tile to spawn the entity at
--- @field attributes? Level.Entity.Attribute List of entity field value overrides (if omitted, uses default values)
--- @field inventory? Level.Entity[] Optional list of entities to spawn as items in the parent entity's inventory
--- @field priceTag? Level.Entity Optional price tag entity to specify as this entity's cost

--- @class Level.Entity.Attribute
--- @field component string Name of the component to set a value for - ignored if the entity type lacks this component
--- @field field string Name of the field within the component to assign a value to - should be a valid mutable field
--- @field value any Field value to assign - should match the field's type

--- @class Level.TileMapping
--- @field tilesetNames string[] List of tileset names to use in this level
--- @field tilesets integer[] List of indexes into the `tilesetNames` list, mapping each tile index to a tileset entry
--- @field tileNames string[] List of tile names, mapping each tile index to a tile type. Length must match `tilesets`

--- @class Level.Segment
--- @field bounds Rectangle Integer rectangle defining how this segment's tiles are placed
--- @field tiles integer[] Specifies the segment's tiles as a list of indices into the tilesets/tileNames arrays
--- @field wires? integer[] Supplies optional per-tile wire connectivity bitmasks. If nil, wires are auto-connected

--- @class Level.PlayerOptions
--- @field characterOverride? string Overrides the entity type name to spawn player characters as
--- @field lateJoinOverride? string Overrides the entity type name to spawn late-joiners as
--- @field noItems? boolean Spawns players without their starting items
--- @field health? integer Overrides the starting health of all players
--- @field isSafe? boolean Designates this level as 'safe', granting damage immunity (similar to the lobby)
--- @field initialCharacters? Player.CharacterMap Overrides the "initial characters" map from the main dungeon data

function LevelLoader.load(dungeon, levelIndex) end

return LevelLoader
