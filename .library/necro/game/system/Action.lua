--- @meta

local Action = {}

--- @alias Action.ID Action.Direction|Action.Special|Action.System

--- @enum Action.Direction
Action.Direction = {
	NONE = 0,
	RIGHT = 1,
	UP_RIGHT = 2,
	UP = 3,
	UP_LEFT = 4,
	LEFT = 5,
	DOWN_LEFT = 6,
	DOWN = 7,
	DOWN_RIGHT = 8,
}

--- @enum Action.Rotation
Action.Rotation = {
	IDENTITY = 1,
	CCW_45 = 2,
	CCW_90 = 3,
	CCW_135 = 4,
	MIRROR = 5,
	CW_135 = 6,
	CW_90 = 7,
	CW_45 = 8,
}

--- @enum Action.Special
Action.Special = {
	IDLE = 0,
	ITEM_1 = 9,
	ITEM_2 = 10,
	BOMB = 11,
	THROW = 12,
	SPELL_1 = 13,
	SPELL_2 = 14,
	PING_NEARBY = 15,
	CharacterSkins_CharSkins_update = 16,
	NecroEdit_Cmd = 17,
	NecroEdit_CmdP = 18,
	EnsembleChooseCharacter = 19,
	CoopSoulLink = 20,
	LobbyResetPos = 21,
	TriggerFadeout = 22,
	TriggerChangeCharacter = 23,
	TriggerConfirm = 24,
}

--- @enum Action.System
Action.System = {
	--- Changes the player entity to be intangible, enabling spectator mode. Automatically performed on disconnect.
	SPECTATE = -1,
	--- Changes the player entity to be tangible, disabling spectator mode.
	UNSPECTATE = -2,
	--- Spawns a character entity and associates it with the player, if no character has been spawned by the player yet.
	--- Action parameter [string]: the character entity type to spawn
	SPAWN_PLAYER_CHARACTER = -3,
	--- Drops the player's groove chain, but does not permit enemies to move.
	MISSED_BEAT = -4,
	--- Deprecated; use action.System.DELAY instead.
	TRAP = -5,
	--- Fire the songEnd event for the player.
	SONG_ENDED = -6,
	--- Represents an action-less turn, allowing for the execution of deferred logic after a real-time delay.
	DELAY = -7,
	--- Returns a descended player entity back to the level.
	ASCEND = -8,
	--- Sets the pickup limit for a player
	PICKUP_LIMIT = -9,
	--- Dismisses the boss splash HUD for all players, but does nothing otherwise
	DISMISS_BOSS_SPLASH = -10,
	--- Causes the next action to be performed with friendly fire enabled
	FRIENDLY_FIRE = -11,
}

--- @enum Action.Result
Action.Result = {
	--- Invalid action (e.g. trying to use non-existent item or spell)
	INVALID = -2,
	--- Movement failure (bumping into an undiggable wall or entity)
	FAIL = -1,
	--- No action taken
	IDLE = 0,
	--- A movement was performed successfully
	MOVE = 1,
	--- An entity was attacked successfully
	ATTACK = 2,
	--- A wall was dug successfully
	DIG = 3,
	--- A spell was cast successfully
	SPELL = 4,
	--- An active item was used successfully
	ITEM = 5,
	--- Emerging from a liquid tile
	UNSINK = 6,
	--- Movement was prevented due to a status effect (e.g. frozen)
	INHIBIT = 7,
	--- An entity was interacted with successfully
	INTERACT = 8,
	--- No action is possible because of beat delay
	DELAY = 9,
	--- A custom action was performed without returning a specific action result
	CUSTOM = 10,
}

--- Generates a directional action to move orthogonally or diagonally towards the specified offset.
--- Offsets are clamped to the range [-1, 1].
--- @param dx integer Horizontal offset of the movement action
--- @param dy integer Vertical offset of the movement action
--- @return Action.Direction direction The movement action corresponding to the specified offset, or `NONE` for 0, 0
function Action.move(dx, dy) end

