local RouletteGambler = require "Roulette.Gambler"
local RouletteRogueItem = require "Roulette.RogueItem"
local RouletteRogue = require "Roulette.Rogue"
local RouletteRogueBag = {}
local RouletteUIBag = require "Roulette.render.UIBag"
local RouletteUtility = require "Roulette.Utility"

local Action = require "necro.game.system.Action"
local Collision = require "necro.game.tile.Collision"
local CustomActions = require "necro.game.data.CustomActions"
local ECS = require "system.game.Entities"
local EntitySelector = require "system.events.EntitySelector"
local Flyaway = require "necro.game.system.Flyaway"
local Input = require "system.game.Input"
local Inventory = require "necro.game.item.Inventory"
local ItemSlot = require "necro.game.item.ItemSlot"
local LocalCoop = require "necro.client.LocalCoop"
local MoveAnimations = require "necro.render.level.MoveAnimations"
local Object = require "necro.game.object.Object"
local Player = require "necro.game.character.Player"
local Sound = require "necro.audio.Sound"
local TextPool = require "necro.config.i18n.TextPool"
local Utilities = require "system.utils.Utilities"

-- event.inventorySlotCapacity.add("rogueMode8Rings", {
-- 	key = ItemSlot.Type.RING,
-- 	sequence = 10,
-- }, function(ev)
-- 	if RouletteRogue.isModeActive() then
-- 		ev.capacity = math.max(8, ev.capacity)
-- 	end
-- end)

