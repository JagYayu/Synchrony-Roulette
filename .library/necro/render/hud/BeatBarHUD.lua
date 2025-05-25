--- @meta

local BeatBarHUD = {}

function BeatBarHUD.setVisible(visible) end

function BeatBarHUD.isVisible() end

--- @return VertexBuffer.DrawArgs
function BeatBarHUD.getBeatBarVisual(texture) end

function BeatBarHUD.render(args) end

return BeatBarHUD
