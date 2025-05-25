--- @meta

local GameState = {}

function GameState.reset(args) end

function GameState.isInGame() end

function GameState.isPaused() end

function GameState.isInLobby() end

function GameState.isInMainMenu() end

function GameState.isPlaying() end

function GameState.hasPendingTransition() end

function GameState.getCountdown() end

return GameState
