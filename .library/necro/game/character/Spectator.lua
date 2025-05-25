--- @meta

local Spectator = {}

function Spectator.setSpectating(playerID, spectating) end

function Spectator.isSpectating(playerID) end

function Spectator.getNextSpawnablePlayerID() end

function Spectator.isLateJoinCharacterSelectable() end

function Spectator.join(playerID) end

function Spectator.toggle(playerID) end

function Spectator.isActive() end

function Spectator.setTargetPlayerID(playerID) end

function Spectator.getTargetPlayerID() end

function Spectator.getAvailableTargetPlayerIDs() end

function Spectator.nextPlayer() end

function Spectator.previousPlayer() end

return Spectator
