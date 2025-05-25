--- @meta

local PlatformInput = {}

PlatformInput.KeyboardMode = {
	SINGLE_LINE = 0,
	MULTI_LINE = 1,
	NUMERIC = 2,
	E_MAIL = 3,
}

function PlatformInput.isAvailable() end

function PlatformInput.registerAction(actionName, mappedName, contextID, global) end

function PlatformInput.registerActionAlias(actionName, mappedName, contextID, global) end

function PlatformInput.registerActionContext(actionContextName) end

function PlatformInput.retryRegistrations() end

function PlatformInput.writeDebugInfo() end

function PlatformInput.remapAction(mappedAction, controllerID) end

function PlatformInput.getControllerForAction(mappedAction) end

function PlatformInput.getActionBindings(mappedAction) end

function PlatformInput.getBindingName(bindingID) end

function PlatformInput.getBindingIcon(bindingID) end

function PlatformInput.setContext(controllerID, contextID) end

function PlatformInput.addContext(controllerID, contextID) end

function PlatformInput.removeContext(controllerID, contextID) end

function PlatformInput.resetContext(controllerID) end

function PlatformInput.getAxis(controllerID, axisName) end

function PlatformInput.getControllerIDs() end

function PlatformInput.isControllerConnected(controllerID) end

function PlatformInput.getControllerModel(controllerID) end

function PlatformInput.showConfigurator(controllerID) end

function PlatformInput.showVirtualKeyboard(mode, textBoxRect) end

function PlatformInput.hideVirtualKeyboard() end

function PlatformInput.isVirtualKeyboardVisible() end

function PlatformInput.listHeldActions() end

function PlatformInput.listPressedActions() end

function PlatformInput.skipNextTick() end

function PlatformInput.getActiveController() end

function PlatformInput.clearCache() end

return PlatformInput
