--- @meta

local ClientActionBuffer = {}

function ClientActionBuffer.serializeReplay(replayData) end

function ClientActionBuffer.deserializeReplay(serializedReplay) end

function ClientActionBuffer.loadReplay(replayData) end

function ClientActionBuffer.saveReplay() end

function ClientActionBuffer.clear() end

function ClientActionBuffer.reset() end

function ClientActionBuffer.getNextBufferID() end

function ClientActionBuffer.getCurrentBufferID() end

function ClientActionBuffer.addAction(playerID, turnID, actionID, time, args) end

function ClientActionBuffer.getLatestTurnID(playerID) end

function ClientActionBuffer.getTargetTurnID() end

function ClientActionBuffer.getTurnsInRange(firstTurnID, lastTurnID, limit) end

function ClientActionBuffer.getAction(playerID, turnID) end

--- Returns the difference from the given turn’s timestamp to the time of the given player’s action for that turn,
--- or 0 if no such action exists.
function ClientActionBuffer.getTimeDifference(playerID, turnID) end

--- Returns the earliest action time offset for the specified turnID across all players, or 0 if no action was performed
function ClientActionBuffer.getMinimumTimeDifference(turnID) end

function ClientActionBuffer.hasAction(playerID, turnID) end

function ClientActionBuffer.findAvailableTurnID(playerID, firstTurnID, limit) end

function ClientActionBuffer.requestRollback(turnID, delay) end

function ClientActionBuffer.isRollbackPending() end

function ClientActionBuffer.checkRollback() end

function ClientActionBuffer.undelayRollback() end

function ClientActionBuffer.getBuffer() end

--- Initiates a sequence sync for the current action buffer state and sends it over the network
function ClientActionBuffer.initiateSequenceSync() end

--- Enforces a sequence sync with a remote ID list, handles the appropriate rollbacks and checks if the sync is complete
function ClientActionBuffer.checkSequenceSync(sequenceSync) end

function ClientActionBuffer.releaseSequenceSync() end

function ClientActionBuffer.isSequenceSyncActive() end

function ClientActionBuffer.isSequenceSyncComplete() end

function ClientActionBuffer.getParticipantPlayerIDs() end

return ClientActionBuffer
