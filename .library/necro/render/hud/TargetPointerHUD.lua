--- @meta

local TargetPointerHUD = {}

--- @class TargetPointerHUD.DrawArgs
--- @field x integer
--- @field y integer
--- @field margin? number
--- @field image? string
--- @field ignoreOnScreen? boolean
--- @field allowOnScreen? boolean
--- @field noDraw? boolean
--- @field rotate? boolean
--- @field texRect? Rectangle
--- @field scale? number

--- @param args TargetPointerHUD.DrawArgs
function TargetPointerHUD.draw(args) end

return TargetPointerHUD
