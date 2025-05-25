--- @meta

local Ability = {}

Ability.Flag = {
	--- Checks the beatmap before performing the action, snapping it to the next beat or failing it if the input was too
	--- early after the most recent beat. Unsetting this bit allows the action to be inserted between beats on the
	--- beatmap, and does not count as a full beat, preventing the beatmap's counter from being advanced.
	--- Checked only on the client-side for local players.
	BEATMAP = 1,
	--- If set, the input does not affect the beatmap and is not sent across the network.
	--- Checked only on the client-side for local players.
	IGNORE_ACTION = 2,
	--- Sets the player's "gameObject.active" attribute, allowing all nearby entities to act.
	ACTIVATE_OBJECT = 4,
	--- Runs any pending delays for this player immediately.
	PREEMPT_DELAYS = 8,
	--- Performs the action within the turn's player action queue, sorted by sub-beat timing.
	ACTION_QUEUE = 16,
	--- Suppresses the action if a beat delay is currently active.
	CHECK_BEAT_DELAY = 32,
	--- Suppresses the action if the entity is currently stunned.
	CHECK_STUN = 64,
	--- Overrides the action if the entity is currently sliding or charging.
	OVERRIDABLE = 128,
	--- Dismisses the boss screen splash and allows enemies in the pre-boss room to move
	BEGIN_BOSS_LEVEL = 256,
	--- Skips any "Missed beat!" visual/audio effects if this action was not correctly timed
	RHYTHM_LENIENCY = 512,
}

Ability.Type = {
	--- System actions do not have any special properties
	SYSTEM = 0,
	--- Default flags for directions
	DIRECTION = 509,
	--- Default flags for special actions
	SPECIAL = 501,
	--- Default flags for idling
	IDLE = 245,
	--- Default flags for custom actions
	DEFAULT = 501,
	--- Default flags for sub-beat actions (special abilities that do not consume a turn)
	SUB_BEAT = 16,
}

--- Returns the unmodified ability flags associated with the specified action
--- @param actionID Action.Direction|Action.Special|Action.System
--- @return Ability.Flag flags Bitmask of ability flags associated with this action
function Ability.getActionFlags(actionID) end

function Ability.checkGameplayAction(playerID, actionID, args) end

return Ability
