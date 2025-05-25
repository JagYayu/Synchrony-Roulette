--- @meta

local Player = {}

--- @alias Player.ID integer Numeric ID of a player; may not be sequential
--- @alias Player.CharacterMap table<Player.ID,string> Maps player IDs to their chosen characters' entity type names

function Player.setControlledEntity(playerID, entityID) end

function Player.isPlayerEntity(entity) end

function Player.getPlayerEntityID(playerID) end

--- @param playerID? Player.ID
--- @return Entity?
function Player.getPlayerEntity(playerID) end

function Player.isAlone() end

function Player.getLiveCount() end

function Player.getCount() end

--- @return Entity[]
function Player.getPlayerEntities() end

function Player.getFocusedEntityIDs() end

function Player.getSelectedPlayerCharacters(includeSpectators) end

--- Returns the mapping from player ID to character type name at the start of this run.
--- @return Player.CharacterMap
function Player.getInitialCharacterMap() end

--- Returns a list of entity type names for each selected character, in order of ascending player ID
--- @return string[]
function Player.getInitialCharacterList() end

function Player.getCharacterType(playerID) end

function Player.setCharacterType(playerID, characterType) end

function Player.isCharacterSpawned(playerID) end

function Player.getPlayableCharacterTypes() end

function Player.firstWithComponent(componentName) end

function Player.isValidCharacterType(characterType) end

function Player.isCharacterLockEnabled() end

function Player.setLateJoinCharacterOverride(entityType) end

function Player.getLateJoinCharacterOverride() end

function Player.isLateJoinEnabled() end

function Player.replacePlayer(entity, targetType) end

function Player.replaceAllPlayers(targetType) end

function Player.resetAndDeleteAllPlayers() end

return Player
