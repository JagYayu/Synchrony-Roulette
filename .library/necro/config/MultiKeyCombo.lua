--- @meta

local MultiKeyCombo = {}

function MultiKeyCombo.isModifierKey(keyName) end

function MultiKeyCombo.setInputBufferEnabled(enabled) end

function MultiKeyCombo.isInputBufferEnabled() end

function MultiKeyCombo.setKeyCombos(keyCombos) end

function MultiKeyCombo.setModifierCombos(modifierCombos) end

function MultiKeyCombo.listPresses() end

function MultiKeyCombo.isPressed(keyCombo) end

function MultiKeyCombo.listOngoingCombos() end

function MultiKeyCombo.suppress(keyCombo) end

function MultiKeyCombo.cancelOngoingCombo(key) end

function MultiKeyCombo.simulate(keyID, timestamp) end

return MultiKeyCombo
