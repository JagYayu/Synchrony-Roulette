--- @meta

local StateControl = {}

function StateControl.isStartAllowed() end

function StateControl.isPauseAllowed() end

function StateControl.isSeekAllowed() end

function StateControl.isRestartAllowed() end

function StateControl.isEnterLobbyAllowed() end

function StateControl.isChangeLevelAllowed() end

function StateControl.isCooldownActive() end

function StateControl.start(delaySec, songTime) end

function StateControl.restart(delaySec, songTime) end

function StateControl.pause(delaySec) end

function StateControl.pauseBeats(beatCount) end

function StateControl.pauseWithoutMenu() end

function StateControl.unpause(delaySec) end

function StateControl.unpauseBeats(beatCount) end

function StateControl.seekRelative(offset) end

function StateControl.enterLobby(delaySec) end

function StateControl.changeLevel(level, delaySec, songTime) end

function StateControl.sendCustomMessage(message) end

return StateControl
