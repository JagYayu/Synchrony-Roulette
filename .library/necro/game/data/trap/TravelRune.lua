--- @meta

local TravelRune = {}

TravelRune.Type = {
	TRANSMOGRIFIER = 1,
	ARENA = 2,
	BLOOD = 3,
	GLASS = 4,
	FOOD = 5,
	CONJURER = 6,
	SHRINER = 7,
	PAWNBROKER = 8,
}

function TravelRune.register(type, components) end

return TravelRune
