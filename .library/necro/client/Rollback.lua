--- @meta

local Rollback = {}

function Rollback.saveSnapshot(turnID) end

function Rollback.loadSnapshot(turnID) end

function Rollback.deleteSnapshot(turnID) end

function Rollback.pinSnapshot(turnID) end

function Rollback.unpinSnapshot(turnID) end

function Rollback.isSnapshotPinned(turnID) end

function Rollback.unpinAllSnapshots() end

function Rollback.isValidSnapshot(turnID) end

function Rollback.perform(turnID) end

function Rollback.lookUpSnapshotForTurn(turnID) end

function Rollback.getOldestStoredTurnID() end

function Rollback.getMinimumTurnID() end

function Rollback.applySnapshot(snapshotData) end

return Rollback
