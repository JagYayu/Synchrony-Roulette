--- @meta

local SessionPresence = {}

SessionPresence.Mode = {
	NEVER = 0,
	MULTIPLAYER_ONLY = 1,
	SINGLE_PLAYER_ONLY = 2,
	ALWAYS = 3,
}

return SessionPresence
