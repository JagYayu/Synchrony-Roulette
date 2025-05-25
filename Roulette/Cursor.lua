local RouletteCursor = {}
local RouletteGambler = require "Roulette.Gambler"
local RouletteItem = require "Roulette.Item"
local RouletteJudge = require "Roulette.Judge"
local RouletteRogue = require "Roulette.Rogue"
local RouletteUtility = require "Roulette.Utility"

local Ability = require "necro.game.system.Ability"
local Action = require "necro.game.system.Action"
local Camera = require "necro.render.Camera"
local Config = require "necro.config.Config"
local Controls = require "necro.config.Controls"
local Currency = require "necro.game.item.Currency"
local CustomActions = require "necro.game.data.CustomActions"
local ECS = require "system.game.Entities"
local EntitySelector = require "system.events.EntitySelector"
local Flyaway = require "necro.game.system.Flyaway"
local GameInput = require "necro.client.Input"
local GameState = require "necro.client.GameState"
local Input = require "system.game.Input"
local ItemPickup = require "necro.game.item.ItemPickup"
local LocalCoop = require "necro.client.LocalCoop"
local Map = require "necro.game.object.Map"
local Move = require "necro.game.system.Move"
local Object = require "necro.game.object.Object"
local ObjectMap = require "necro.game.object.Map"
local ObjectSelector = require "necro.game.object.ObjectSelector"
local Player = require "necro.game.character.Player"
local Settings = require "necro.config.Settings"
local Sound = require "necro.audio.Sound"
local SoundGroups = require "necro.audio.SoundGroups"
local Tick = require "necro.cycles.Tick"
local TouchInput = require "necro.client.input.TouchInput"
local Utilities = require "system.utils.Utilities"

local entityExists = ECS.entityExists
local getEntityByID = ECS.getEntityByID

--- Debug only
SettingDeleteFreeCursors = Settings.shared.bool {
	id = "deleteFreeCursors",
	visibility = Settings.Visibility.HIDDEN,
	default = true,
}

function RouletteCursor.getFromGamblerEntity(entity)
	if entity.Roulette_gambler then
		local cursorEntity = getEntityByID(entity.Roulette_gambler.cursor)
		if cursorEntity and cursorEntity.Roulette_cursor then
			return cursorEntity
		end
	end
end

local getFromGamblerEntity = RouletteCursor.getFromGamblerEntity

function RouletteCursor.getCursorFromGamblerEntity(entity)
	local cursorEntity = getFromGamblerEntity(entity)
	return cursorEntity and cursorEntity.Roulette_cursor
end

local getCursorFromGamblerEntity = RouletteCursor.getCursorFromGamblerEntity

function RouletteCursor.isSelectable(entity)
	return entity.Roulette_selectable and not entity.Roulette_selectable.suppressed and entity.gameObject.tangible
end

event.inventoryCollectItem.add("itemUnsuppressSelectability", {
	filter = { "Roulette_item", "Roulette_selectable" },
	order = "despawnPriceTag",
}, function(ev)
	ev.item.Roulette_selectable.suppressed = false
end)

event.turn.add("gamblerSuppressSelectable", "activation", function(ev)
	for gamblerEntity in ECS.entitiesWithComponents { "Roulette_gambler", "Roulette_selectable" } do
		if not RouletteGambler.isGambling(gamblerEntity.Roulette_gambler) then
			gamblerEntity.Roulette_selectable.suppressed = true
		end
	end
end)

event.Roulette_gamblerStartGame.add("selectable", {
	filter = "Roulette_selectable",
	order = "selectable",
}, function(ev) --- @param ev Event.Roulette_gamblerStartGame
	ev.entity.Roulette_selectable.suppressed = false
end)

local function compareSelectableEntities(l, r)
	local lv = (l and l.Roulette_gambler and 1 or 0)
	local rv = (r and r.Roulette_gambler and 1 or 0)
	if lv ~= rv then
		return lv > rv
	else
		return l.id > r.id
	end
end

