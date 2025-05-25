--- @meta

local Menu = {}

function Menu.playSelectionSound(direction, currentMenu, soundOverride) end

function Menu.getEntryFade(entry, currentMenu) end

function Menu.getMenuRect(currentMenu) end

function Menu.getInnerHeight(currentMenu) end

function Menu.getCurrent() end

function Menu.getNonPopup() end

function Menu.getPopup() end

function Menu.getName(curMenu) end

function Menu.getSelection(currentMenu) end

function Menu.setSelection(selection, currentMenu) end

function Menu.changeSelection(diff, silent, currentMenu) end

function Menu.getSelectedID(currentMenu) end

function Menu.selectByID(id, currentMenu) end

function Menu.getSelectedEntry(currentMenu) end

function Menu.scrollToTarget(currentMenu, ignoreMouse) end

function Menu.suppressKeyRepeats(currentMenu) end

function Menu.isTextEntryActive(currentMenu) end

function Menu.setTextEntryActive(currentMenu, textEntryActive, confirm) end

function Menu.activateTextEntry(entryID, currentMenu) end

function Menu.toggleTextEntry(currentMenu) end

function Menu.setMouseControlActive(active) end

function Menu.isMouseControlActive() end

function Menu.suppressMouseControlForTick() end

function Menu.suppressKeyControlForTick() end

function Menu.open(menuName, arg) end

function Menu.update() end

function Menu.updateAll() end

function Menu.closeAll() end

function Menu.close() end

function Menu.closeNamed(name) end

function Menu.isOpen() end

return Menu
