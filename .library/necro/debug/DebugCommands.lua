--- @meta

local DebugCommands = {}

function DebugCommands.print(...) end

function DebugCommands.bard(enabled) end

function DebugCommands.char(entityType) end

function DebugCommands.sendClientTransfer(size, channel) end

function DebugCommands.cancelClientTransfer() end

function DebugCommands.reconnect() end

function DebugCommands.level(levelNumber) end

function DebugCommands.spawn(entityType, dx, dy, attributes) end

function DebugCommands.skip() end

function DebugCommands.musicSeek(seconds) end

function DebugCommands.transferHost(playerID) end

function DebugCommands.forceStart(seconds) end

function DebugCommands.songEnd() end

function DebugCommands.spectate() end

function DebugCommands.players() end

function DebugCommands.kick(playerID) end

function DebugCommands.ban(playerID) end

function DebugCommands.unbanAll() end

function DebugCommands.changePlayerID(id1, id2) end

function DebugCommands.revive(playerID) end

function DebugCommands.dumpTextPoolKillerName() end

function DebugCommands.removeLeaderboardEntry(boardID) end

function DebugCommands.listLeaderboards() end

function DebugCommands.lockAchievement(achievementName) end

function DebugCommands.netDebug() end

function DebugCommands.showLobbyID() end

function DebugCommands.joinUDP(ip, port) end

function DebugCommands.joinSteam(lobbyID) end

function DebugCommands.joinGalaxy(lobbyID) end

function DebugCommands.saveDungeon(name) end

function DebugCommands.timeScale(factor) end

function DebugCommands.credits(index) end

function DebugCommands.tutorial() end

function DebugCommands.translateMods() end

return DebugCommands