--- @param cursorEntity Entity
--- @return Entity?
function RouletteCursor.getSelectionAtCursorEntity(cursorEntity)
	if cursorEntity.Roulette_cursor and cursorEntity.position then
		local entities = Map.allWithComponent(cursorEntity.position.x, cursorEntity.position.y, "Roulette_selectable")
		table.sort(entities, compareSelectableEntities)
		for _, selectedEntity in ipairs(entities) do
			if RouletteCursor.isSelectable(selectedEntity) then
				return selectedEntity
			end
		end
	end
end

--- Filter target is cursor selected entity.
local cursorInteractSelectorFire = EntitySelector.new(event.Roulette_cursorInteract, {
	"silenceFail",
	"fail",
	"interact",
	"flyaway",
	"sound",
}).fire

function RouletteCursor.interact(entity)
	local component = entity.Roulette_cursor
	local owner = component and component.active and getEntityByID(component.owner)
	if owner then
		--- @class Event.Roulette_cursorInteract
		--- @field entity Entity
		--- @field component Component.Roulette_cursor
		--- @field owner Entity
		--- @field selected Entity?
		--- @field selection Entity?
		--- @field interaction? "cancel" | "failed" | "use" | "select" | "move"
		--- @field checkAvailability? table
		local ev = {
			entity = entity,
			component = component,
			owner = owner,
			selected = getEntityByID(entity.Roulette_cursor.selected),
			selection = RouletteCursor.getSelectionAtCursorEntity(entity),
		}
		cursorInteractSelectorFire(ev, entity.name)
		return Action.Result.INTERACT, ev
	end
end

function RouletteCursor.interactAt(cursorEntity, x, y)
	Move.absolute(cursorEntity, x, y, Move.getMoveType(cursorEntity))
	return RouletteCursor.interact(cursorEntity)
end

local checkCursorAvailabilitySelectorFire = ObjectSelector.new("Roulette_checkCursorAvailability", {
	"silence",
}).fire

event.objectRoulette_checkCursorAvailability.add("silence", {
	filter = "Roulette_gamblerStatusSilence",
	order = "silence",
}, function(ev)
	if ev.fail == nil and ev.entity.Roulette_gamblerStatusSilence.turns > 0 then
		ev.fail = "silence"
	end
end)

--- @param cursorEntity Entity
--- @param ownerEntity Entity
--- @return boolean
--- @return Event.Roulette_checkCursorAvailability
function RouletteCursor.checkAvailability(cursorEntity, ownerEntity)
	--- @class Event.Roulette_checkCursorAvailability
	--- @field cursorEntity Entity
	--- @field ownerEntity Entity
	--- @field fail any?
	local ev = {
		cursorEntity = cursorEntity,
		ownerEntity = ownerEntity,
		entity = ownerEntity,
		fail = nil,
	}
	checkCursorAvailabilitySelectorFire(ev, ownerEntity)
	return not ev.fail, ev
end

--- @param ev Event.Roulette_cursorInteract
event.Roulette_cursorInteract.add("checkFail", "fail", function(ev)
	if ev.selection and ev.selection.Roulette_item then
		local success
		success, ev.checkAvailability = RouletteCursor.checkAvailability(ev.entity, ev.owner)
		if not success then
			ev.interaction = "failed"
			ev.checkAvailability.selected = ev.selected
			ev.checkAvailability.selection = ev.selection
			ev.selected = nil
			ev.selection = nil
		end
	end
end)

