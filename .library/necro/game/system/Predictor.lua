--- @meta

local Predictor = {}

function Predictor.isSpeculationEnabled() end

function Predictor.isGameStateSpeculative() end

function Predictor.speculateEarlyBeat() end

function Predictor.speculateUntilPlayerActed(playerID) end

function Predictor.speculateUntilLocalPlayersActed() end

return Predictor
