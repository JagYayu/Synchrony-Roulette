--- @meta

local SizeModifier = {}

SizeModifier.Size = {
	TINY = -1,
	NORMAL = 0,
	GIGANTIC = 1,
}

function SizeModifier.isTiny(entity) end

function SizeModifier.isGigantic(entity) end

function SizeModifier.setSize(entity, size, turns) end

function SizeModifier.grow(entity, turns) end

function SizeModifier.ungrow(entity) end

function SizeModifier.shrink(entity, turns) end

function SizeModifier.unshrink(entity) end

return SizeModifier
