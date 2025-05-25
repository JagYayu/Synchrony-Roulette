--- @meta

local Input = {}

--- Checks if the key with the specified name is currently pressed.
function Input.keyDown(keyname) end

--- Checks if the key with the specified name was just pressed.
function Input.keyPress(keyname) end

--- Checks if the key with the specified name was just released.
function Input.keyRelease(keyname) end

--- Suppresses the specified keypress, preventing it from being recognized as pressed within the same frame.
function Input.suppressKey(keyname) end

function Input.isKeySuppressed(keyname) end

--- Returns a list containing all keys that were pressed down in the current frame.
function Input.getPressedKeys() end

--- Returns a list containing all keys that are being held down in the current frame.
function Input.getHeldKeys() end

--- Checks if the specified mouse button is pressed.
--- Passing nil tests any mouse button.
--- Available options: "left" (1), "right" (2), "middle" (3), "extra1" (4), "extra2" (5)
function Input.mouseDown(button) end

function Input.mousePress(button) end

function Input.mouseRelease(button) end

--- Returns the horizontal mouse position.
--- @return integer
function Input.mouseX() end

--- Returns the vertical mouse position.
--- @return integer
function Input.mouseY() end

--- Returns the horizontal scrolling distance for this frame.
function Input.scrollX() end

--- Returns the vertical scrolling distance for this frame.
function Input.scrollY() end

--- Returns true if the mouse is over the game window, false if the mouse is off the game window.
function Input.mouseFocus() end

--- Returns a list of unicode codepoints entered in the current frame.
function Input.text() end

--- Returns a list of raw key press/release events for this frame.
function Input.rawEvents() end

--- Looks up the name of a raw key by its ID.
function Input.lookUpRawKey(keyID) end

--- Returns the ID of a key by its name.
function Input.getRawKeyID(keyName) end

--- Returns true if any key was pressed in this frame.
function Input.anyKeyPressed() end

function Input.getControllerInfo(index) end

function Input.isLegacyControllerEnabled() end

--- [nodoc] Unsupported.
function Input.appendKeyEvents(events) end

return Input
