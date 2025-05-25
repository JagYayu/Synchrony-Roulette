--- @meta

local ServerRooms = {}

function ServerRooms.setDefaultRoomID(roomID) end

function ServerRooms.getDefaultRoomID() end

function ServerRooms.isValidRoom(roomID) end

function ServerRooms.createRoom() end

function ServerRooms.deleteRoom(roomID) end

function ServerRooms.setPlayerRoom(playerID, roomID) end

function ServerRooms.sendPlayerToDefaultRoom(playerID) end

function ServerRooms.setPlayerRetentionEnabled(roomID, retainPlayers) end

function ServerRooms.isPlayerRetentionEnabled(roomID) end

function ServerRooms.playersInRoom(roomID) end

function ServerRooms.isEmpty(roomID) end

function ServerRooms.playersInRoomIncludeDisconnected(roomID) end

function ServerRooms.playersInRoomExcept(roomID, exceptPlayerID) end

function ServerRooms.getResources(roomID) end

function ServerRooms.setHost(roomID, playerID) end

function ServerRooms.getHost(roomID) end

function ServerRooms.assignHostIfNeeded(roomID) end

function ServerRooms.setGameState(roomID, gameState) end

function ServerRooms.getGameState(roomID) end

function ServerRooms.getAttribute(roomID, key) end

function ServerRooms.setAttribute(roomID, key, value) end

function ServerRooms.listRooms() end

return ServerRooms