event.Roulette_cursorInteract.add("interact", {
	filter = "Roulette_cursorInteract",
	order = "interact",
}, function(ev) --- @param ev Event.Roulette_cursorInteract
	if ev.selection then
		if ev.selected then
			if ev.selected.id == ev.selection.id then
				ev.component.selected = 0
				ev.interaction = "cancel"
			else
				if (not ev.selected.Roulette_item and ev.selection.Roulette_item and (ev.selection.Roulette_selectable.belonging == 0 or ev.selection.Roulette_selectable.belonging == ev.owner.id))
					or (ev.selected.Roulette_gambler and ev.selection.Roulette_gun)
				then
					ev.selected, ev.selection = ev.selection, ev.selected
				end

				if RouletteItem.use(ev.owner, ev.selected, ev.selection) then
					ev.interaction = "use"
				else
					ev.interaction = "failed"
				end
			end
		elseif ev.selection.Roulette_selectable.belonging == 0 or ev.selection.Roulette_selectable.belonging == ev.owner.id then
			ev.component.selected = ev.selection.id
			ev.interaction = "select"
		else
			ev.component.selected = 0
		end
	elseif ev.selected and (ev.selected.Roulette_item or ev.selected.Roulette_gun) and ev.entity.position and ev.owner.position then
		local ownerEntity = getEntityByID(ev.component.owner)
		if ownerEntity and ownerEntity.Roulette_gambler and ev.selected.Roulette_selectable.belonging == ownerEntity.id then
			local x, y = ev.entity.position.x, ev.entity.position.y
			if Utilities.squareDistance(x - ev.owner.position.x, y - ev.owner.position.y) <= ownerEntity.Roulette_gambler.placementRange ^ 2 then
				Move.absolute(ev.selected, x, y, Move.getMoveType(ev.selected))
				ev.component.selected = 0
				ev.interaction = "move"
			end
		end
	end
end)

event.Roulette_cursorInteract.add("sound", {
	filter = "Roulette_cursorSound",
	order = "sound",
}, function(ev) --- @param ev Event.Roulette_cursorInteract
	if ev.interaction then
		local sound = ev.entity.Roulette_cursorSound.sounds[ev.interaction]
		if sound and SoundGroups.isValid(sound) then
			Sound.playIfFocused(sound, ev.owner)
		end
	end
end)

event.Roulette_cursorInteract.add("flyaway", {
	filter = "Roulette_cursorFlyaway",
	order = "flyaway",
}, function(ev) --- @param ev Event.Roulette_cursorInteract
	if ev.interaction == "failed" and ev.checkAvailability and ev.checkAvailability.fail == "silence"
		and ev.checkAvailability.selection and ev.checkAvailability.selection.Roulette_selectable and ev.checkAvailability.selection.Roulette_selectable.belonging == ev.owner.id
	then
		Flyaway.create {
			text = ev.entity.Roulette_cursorFlyaway.failedSilence,
			entity = ev.owner,
		}
	end
end)

--- @param ev Event.Roulette_gamblerBeginTurn
event.Roulette_gamblerBeginTurn.add("activateCursor", "cursor", function(ev)
	if not ev.suppressed then
		local cursor = getCursorFromGamblerEntity(ev.entity)
		if cursor then
			cursor.active = true
		end
	end
end)

--- @param ev Event.Roulette_gamblerEndTurn
event.Roulette_gamblerEndTurn.add("deactivateCursor", "cursor", function(ev)
	local cursor = getCursorFromGamblerEntity(ev.entity)
	if cursor then
		cursor.active = false
		cursor.selected = 0
	end
end)

event.Roulette_gamblerStartGame.add("spawnCursor", {
	filter = { "Roulette_gamblerCursor", "position" },
	order = "cursor",
}, function(ev) --- @param ev Event.Roulette_gamblerStartGame
	if not ECS.entityExists(ev.component.cursor) then
		local e = ev.entity
		--- @diagnostic disable-next-line: missing-fields
		local success, cursorEntity = pcall(Object.spawn, e.Roulette_gamblerCursor.type, e.position.x, e.position.y, {
			--- @diagnostic disable-next-line: missing-fields
			Roulette_cursor = { owner = ev.entity.id },
		})
		if success then
			ev.component.cursor = cursorEntity.id
		end
	end
end)

