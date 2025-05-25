--- @meta

local Charge = {}

function Charge.begin(entity, direction) end

--- @parem orthogonalize boolean If true, diagonal directions are converted to horizontal
function Charge.redirect(entity, direction, orthogonalize) end

function Charge.stop(entity) end

return Charge
