--- @meta

local ModImage = {}

ModImage.Type = {
	BANNER = 1,
	ICON = 2,
}

function ModImage.load(modName, imageType, immediate) end

function ModImage.getPath(modName, imageType) end

return ModImage
