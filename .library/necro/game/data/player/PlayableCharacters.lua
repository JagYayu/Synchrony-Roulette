--- @meta

local PlayableCharacters = {}

PlayableCharacters.ID = {
	CADENCE = 1,
	MELODY = 2,
	ARIA = 4,
	DORIAN = 8,
	ELI = 16,
	MONK = 32,
	DOVE = 64,
	CODA = 128,
	BOLT = 256,
	BARD = 512,
	NOCTURNA = 1024,
	DIAMOND = 2048,
	MARY = 4096,
	TEMPO = 8192,
}

function PlayableCharacters.variant(ev, suffix) end

function PlayableCharacters.addCommonCharacterComponents(entity) end

function PlayableCharacters.addCommonHeadComponents(headEntity) end

function PlayableCharacters.addCharacterGraphics(entity) end

function PlayableCharacters.addCharacterSounds(entity, soundGroupPrefix) end

function PlayableCharacters.addCharacterSpecificData(entity, headEntity, characterData) end

return PlayableCharacters
