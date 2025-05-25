--- @meta

local CharacterSelector = {}

function CharacterSelector.openInGame(playerID, callback) end

function CharacterSelector.closeInGame() end

function CharacterSelector.isOpen() end

function CharacterSelector.setSelectedCharacter(playerID, character) end

function CharacterSelector.getSelectedCharacter(playerID) end

function CharacterSelector.setSpectating(playerID, spectating) end

function CharacterSelector.isSpectating(playerID) end

function CharacterSelector.setPreferredCharacter(localIndex, charName) end

function CharacterSelector.getPreferredCharacter(localIndex) end

return CharacterSelector
