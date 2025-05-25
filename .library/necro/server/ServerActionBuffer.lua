--- @meta

local ServerActionBuffer = {}

function ServerActionBuffer.reset(roomID) end

function ServerActionBuffer.getActionBuffer(roomID) end

function ServerActionBuffer.getReplays(roomID, snapshot) end

function ServerActionBuffer.getReplayWithSnapshot(roomID, snapshot) end

function ServerActionBuffer.forceAction(playerID, turnID, actionID, time, args) end

function ServerActionBuffer.addAction(playerID, turnID, actionID, time, args) end

function ServerActionBuffer.receiveMessage(playerID, message, parentPlayerID) end

function ServerActionBuffer.removeActions(playerID, sequenceIDs) end

function ServerActionBuffer.changeLevel(roomID, level, bufferID) end

function ServerActionBuffer.getSequenceIDs(roomID) end

function ServerActionBuffer.performSequenceSync(roomID, sequenceIDs, bufferID) end

function ServerActionBuffer.getLatestTurnID(roomID, playerID) end

function ServerActionBuffer.setSpectatorMode(playerID, spectator) end

return ServerActionBuffer
