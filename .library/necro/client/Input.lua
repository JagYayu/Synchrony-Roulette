--- @meta

local Input = {}

Input.AutoMoveMode = {
	NEVER = 0,
	ANY_TEMPO = 1,
	DOUBLE_TEMPO = 2,
	QUADRUPLE_TEMPO = 3,
}

--- Inputs an action on behalf of the specified local player.
function Input.add(actionID, playerID, args) end

--- Returns `true` if player keypresses should be ignored (such as when a UI is open).
--- Overdue beats are still processed in this case.
function Input.isBlocked() end

--- Returns `true` if no actions can be performed by any local players.
--- Overdue beats are also blocked by this.
function Input.isPlayerInputBlocked() end

--- Returns `true` if the game automatically pauses when the pause button is pressed.
function Input.isAutoPauseActive() end

function Input.updatePlatformInputContext() end

return Input
