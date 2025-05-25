--- @meta

local TrapClientTrigger = {}

function TrapClientTrigger.hasPendingRunStart() end

function TrapClientTrigger.getPrimaryPlayer(includeSpectators) end

function TrapClientTrigger.playerReverseStep(entity) end

function TrapClientTrigger.isConfirmationPromptEnabled() end

function TrapClientTrigger.checkClientTrigger(playerEntity, triggerEntity) end

function TrapClientTrigger.updateAll() end

function TrapClientTrigger.isPrimaryPlayerEntity(entity) end

function TrapClientTrigger.selectCharacter(entity, characterType) end

return TrapClientTrigger
