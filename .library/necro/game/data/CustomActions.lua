--- @meta

local CustomActions = {}

--- @class CustomActionDefinition
--- @field id string Identifier for the action. Mandatory field, and must be unique within the mod.
--- @field name string Name of the action to display in the controls menu. Defaults to prettified ID.
--- @field keyBinding string|table List of keys to assign to player 1 by default. If nil, disallows binding the action.
--- @field handler fun(entity:Entity,args:any):integer In-turn callback for players or enemies performing this action.
--- @field callback fun(playerID:integer,args:any) Callback invoked in-turn when the action is performed.
--- @field callbackOrder table Overrides when this action's handler is invoked within a turn/tick.
--- @field abilityFlags integer Bitmask of `Ability.Flag` values, controlling when/how this action can be performed.
--- @field clientOnly boolean If true, the action is treated as a client hotkey, called on-tick for the local client.
--- @field perPlayerBinding boolean If true, allows binding the action per-player within the "gameplay controls" menu.
--- @field enableIf fun(playerID:integer):boolean Client-side precondition for enabling the hotkey.
--- @field argSupplier fun(playerID:integer):any Invoked on the client to determine the value of the 'arg' parameter.

--- @class CustomAction.ActionArgs
--- @field id string Identifier for the action. Mandatory field, and must be unique within the mod.
--- @field name string Name of the action to display in the controls menu. Defaults to prettified ID.
--- @field keyBinding string|table List of keys to assign to player 1 by default. If nil, disallows binding the action.
--- @field handler fun(entity:Entity,args:any):integer In-turn callback for players or enemies performing this action.
--- @field argSupplier fun(playerID:integer):any Invoked on the client to determine the value of the 'arg' parameter.

--- @class CustomAction.SystemArgs
--- @field id string Identifier for the action. Mandatory field, and must be unique within the mod.
--- @field callback fun(playerID:integer,args:any) Callback invoked when the action is performed.
--- @field callbackOrder? table Overrides when this action's handler is invoked within a turn.

--- @class CustomAction.HotkeyArgs
--- @field id string Identifier for the hotkey. Mandatory field, and must be unique within the mod.
--- @field name string Name of the hotkey to display in the controls menu. Defaults to prettified ID.
--- @field keyBinding string|table Key or list of keys to assign to this hotkey by default.
--- @field callback fun(playerID:integer):boolean? Callback invoked when the hotkey is pressed.
--- @field callbackOrder table Overrides when this hotkey's handler is invoked within a tick.
--- @field perPlayerBinding boolean If true, allows binding the hotkey per-player within the "gameplay controls" menu.
--- @field enableIf fun(playerID:integer):boolean Client-side precondition for enabling the hotkey.

--- Defines a new custom bindable gameplay action.
--- @param args CustomAction.ActionArgs
--- @return any id Returns the unique action ID, for use in `ClientActionBuffer.addAction()` and related functions.
--- @return fun(playerID?:integer,args:any) perform Performs the custom action for the specified local player.
function CustomActions.registerAction(args) end

--- Defines a new custom system action, which can be invoked via script.
--- @param args CustomAction.SystemArgs
--- @return any id Returns the unique action ID, for use in `ClientActionBuffer.addAction()` and related functions.
--- @return fun(playerID?:integer,args:any) perform Performs the custom action for the specified local player.
function CustomActions.registerSystemAction(args) end

--- Defines a new custom bindable sub-beat action, which can be pressed independently of the beatmap.
--- @param args CustomAction.ActionArgs
--- @return any id Returns the unique action ID, for use in `ClientActionBuffer.addAction()` and related functions.
--- @return fun(playerID?:integer,args:any) perform Performs the custom action for the specified local player.
function CustomActions.registerSubBeatAction(args) end

--- Defines a new custom bindable client hotkey.
--- @param args CustomAction.HotkeyArgs
function CustomActions.registerHotkey(args) end

return CustomActions
