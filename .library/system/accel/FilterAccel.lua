--- @meta

local FilterAccel = {}

function FilterAccel.getImageParameter(image) end

function FilterAccel.offsetImageParameter(args, dx, dy) end

function FilterAccel.resizeImageParameter(args, width, height) end

function FilterAccel.apply(filterType, args) end

return FilterAccel