event.inventoryAddItem.add("rogueModeOverrideItemSlot", {
	filter = { "Roulette_rogueItemSlot", "itemSlot" },
	order = "attachSlot",
	sequence = 1,
}, function(ev)
	if not RouletteRogue.isModeActive() then
		return
	end

	local slotName = ev.item.itemSlot.name
	local toSlotName = ev.item.Roulette_rogueItemSlot.slotName
	if slotName ~= toSlotName then
		local slots = ev.holder.inventory.itemSlots
		local slot = slots[slotName]
		if slot and slot[#slot] == ev.item.id then
			slots[toSlotName] = slots[toSlotName] or {}
			table.insert(slots[toSlotName], table.remove(slot, #slot))
		end
	end

	local entity = RouletteRogueItem.getEquippedItem(ev.holder, "Roulette_rogueBag")
	if entity then
		RouletteUIBag.updateItems(entity, true)
	end
end)

local function isItemSlotActionOrRing(entity)
	return entity.itemSlot and (entity.itemSlot.name == ItemSlot.Type.ACTION or entity.itemSlot.name == ItemSlot.Type.RING)
end

event.inventoryAddItem.override("dropPreviousItem", function(func, ev)
	if not (isItemSlotActionOrRing(ev.item) and RouletteRogue.isModeActive()) then
		return func(ev)
	end

	local entity = RouletteRogueItem.getEquippedItem(ev.holder, "Roulette_rogueBag")
	if not (entity and entity.Roulette_rogueBag) then
		return
	end

	local items = {}
	for _, itemID in ipairs(ev.holder.inventory.items) do
		local item = ECS.getEntityByID(itemID)
		if item and isItemSlotActionOrRing(item) then
			items[#items + 1] = item
		end
	end
	if #items >= entity.Roulette_rogueBag.gridWidth ^ 2 then
		local drop = ev.deleteDrop and Object.delete or Inventory.drop
		; drop(ECS.getEntityByID(items[ev.dropIndex or 1]))
	end

	-- local slot = ev.item.itemSlot.name
	-- local capacity = inventory.getSlotCapacity(ev.holder, slot)
	-- local slotItems = ev.holder.inventory.itemSlots[slot]

	-- if slotItems and capacity and capacity <= #slotItems then
	-- 	local droppedItem = ecs.getEntityByID(slotItems[ev.dropIndex or 1])

	-- 	if ev.deleteDrop then
	-- 		object.delete(droppedItem)
	-- 	else
	-- 		inventory.drop(droppedItem)
	-- 	end
	-- end
end)

event.inventoryDetachItem.add("rogueModeDetachOverrideItemSlot", {
	filter = { "Roulette_rogueItemSlot", "itemSlot" },
	order = "detachSlot",
}, function(ev)
	local itemList = ev.holder.inventory.itemSlots[ev.item.Roulette_rogueItemSlot.slotName]
	if itemList then
		Utilities.arrayRemove(itemList, ev.item.id)
	end
end)

event.inventoryDropItem.add("despawnBag", {
	filter = "Roulette_rogueBag",
	order = "remove",
}, function(ev)
	Object.lazyDelete(ev.item)
end)

function RouletteRogueBag.close(holder)
	local bag = RouletteRogueItem.getEquippedItem(holder, "Roulette_rogueBag")
	if bag then
		RouletteUIBag.close(bag)
	end
end

event.Roulette_gamblerBeginTurn.add("bagRingSwapLimit", {
	filter = "Roulette_gamblerBagRingSwapLimit",
	order = "reset",
}, function(ev)
	ev.entity.Roulette_gamblerBagRingSwapLimit.limited = false
	RouletteRogueBag.close(ev.entity)
end)

event.Roulette_gamblerEndTurn.add("bagRingSwapLimit", {
	filter = "Roulette_gamblerBagRingSwapLimit",
	order = "reset",
}, function(ev)
	RouletteRogueBag.close(ev.entity)
end)

local bagItemInteractSelectorFire = EntitySelector.new(event.Roulette_bagItemInteract, {
	"ring",
	"gambler",
	"drop",
}).fire

event.Roulette_bagItemInteract.add("equipRing", {
	filter = { "Roulette_ring", "item" },
	order = "ring",
}, function(ev)
	local swapLimit = ev.holder.Roulette_gamblerBagRingSwapLimit
	local function swapFailed()
		Sound.playIfFocused("error", ev.holder)
		Flyaway.create {
			entity = ev.holder,
			text = TextPool.get "mod.Roulette.ringSwapLimited",
		}
	end

	if not ev.item.item.equipped then
		local function equipWithSound()
			Inventory.equip(ev.item, ev.holder)
			Sound.playFromEntity("pickupWeapon", ev.holder)
		end

		if not swapLimit or (ev.holder.Roulette_gambler and not RouletteGambler.isGambling(ev.holder.Roulette_gambler)) then
			equipWithSound()
		elseif not swapLimit.limited then
			equipWithSound()
			swapLimit.limited = true
		else
			swapFailed()
		end

		ev.suppressed = true
	elseif RouletteGambler.isGambling(ev.holder.Roulette_gambler) then
		if ev.item.Roulette_ring and ev.item.item.equipped and not (swapLimit and swapLimit.limited) then
			Inventory.unequip(ev.item, ev.holder)
			Sound.playFromEntity("pickupWeapon", ev.holder)
		else
			swapFailed()
		end

		ev.suppressed = true
	end
end)

local function dropItemFromBagImpl(ev, x, y)
	Inventory.drop(ev.item, x, y)
	MoveAnimations.play(ev.item, MoveAnimations.Type.HOP, ev.holder.position.x, ev.holder.position.y)
	RouletteUIBag.updateItems(ev.bag)

	if ev.item.Roulette_visibilityHideItemHintLabel then
		ev.item.Roulette_visibilityHideItemHintLabel.hide = true
	end
	if ev.item.Roulette_visibilityHideItemStackQuantityLabel then
		ev.item.Roulette_visibilityHideItemStackQuantityLabel.hide = true
	end
end

event.Roulette_bagItemInteract.add("placeOrDrop", {
	filter = "Roulette_selectable",
	order = "gambler",
}, function(ev) --- @param ev Event.Roulette_bagItemInteract
	if ev.suppressed
		or not ev.holder.position
		or not ev.holder.Roulette_gambler
		or not RouletteGambler.isGambling(ev.holder.Roulette_gambler)
	then
		return
	end

	for dx, dy in RouletteUtility.iterateOffsetsInRange(ev.holder.Roulette_gambler.placementRange) do
		local x = ev.holder.position.x + dx
		local y = ev.holder.position.y + dy

		if not Collision.check(x, y, Collision.Group.ITEM_PLACEMENT) then
			dropItemFromBagImpl(ev, x, y)
			if ev.item.Roulette_selectable then
				ev.item.Roulette_selectable.belonging = ev.holder.id
			end

			break
		end
	end

	ev.suppressed = true
end)

event.Roulette_bagItemInteract.add("drop", {
	order = "drop",
}, function(ev)
	if not ev.suppressed and ev.holder.position then
		local x, y = Collision.findNearbyVacantTile(ev.holder.position.x, ev.holder.position.y, Collision.Group.ITEM_PLACEMENT)
		if x and y then
			dropItemFromBagImpl(ev, x, y)
		end
	end
end)

RouletteRogueBag.SystemAction_BagItemInteract, RouletteRogueBag.bagItemInteract = CustomActions.registerSystemAction {
	id = "bagItemInteract",
	callback = function(playerID, args)
		local entity = Player.getPlayerEntity(playerID)
		if not (entity and args and type(args.itemID) == "number") then
			return
		end

		local bag = RouletteRogueItem.getEquippedItem(entity, "Roulette_rogueBag")
		local item = ECS.getEntityByID(args.itemID)
		if bag and item then
			--- @class Event.Roulette_bagItemInteract
			--- @field holder Entity
			--- @field bag Entity
			--- @field item Entity
			--- @field suppressed? boolean
			local ev = {
				holder = entity,
				bag = bag,
				item = item,
			}
			bagItemInteractSelectorFire(ev, item.name)
		end
	end,
}

do
	local excludedActionSet = {
		[Action.Special.BOMB] = true,
		[Action.Special.SPELL_1] = true,
		[Action.Special.SPELL_2] = true,
		[Action.Special.THROW] = true,
	}

	event.holderGetActionItem.add("rogueModeHideMostItems", {
		filter = "!Roulette_rogueBag",
		order = "override",
		sequence = 1,
	}, function(ev)
		if ev.item and not excludedActionSet[ev.action] and RouletteRogue.isModeActive() then
			ev.item = nil
		end
	end)
end

event.holderGetActionItem.add("showRogueBag", {
	filter = "Roulette_rogueBag",
	order = "override",
	sequence = 2,
}, function(ev)
	if ev.action == Action.Special.ITEM_1 then
		ev.item = ev.entity
	end
end)

event.itemActivate.add("rogueBag", {
	filter = "Roulette_rogueBag",
	order = "toggle",
}, function(ev)
	if ev.holder and ev.holder.Roulette_gambler
		and (not RouletteGambler.isGambling(ev.holder.Roulette_gambler) or ev.holder.Roulette_gambler.turn)
	then
		RouletteUIBag.toggle(ev.item)
	elseif ev.holder then
		Flyaway.create {
			entity = ev.holder,
			text = TextPool.get "mod.Roulette.availableDuringYourTurn",
		}
	end
end)

do
	local bagActions = {
		[Action.Special.BOMB] = true,
		[Action.Direction.RIGHT] = true,
		[Action.Direction.UP] = true,
		[Action.Direction.LEFT] = true,
		[Action.Direction.DOWN] = true,
	}

	event.clientAddInput.add("operateBag", {
		order = "customAction",
		sequence = 10,
	}, function(ev)
		if not bagActions[ev.action] then
			return
		end

		local holder = Player.getPlayerEntity(ev.playerID)
		local bag = holder and RouletteRogueItem.getEquippedItem(holder, "Roulette_rogueBag")
		if not bag or not RouletteUIBag.isOpened(bag) then
			return
		end
		--- @cast holder Entity

		local x, y = RouletteUIBag.getSelectPosition(bag)
		if not x then
			return
		end

		local dx, dy = Action.getMovementOffset(ev.action)
		if dx ~= 0 then
			RouletteUIBag.setSelectPosition(bag, x + dx, y)
		elseif dy ~= 0 then
			RouletteUIBag.setSelectPosition(bag, x, y + dy)
		else
			local item = RouletteUIBag.getSelection(bag)
			if item then
				RouletteRogueBag.bagItemInteract(ev.playerID, { itemID = item.id })
			end
		end

		ev.suppressed = true
	end)
end

event.objectGetActionItem.add("gamblerBagSelectionNotification", {
	filter = "Roulette_gambler",
	order = "virtualItems",
	sequence = -5,
}, function(ev)
	if ev.item or ev.action ~= Action.Special.BOMB then
		return
	end

	local bagEntity = RouletteRogueItem.getEquippedItem(ev.entity, "Roulette_rogueBag")
	if not (bagEntity and bagEntity.Roulette_rogueBag.opened) then
		return
	end

	local selection = RouletteUIBag.getSelection(bagEntity)
	if not selection then
		return selection
	end

	if selection.Roulette_ring and selection.item then
		if selection.item.equipped then
			ev.slotLabel = TextPool.get "mod.Roulette.bad.unequip"
		else
			ev.slotLabel = TextPool.get "mod.Roulette.bad.equip"
		end
	else
		ev.slotLabel = TextPool.get "mod.Roulette.bad.drop"
	end
	ev.item = selection
	ev.visual = true
end)

-- NOPE IM TOO LAZY :(
-- event.tick.add("handleBagMouseInput", "input", function()
-- 	local x, y = RouletteUtility.screen2world(Input.mouseX(), Input.mouseY())

-- 	for _, playerID in ipairs(LocalCoop.getLocalPlayerIDs()) do
-- 		local entity = Player.getPlayerEntity(playerID)
-- 		local bagEntity = entity and RouletteRogueItem.getEquippedItem(entity, "Roulette_rogueBag")
-- 		for index, rect in ipairs(bagEntity and RouletteUIBag.getHitboxList(bagEntity) or RouletteUtility.emptyTable) do
-- 			if x > rect[1] and x < rect[1] + rect[3] and y > rect[2] and y < rect[2] + rect[4] then
-- 				return
-- 			end
-- 		end
-- 	end
-- end)
