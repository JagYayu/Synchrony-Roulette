--- @meta

local Beatmap = {}

function Beatmap.createStandalone() end

function Beatmap.init(playerID) end

function Beatmap.get(playerID) end

function Beatmap.getForEntity(entity) end

--- Returns the beatmap for the primary player. This is useful for global visuals (shared HUD, entity animations, etc.).
--- @return table
function Beatmap.getPrimary() end

--- Returns the unmodified beatmap from the DannyB version of the current song.
function Beatmap.getOriginal() end

function Beatmap.reset() end

function Beatmap.skipOverdueBeats() end

function Beatmap.skipOverdueBeatsImmediately() end

function Beatmap.getAudioLatency() end

function Beatmap.getClockDrift() end

return Beatmap
