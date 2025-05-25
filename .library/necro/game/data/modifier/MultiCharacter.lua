--- @meta

local MultiCharacter = {}

MultiCharacter.Order = {
	FIXED = 1,
	PLAYER_CHOICE = 2,
}

MultiCharacter.Mode = {
	NONE = 0,
	ALL_CHARACTERS = 1,
	ALL_CHARACTERS_AMPLIFIED = 2,
	ALL_CHARACTERS_SYNCHRONY = 3,
	STORY_MODE = 4,
	STORY_MODE_AMPLIFIED = 5,
	ALL_CHARACTERS_MODDED = 6,
	ENSEMBLE = 7,
}

function MultiCharacter.getMode() end

function MultiCharacter.isActive() end

function MultiCharacter.getSpeedrunTimeForCharacter(characterName) end

function MultiCharacter.getCharacterList() end

function MultiCharacter.getModifiedPlayerCharacterMap(initialCharacters, characterChoice, removeSpectators) end

return MultiCharacter