--- Gets the direction closest to the specified offset.
--- Unlike `action.move`, this function is not biased towards diagonals.
--- @param dx integer Horizontal offset of the movement action
--- @param dy integer Vertical offset of the movement action
--- @return Action.Direction direction The movement action corresponding to the specified offset, or `NONE` for 0, 0
function Action.getDirection(dx, dy) end

--- Returns the movement offset corresponding to the specified directional action.
--- Non-directional actions return 0, 0.
--- @param direction Action.Direction The directional action to compute the offset of.
--- @return integer dx The action's horizontal offset
--- @return integer dy The action's vertical offset
function Action.getMovementOffset(direction) end

--- Returns the horizontal movement offset corresponding to the specified directional action.
--- Non-directional actions return 0.
--- @param direction Action.Direction The directional action to compute the horizontal offset of.
--- @return integer dx The action's horizontal offset
function Action.dx(direction) end

--- Returns the vertical movement offset corresponding to the specified directional action.
--- Non-directional actions return 0.
--- @param direction Action.Direction The directional action to compute the vertical offset of.
--- @return integer dy The action's vertical offset
function Action.dy(direction) end

--- Rotates a relative coordinate pair by the specified rotation offset.
--- @param x integer Horizontal offset before rotation
--- @param y integer Vertical offset before rotation
--- @param rotation Action.Rotation The rotation to apply to the coordinate pair
--- @return integer rx Horizontal offset after rotation
--- @return integer ry Vertical offset after rotation
function Action.rotate(x, y, rotation) end

--- Rotates the specified directional action by a rotation offset.
--- @param direction Action.Direction The directional action to rotate. If non-directional, no rotation is applied
--- @param rotation Action.Rotation The rotation to apply to the direction
--- @return Action.Direction result Direction after applying the rotation, or the unmodified input for non-directions
function Action.rotateDirection(direction, rotation) end

--- Returns the opposite rotation for a given rotation, such that input and output cancel each other out.
--- @param rotation Action.Rotation The rotation to get the counter-rotation for
--- @return Action.Rotation counter The resulting counter-rotation
function Action.counterRotation(rotation) end

--- Checks if the specified numeric action is a directional action, excluding `NONE`.
--- @param act Action.ID ID of the action to check
--- @return boolean result `true` for directional actions, `false` for special or system actions
function Action.isDirection(act) end

--- Checks if the specified numeric action is an orthogonal action.
--- @param act Action.ID ID of the action to check
--- @return boolean result `true` for orthogonal directions, `false` for diagonals, special or system actions
function Action.isOrthogonalDirection(act) end

--- Checks if the specified numeric action is a diagonal action.
--- @param act Action.ID ID of the action to check
--- @return boolean result `true` for diagonal directions, `false` for orthogonals, special or system actions
function Action.isDiagonalDirection(act) end

--- Returns the closest orthogonal direction for a given diagonal action, prioritizing the horizontal component.
--- Orthogonal actions, special actions or system actions are passed through without modification.
--- @param act Action.ID Action to orthogonalize
--- @return Action.ID result Orthogonalized action for diagonals, unmodified input otherwise
function Action.orthogonalize(act) end

--- Legacy function - checks if an action can be performed normally.
--- @deprecated Use `Ability.getActionFlags()` instead.
--- @param act Action.ID Action to check
--- @return boolean result `true` for system actions, `false` otherwise
function Action.isAllowed(act) end

--- Legacy function - checks if an action is a system action.
--- @deprecated Use `Ability.getActionFlags()` instead.
--- @param act Action.ID Action to check
--- @return boolean result `true` for system actions, `false` otherwise
function Action.isSystemAction(act) end

--- Returns the angle corresponding to a directional action.
--- @param direction Action.Direction The direction to compute the angle of
--- @return number angle Angle of the direction in radians
function Action.getAngle(direction) end

--- Checks if the specified action result is considered successful.
--- @param result Action.Result Action result to check
--- @return boolean success `true` for successful results, `false` for failure result (drops coin multiplier)
function Action.isResultSuccessful(result) end

return Action
