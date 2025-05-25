--- @meta

local Checksum = {}

--- Returns a checksum for the specified turnID based on the inputs processed so far.
--- This is used for detecting and fixing desynchronizations between clients in multiplayer sessions.
--- @param turnID? Turn.ID Turn to check the checksum for (default: current turn)
--- @return integer? turnChecksum Numeric checksum for the specified turn based on inputs processed so far
function Checksum.getInputChecksum(turnID) end

--- Returns a checksum for the specified turnID based on the game state.
--- This is used for detecting and fixing desynchronizations between clients in multiplayer sessions.
--- @param turnID? Turn.ID Turn to check the checksum for (default: current turn)
--- @return integer? turnChecksum Numeric checksum for the specified turn based on game state
function Checksum.getStateChecksum(turnID) end

return Checksum
