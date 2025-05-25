--- @meta

local ModLabel = {}

ModLabel.Type = {
	FAVORITE = 1,
	HIDDEN = 2,
}

function ModLabel.add(modName, label) end

function ModLabel.remove(modName, label) end

function ModLabel.toggle(modName, label) end

function ModLabel.getLabels(modName) end

function ModLabel.isPresent(modName, label) end

return ModLabel
