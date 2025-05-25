--- @meta

local SnapshotRequest = {}

--- Requests a snapshot of the game's current state from the host player.
function SnapshotRequest.sendRequest(turnID) end

--- Broadcasts a snapshot of the current game state to all clients (only available to the host).
function SnapshotRequest.broadcast(turnID) end

function SnapshotRequest.hasIncomingSnapshotForFutureLevel() end

return SnapshotRequest
