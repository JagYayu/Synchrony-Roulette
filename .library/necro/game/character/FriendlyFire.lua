--- @meta

local FriendlyFire = {}

function FriendlyFire.isEnabled() end

function FriendlyFire.getPlayerID(entity) end

function FriendlyFire.isDamageSuppressed(attacker, victim) end

--- Allows the specified player to attack others in the current turn (if performed before turn order 'friendlyFire')
--- or next turn (if performed after turn order 'friendlyFire').
--- The player's entity must have the `friendlyFireEnableAttacks` component for this function to have an effect.
--- @param playerID Player.ID ID of the player to allow a friendly fire attack for.
function FriendlyFire.queueAttack(playerID) end

return FriendlyFire