--- @param ev Event.Roulette_itemUse
event.Roulette_itemUse.add("deactivateCursor", "cursor", function(ev)
	local cursor = getCursorFromGamblerEntity(ev.user)
	if cursor then
		cursor.selected = 0
	end
end)

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot.add("deactivateCursor", "cursor", function(ev)
	local cursor = ev.user and getCursorFromGamblerEntity(ev.user)
	if cursor then
		cursor.active = false
	end
end)

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot5.add("activateCursorIfContinue", "cursor", function(ev)
	if ev.parameter.continue then
		local cursor = ev.user and getCursorFromGamblerEntity(ev.user)
		if cursor then
			cursor.active = true
		end
	end
end)

--- @param ev Event.Roulette_sequenceJudgeNextRound
event.Roulette_sequenceJudgeNextRound.add("deactivateCursor", "cursor", function(ev)
	for _, gamblerEntity in ipairs(RouletteUtility.getEntitiesFromIDs(ev.component.gamblers)) do
		local cursor = getCursorFromGamblerEntity(gamblerEntity)
		if cursor then
			cursor.active = false
		end
	end
end)

--- @param ev Event.Roulette_sequenceJudgeNextRound
event.Roulette_sequenceJudgeNextRound2.add("activateCursor", "cursor", function(ev)
	if not ev.parameter.nextTurn then
		local gamblerEntity = getEntityByID(ev.component.gamblers[ev.component.gamblerIndex])
		local cursor = gamblerEntity and getCursorFromGamblerEntity(gamblerEntity)
		if cursor then
			cursor.active = true
		end
	end
end)

event.turn.add("deleteFreeCursors", "despawnObjects", function(ev)
	if SettingDeleteFreeCursors then
		for entity in ECS.entitiesWithComponents { "Roulette_cursor" } do
			local ownerEntity = getEntityByID(entity.Roulette_cursor.owner)
			if not (ownerEntity and ownerEntity.Roulette_gambler and ownerEntity.Roulette_gambler.cursor == entity.id) then
				Object.delete(entity)
			end
		end
	end
end)

event.turn.add("selectableCheckBelongingValidation", "updateItems", function(ev)
	if ev.globalActivation then
		for entity in ECS.entitiesWithComponents { "Roulette_selectable" } do
			if not ECS.entityExists(entity.Roulette_selectable.belonging) then
				entity.Roulette_selectable.belonging = 0
			end
		end
	end
end)

local playerCursorInteractAt
RouletteCursor.ActionCursorInteractAt, playerCursorInteractAt = CustomActions.registerSystemAction {
	id = "cursorActivateAt",
	abilityFlags = Ability.Type.SUB_BEAT,
	callback = function(playerID, args)
		local playerEntity = Player.getPlayerEntity(playerID)
		local cursorEntity = playerEntity and getFromGamblerEntity(playerEntity)
		if cursorEntity and type(args) == "table" and type(args.x) == "number" and type(args.y) == "number" then
			if args.movementOnly then
				Move.absolute(cursorEntity, args.x, args.y, Move.getMoveType(cursorEntity))
			else
				RouletteCursor.interactAt(cursorEntity, args.x, args.y)
			end
		end
	end,
}

--- @diagnostic disable-next-line: missing-fields
RouletteCursor.HotkeyCursorInteract = Config.osDesktop and CustomActions.registerHotkey {
	id = "cursorInteract",
	name = L("Cursor Interact"),
	keyBinding = "Mouse_1",
	perPlayerBinding = true,
	enableIf = function(playerID)
		if not GameInput.isBlocked() and not GameInput.isPlayerInputBlocked() then
			local playerEntity = Player.getPlayerEntity(playerID)
			return not not (playerEntity and getFromGamblerEntity(playerEntity))
		end

		return false
	end,
	callback = function(playerID)
		local x, y = RouletteUtility.getTilePositionUnderMouse()
		if x and y then
			playerCursorInteractAt(playerID, {
				x = x,
				y = y,
			})

			return true
		end

		return false
	end,
} or false

