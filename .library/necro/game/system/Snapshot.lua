--- @meta

local Snapshot = {}

--- Registers a variable to be automatically subjected to rollback and network synchronization.
--- The return value of this function must be assigned to a global variable, which will store the snapshotted value.
--- Does not reset automatically.
--- @generic T
--- @param defaultValue? T Initial value for this snapshot variable
--- @param complexData boolean? If true, allows serializing entity references and arrays, at the cost of reduced performance.
--- @return T
function Snapshot.variable(defaultValue, complexData) end

--- Registers a variable to be automatically subjected to rollback and network synchronization.
--- The return value of this function must be assigned to a global variable, which will store the snapshotted value.
--- Automatically resets when starting a new run.
--- @generic T
--- @param defaultValue? T Initial value for this snapshot variable
--- @param complexData boolean? If true, allows serializing entity references and arrays, at the cost of reduced performance.
--- @return T
function Snapshot.runVariable(defaultValue, complexData) end

--- Registers a variable to be automatically subjected to rollback and network synchronization.
--- The return value of this function must be assigned to a global variable, which will store the snapshotted value.
--- Automatically resets when starting a new sub-run/loop (for example, a new character in All Characters mode).
--- @generic T
--- @param defaultValue? T Initial value for this snapshot variable
--- @param complexData boolean? If true, allows serializing entity references and arrays, at the cost of reduced performance.
--- @return T
function Snapshot.loopVariable(defaultValue, complexData) end

--- Registers a variable to be automatically subjected to rollback and network synchronization.
--- The return value of this function must be assigned to a global variable, which will store the snapshotted value.
--- Automatically resets when starting a new level.
--- @generic T
--- @param defaultValue? T Initial value for this snapshot variable
--- @param complexData boolean? If true, allows serializing entity references and arrays, at the cost of reduced performance.
--- @return T
function Snapshot.levelVariable(defaultValue, complexData) end

function Snapshot.invariant(defaultValue, complexData) end

function Snapshot.create(id) end

function Snapshot.restore(id) end

function Snapshot.isValid(id) end

function Snapshot.drop(id) end

function Snapshot.clearAll() end

function Snapshot.serialize(id) end

function Snapshot.deserialize(data) end

return Snapshot
