--- @meta

local Move = {}

--- @enum Move.Flag
Move.Flag = {
	--- @return boolean
	check = function(...) end,
	--- @return integer
	mask = function(...) end,
	--- No special flags (movement is always successful, no gameplay effects, no visual effects)
	NONE = 0,
	--- Plays a movement animation (tween) from the source tile to the target tile if the move was successful
	TWEEN = 1,
	--- If the movement fails due to an obstruction, the entity plays a bounce animation
	TWEEN_BOUNCE_FAIL = 2,
	--- If the movement results in an attack, the entity plays a bounce animation
	TWEEN_BOUNCE_ATTACK = 4,
	--- If a movement animation is played, the entity will visually slide along the ground instead of hopping
	TWEEN_SLIDE = 8,
	--- The destination tile is checked for vacancy before moving
	COLLIDE_DESTINATION = 16,
	--- Intermediate tiles are checked for vacancy before moving
	COLLIDE_INTERMEDIATE = 32,
	--- If intermediate tiles fail a collision check, the entity moves just before the obstruction, instead of failing
	ALLOW_PARTIAL_MOVE = 64,
	--- If the entity is currently submerged in liquid, the movement is inhibited
	INHIBIT_SUNKEN = 128,
	--- If the entity is currently frozen, the movement is inhibited
	INHIBIT_FROZEN = 256,
	--- If the entity is heavy, the movement is inhibited
	INHIBIT_HEAVY = 512,
	--- If the movement failed due to collision with a hostile entity, the moveResult event is invoked
	HANDLE_ATTACK = 1024,
	--- Set the entity's previous positon to the origin of the move
	TRACK_PREVIOUS_POSITION = 2048,
	--- The entity is forced to move by another entity
	FORCED_MOVE = 4096,
	--- Play the entity’s voiceWind if it isn’t heavy
	VOCALIZE = 8192,
	--- If a movement animation is played, the entity will visually slide along the ground very fast
	TWEEN_QUARTIC = 16384,
	--- If a bounce animation would play on fail, play a hop in place animation instead
	TWEEN_HOP_FAIL = 32768,
	--- Play a hop animation with an intermediate step (for bounce traps)
	TWEEN_MULTI_HOP = 65536,
	--- Deal lethal damage to entities at the destination
	TELEFRAG = 131072,
	--- Not a teleport
	CONTINUOUS = 262144,
	--- Play the entity's walk sound effect
	PLAY_SOUND = 524288,
}

--- @enum Move.Flag
Move.Type = {
	--- The entity's position is changed to the target tile without an explicit movement or teleportation
	NONE = 0,
	--- The entity is moving normally from its current position to the target tile
	NORMAL = 790007,
	--- The entity is flying from its current position to the target tile
	FLYING = 789973,
	--- The entity moves normally, but does not respect collisions at the target tile
	UNCHECKED = 788871,
	--- The entity is forced to move onto the target tile
	KNOCKBACK = 794615,
	--- The entity is sliding to the target tile (this affects the movement animation)
	SLIDE = 790015,
	--- The entity teleports to the target tile, disabling any visual effects and bypassing most pre-move checks
	TELEPORT = 2320,
}

--- Attempts to move the specified entity to an absolute position on the level.
--- @param entity Entity The entity to be moved
--- @param x integer Target X-coordinate to move the entity to
--- @param y integer Target Y-coordinate to move the entity to
--- @param moveType? Move.Flag Bitmask of the move flags to use for this movement (defaults to 0, meaning no checks)
--- @return Action.Result result Returns if the move was performed successfully or failed due to an obstruction
--- @return boolean partial `true` if the move was partially obstructed, `false` if the move succeeded or failed fully
function Move.absolute(entity, x, y, moveType) end

--- Attempts to move the specified entity by a relative offset.
--- @param entity Entity The entity to be moved
--- @param dx integer Relative X-offset to move the entity by
--- @param dy integer Relative Y-offset to move the entity by
--- @param moveType? Move.Flag Bitmask of the move flags to use for this movement (defaults to 0, meaning no checks)
--- @return Action.Result result Returns if the move was performed successfully or failed due to an obstruction
--- @return boolean partial `true` if the move was partially obstructed, `false` if the move succeeded or failed fully
function Move.relative(entity, dx, dy, moveType) end

--- Attempts to move the specified entity in the specified direction by a number of tiles.
--- @param entity Entity The entity to be moved
--- @param direction Action.Direction Direction to move the entity in
--- @param distance? integer Number of tiles to move the entity by (defaults to 1)
--- @param moveType? Move.Flag Bitmask of the move flags to use for this movement (defaults to 0, meaning no checks)
--- @return Action.Result result Returns if the move was performed successfully or failed due to an obstruction
--- @return boolean partial `true` if the move was partially obstructed, `false` if the move succeeded or failed fully
function Move.direction(entity, direction, distance, moveType) end

--- Moves the entity back to its previous position
--- @param entity Entity The entity to be moved
--- @param moveType? Move.Flag Bitmask of the move flags to use for this movement (defaults to a forced move)
--- @return Action.Result? result Returns if the move was performed successfully or failed due to an obstruction
--- @return boolean partial `true` if the move was partially obstructed, `false` if the move succeeded or failed fully
function Move.backToPreviousPosition(entity, moveType) end

--- Returns this entity's preferred move flags for self-initiated movement.
--- @param entity Entity Entity to check the move type of
--- @return Move.Flag moveType Bitmask of move flags this entity prefers
function Move.getMoveType(entity) end

return Move