event.tick.add("touchInput", {
	order = "touchInput",
	sequence = 1,
}, function()
	local layout = TouchInput.getCurrentLayout()
	if not (layout and GameState.isPlaying()) then
		return
	end

	local playerID = LocalCoop.getLocalPlayerIDs()[1]
	if not playerID then
		return
	end

	for _, touch in ipairs(Input.touch()) do
		if touch.release and not TouchInput.getButtonAt(touch.x, touch.y) then
			local x, y = RouletteUtility.screen2tile(touch.x, touch.y)
			local sx, sy = RouletteUtility.screen2tile(touch.startX, touch.startY)
			if x == sx and y == sy then
				return playerCursorInteractAt(playerID, {
					x = x,
					y = y,
				})
			end
		end
	end
end)

--- @diagnostic disable-next-line: missing-fields
RouletteCursor.HotKeyCursorSmartSelection = CustomActions.registerHotkey {
	id = "cursorSmartSelection",
	name = "Cursor smart selection",
	keyBinding = "LControl",
	perPlayerBinding = true,
	callback = RouletteUtility.emptyFunction,
}
event.tick.override("Roulette_action_cursorSmartSelection", RouletteUtility.emptyFunction)

local smartSelectionInferiors = {}

event.tick.add("updateSmartSelectionPriorities", "countdown", function()
	local deltaTime = Tick.getDeltaTime()
	for id, inferior in pairs(smartSelectionInferiors) do
		inferior = inferior - deltaTime
		smartSelectionInferiors[id] = inferior > 0 and inferior or nil
	end
end)

local smartCursorAdditionalFilterSelectorFire = EntitySelector.new(event.Roulette_smartCursorAdditionalFilter, { "filter" }).fire

local function smartCursorAdditionalFilter(entity, gamblerEntity)
	local ev = {
		entity = entity,
		gamblerEntity = gamblerEntity,
		filtered = false,
	}
	smartCursorAdditionalFilterSelectorFire(ev, entity.name)
	return ev.filtered
end

event.clientAddInput.add("cursorSmartSelection", {
	order = "customAction",
	sequence = 1,
}, function(ev)
	if not Action.isDirection(ev.action) then
		return
	end
	do
		local b
		for _, key in ipairs(Controls.getActionKeyBinds(RouletteCursor.HotKeyCursorSmartSelection, LocalCoop.getControllerID(ev.playerID)) or RouletteUtility.emptyTable) do
			if Input.keyDown(key) then
				b = true
				break
			end
		end
		if not b then
			return
		end
	end

	local gamblerEntity = Player.getPlayerEntity(ev.playerID)
	if not gamblerEntity then
		return
	end

	local cursorEntity = RouletteCursor.getFromGamblerEntity(gamblerEntity)
	if not (cursorEntity and cursorEntity.position) then
		return
	end

	local selectableEntities = {}
	for item in ECS.entitiesWithComponents { "Roulette_smartCursorTarget" } do
		selectableEntities[#selectableEntities + 1] = item
	end

	local x = cursorEntity.position.x
	local y = cursorEntity.position.y
	local tx, ty, tw, th = Camera.getVisibleTileRect()
	local selected = ECS.getEntityByID(cursorEntity.Roulette_cursor.selected)
	local hovered = ObjectMap.firstWithComponent(x, y, "Roulette_selectable")
	local judge = assert(gamblerEntity).Roulette_gambler.judge
	Utilities.removeIf(selectableEntities, function(entity)
		if smartCursorAdditionalFilter(entity, gamblerEntity) then
			return true
		end

		local px = entity.position.x
		local py = entity.position.y
		return (px < tx or px >= tx + tw or py < ty or py >= ty + th)
			or (entity.Roulette_gambler and entity.Roulette_gambler.judge ~= judge)
			or (hovered and hovered.id == entity.id and hovered.position.x == x and hovered.position.y == y)
			or (selected and selected.id ~= entity.id and not RouletteItem.checkUse(gamblerEntity, selected, entity) and not RouletteItem.checkUse(gamblerEntity, entity, selected))
	end)

	if selectableEntities[2] then
		local x1, y1 = Action.getMovementOffset(ev.action)
		local x2, y2 = x + x1, y + y1

		local openDistances = {}
		local nextDistances = {}
		for _, entity in ipairs(selectableEntities) do
			local ang = RouletteUtility.vectorAngle(x1, y1, entity.position.x - x, entity.position.y - y)
			if ang <= math.pi / 2 then
				openDistances[entity] = 1 - math.cos(ang)
			else
				openDistances[entity] = math.huge
			end
			nextDistances[entity] = Utilities.squareDistance(x2 - entity.position.x, y2 - entity.position.y)
		end

		table.sort(selectableEntities, function(l, r)
			if openDistances[l] ~= openDistances[r] then
				return openDistances[l] < openDistances[r]
			elseif nextDistances[l] ~= nextDistances[r] then
				return nextDistances[l] < nextDistances[r]
			end

			local li = smartSelectionInferiors[l.id] or 0
			local ri = smartSelectionInferiors[r.id] or 0
			if li ~= ri then
				return li < ri
			end

			return l.id < r.id
		end)
	end

	local best = selectableEntities[1]
	if best then
		ev.suppressed = true
		smartSelectionInferiors[best.id] = math.min((smartSelectionInferiors[best.id] or 0) + 1, 3)

		playerCursorInteractAt(ev.playerID, {
			movementOnly = true,
			x = best.position.x,
			y = best.position.y,
		})
	end
end)

do
	local r = 5

	local function outOfRange(x, y, cx, cy)
		return x > cx + r or x < cx - r or y > cy + r or y < cy - r
	end

	event.objectMove.add("cursorRogueModeRange", {
		filter = "Roulette_cursor",
		order = "moveType",
	}, function(ev) ---@param ev Event.ObjectMove
		if RouletteRogue.isModeActive() then
			local gamblerEntity = getEntityByID(ev.entity.Roulette_cursor.owner)
			local judgeEntity = gamblerEntity and RouletteJudge.getFromGamblerEntity(gamblerEntity)
			if judgeEntity and judgeEntity.Roulette_judgeRogue and judgeEntity.position
				and outOfRange(ev.x, ev.y, judgeEntity.position.x, judgeEntity.position.y)
			then
				ev.x = ev.prevX
				ev.y = ev.prevY
			end
		end
	end)

	event.Roulette_smartCursorAdditionalFilter.add("rogueModeRange", {
		filter = "position",
		order = "filter",
	}, function(ev)
		if RouletteRogue.isModeActive() then
			local judge = RouletteJudge.getFromGamblerEntity(ev.gamblerEntity)
			if judge and judge.position and outOfRange(ev.entity.position.x, ev.entity.position.y, judge.position.x, judge.position.y) then
				ev.filtered = true
			end
		end
	end)
end

event.objectDirection.add("gamblerMoveCursor", {
	filter = { "Roulette_gambler", "gameObject" },
	order = "moveOverride",
}, function(ev)
	local cursorEntity = getEntityByID(ev.entity.Roulette_gambler.cursor)
	if cursorEntity and cursorEntity.gameObject.tangible
		and Move.relative(cursorEntity, ev.dx, ev.dy, ev.moveType or Move.getMoveType(cursorEntity))
	then
		ev.result = Action.Result.INHIBIT

		if ev.entity.facingDirection then
			ev.direction = ev.entity.facingDirection.direction
		end
	end
end)

event.turn.add("cursorsCollectGolds", "itemPickup", function(ev)
	for cursor in ECS.entitiesWithComponents { "Roulette_cursor", "Roulette_cursorCollectGold", "position" } do
		local owner = getEntityByID(cursor.Roulette_cursor.owner)
		for _, gold in ipairs(owner and ObjectMap.allWithComponent(cursor.position.x, cursor.position.y, "itemCurrency") or RouletteUtility.emptyTable) do
			if gold.itemCurrency.currencyType == Currency.Type.GOLD then
				ItemPickup.tryCollect(gold, owner)
			end
		end
	end
end)

return RouletteCursor
