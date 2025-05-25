local RouletteUIBag = {}
local RouletteUtility = require "Roulette.Utility"

local AnimationTimer = require "necro.render.AnimationTimer"
local Beatmap = require "necro.audio.Beatmap"
local Color = require "system.utils.Color"
local ECS = require "system.game.Entities"
local Input = require "system.game.Input"
local Inventory = require "necro.game.item.Inventory"
local LocalCoop = require "necro.client.LocalCoop"
local ObjectRenderer = require "necro.render.level.ObjectRenderer"
local Render = require "necro.render.Render"
local Timer = require "system.utils.Timer"
local UI = require "necro.render.UI"
local Utilities = require "system.utils.Utilities"

local TileSize = 24

local buffer = Render.getBuffer(Render.Buffer.OVERLAY)
local getEntityByID = ECS.getEntityByID
local floor = math.floor
local lerp = Utilities.lerp
local min = math.min

--- @class RouletteUIBag.Data
--- @field slots { [1]: number, [2]: number }[]
--- @field gridWidth integer
--- @field time number
--- @field opacity number
--- @field isLocal boolean
--- @field select integer
--- @field hitboxList Rectangle[]?
--- @field items? table<integer, Entity>

--- @type table<Entity.ID, RouletteUIBag.Data>
local bagData = {}

event.gameStateLevel.add("resetUIBagVariables", "resetLevelVariables", function()
	bagData = {}
end)

--- @param bagEntity Entity
--- @return Component.Roulette_rogueBag? bag
--- @return Entity holder
local function getBagAndHolder(bagEntity)
	local bag = bagEntity.Roulette_rogueBag
	if not bag then
		return nil, bagEntity
	end

	local holder = bagEntity.item and ECS.getEntityByID(bagEntity.item.holder)
	if not holder then
		return nil, bagEntity
	end

	return bag, holder
end

--- @param entity Entity
function RouletteUIBag.open(entity)
	local bag, holder = getBagAndHolder(entity)
	if not bag or bag.opened then
		return
	end

	local gridWidth = bag.gridWidth
	local visual = ObjectRenderer.getObjectVisual(holder)
	local slots = {}
	for i = 1, gridWidth * gridWidth do
		slots[i] = {
			visual.rect[1] + visual.rect[3] / 2,
			visual.rect[2] + visual.rect[4] / 2,
		}
	end

	local data = bagData[entity.id] or {}
	data.slots = slots
	data.gridWidth = gridWidth
	data.time = AnimationTimer.getTime()
	data.opacity = 0
	data.isLocal = holder.controllable and LocalCoop.isLocal(holder.controllable.playerID) or false
	data.hitboxList = {}
	data.select = data.select
		and Utilities.clamp(1, data.select, gridWidth * gridWidth)
		or (floor(gridWidth * floor(gridWidth / 2) + floor(gridWidth / 2 + .5)))
	bagData[entity.id] = data

	bag.opened = true
end

--- @param entity Entity
function RouletteUIBag.close(entity)
	if entity.Roulette_rogueBag and entity.Roulette_rogueBag.opened then
		local data = bagData[entity.id]
		if data then
			data.hitboxList = nil
			data.time = AnimationTimer.getTime()
		end

		entity.Roulette_rogueBag.opened = false
	end
end

--- @param entity Entity
--- @return boolean?
function RouletteUIBag.isOpened(entity)
	local bag = entity.Roulette_rogueBag
	if bag then
		return bag.opened
	end
end

--- @param entity Entity
function RouletteUIBag.toggle(entity)
	if entity.Roulette_rogueBag then
		if RouletteUIBag.isOpened(entity) then
			RouletteUIBag.close(entity)
		else
			RouletteUIBag.open(entity)
		end
	end
end

local function wrap(x, y, gridWidth)
	return ((y - 1) % gridWidth) * gridWidth + ((x - 1) % gridWidth) + 1
end

local function unwrap(i, gridWidth)
	return (i - 1) % gridWidth + 1, floor((i - 1) / gridWidth) + 1
end

local function unwrapRender(i, gridWidth)
	return ((i - 1) % gridWidth + .5 - gridWidth * .5) * TileSize, (floor((i - 1) / gridWidth) - gridWidth * .5 + .5) * TileSize
end

--- @param entity Entity
--- @return integer? x
--- @return integer y
function RouletteUIBag.getSelectPosition(entity)
	local data = bagData[entity.id]
	if data then
		return unwrap(data.select, data.gridWidth)
	end
	return nil, 0
end

--- @param entity Entity
--- @param x integer
--- @param y integer
function RouletteUIBag.setSelectPosition(entity, x, y)
	local data = bagData[entity.id]
	if data then
		data.select = wrap(x, y, data.gridWidth)
	end
end

--- @param entity Entity
--- @return Entity?
function RouletteUIBag.getSelection(entity)
	local data = bagData[entity.id]
	if data and data.items then
		return data.items[data.select]
	end
end

--- @param holder Entity
--- @param bag Component.Roulette_rogueBag
--- @return Entity[]
local function getBagItems(holder, bag)
	local items = {}
	local i = 0

	for _, item in ipairs(Inventory.getItems(holder)) do
		local exclude = false

		for _, component in ipairs(bag.itemComponents) do
			if not item:hasComponent(tostring(component)) then
				exclude = true
				break
			end
		end

		if not exclude then
			i = i + 1
			items[i] = item
		end
	end

	table.sort(items, function(l, r)
		if l.Roulette_item and r.Roulette_item and l.Roulette_item.pickupTime ~= r.Roulette_item.pickupTime then
			return l.Roulette_item.pickupTime < r.Roulette_item.pickupTime
		else
			return l.id < r.id
		end
	end)

	return items
end

--- @param entity Entity
--- @param refresh true?
function RouletteUIBag.updateItems(entity, refresh)
	local bag, holder = getBagAndHolder(entity)
	if not bag then
		return
	end

	local data = bagData[entity.id]
	if not data then
		return
	end

	if refresh then
		data.items = getBagItems(holder, bag)
	elseif data.items then
		for index, item in pairs(data.items) do
			if item.item and item.item.holder ~= holder.id then
				data.items[index] = nil
			end
		end
	end
end

event.replaySeek.add("updateUIBagItems", "visualUpdate", function()
	for entity in ECS.entitiesWithComponents { "Roulette_rogueBag" } do
		RouletteUIBag.updateItems(entity, true)
	end
end)

--- @param entity Entity @Bag entity
--- @return Rectangle[]?
function RouletteUIBag.getHitboxList(entity)
	local data = bagData[entity.id]
	if data then
		return data.hitboxList
	end
end

local function renderUIBag(bag, holder, data)
	local factor = (AnimationTimer.getTime() - data.time) / .25
	if bag.opened then
		if factor > 1 then
			factor = 1
		else
			factor = lerp(factor, 1, factor)
		end
	else
		if factor > 1 then
			return
		else
			factor = lerp(1 - factor, 0, factor)
		end
	end

	local opacity = factor
	local colorDefault = Color.opacity(opacity)
	local colorRingUnequipped = Color.darken(Color.WHITE, .5)
	local textureBagUI = "mods/Roulette/gfx/bag_ui.png"

	local draw = buffer.draw
	local drawArgs = {
		texRect = { 0, 0, TileSize, TileSize },
		rect = { 0, 0, TileSize, TileSize },
		color = colorDefault,
	}
	local drawArgsRect = drawArgs.rect
	local drawArgsTexRect = drawArgs.texRect
	local gridWidth = data.gridWidth

	local centerX
	local centerY
	do
		local visual = ObjectRenderer.getShadowVisual(holder)
		centerX = visual.rect[1] + visual.rect[3] * .5
		centerY = visual.rect[2] + visual.rect[4] * .5 - TileSize * .5

		local t = .4
		for i, position in ipairs(data.slots) do
			local x, y = unwrapRender(i, gridWidth)
			position[1] = lerp(centerX, centerX + x, min(factor / t, 1))
			position[2] = lerp(centerY, centerY + y, Utilities.clamp(0, (factor - t) / (1 - t), 1))
		end
	end

	data.items = data.items or getBagItems(holder, bag)

	for i, position in ipairs(data.slots) do
		drawArgs.texture = textureBagUI
		drawArgsRect[1] = position[1] - TileSize * .5
		drawArgsRect[2] = position[2] - TileSize * .5
		drawArgsRect[3] = TileSize
		drawArgsRect[4] = TileSize
		drawArgsTexRect[1] = 0
		drawArgsTexRect[2] = 0
		drawArgsTexRect[3] = TileSize
		drawArgsTexRect[4] = TileSize
		drawArgs.color = colorDefault
		draw(drawArgs)

		local item = data.items[i]
		if item then
			local pad = 2
			local visual = ObjectRenderer.getObjectVisual(item)
			drawArgs.texture = visual.texture
			local scale = (TileSize - pad * 2) / TileSize
			local w = visual.rect[3] * scale
			local h = visual.rect[4] * scale
			drawArgsRect[1] = drawArgsRect[1] + (drawArgsRect[3] - w) * .5
			drawArgsRect[2] = drawArgsRect[2] + (drawArgsRect[4] - h) * .5 + (data.isLocal and i == data.select and pad * .5 * math.sin(Timer.getGlobalTime() * 4) or 0)
			drawArgsRect[3] = w
			drawArgsRect[4] = h
			drawArgsTexRect[1] = visual.texRect[1]
			drawArgsTexRect[2] = visual.texRect[2]
			drawArgsTexRect[3] = visual.texRect[3]
			drawArgsTexRect[4] = visual.texRect[4]
			drawArgs.color = Color.fade(item.item and not item.item.equipped and colorRingUnequipped or colorDefault, opacity)
			draw(drawArgs)
		end
	end

	if bag.opened and opacity > .99 then
		local x, y = unwrapRender(data.select, gridWidth)

		if data.isLocal then
			local pad = 4
			local f = pad * (Beatmap.getPrimary().getMusicBeatFraction() ^ 1.25)

			drawArgs.texture = textureBagUI
			drawArgsRect[1] = centerX + x - TileSize * .5 - pad + f
			drawArgsRect[2] = centerY + y - TileSize * .5 - pad + f
			drawArgsRect[3] = TileSize + 2 * (pad - f)
			drawArgsRect[4] = TileSize + 2 * (pad - f)
			drawArgsTexRect[1] = TileSize
			drawArgsTexRect[2] = 0
			drawArgsTexRect[3] = TileSize
			drawArgsTexRect[4] = TileSize
			drawArgs.color = Color.fade(holder.Roulette_gamblerColor and holder.Roulette_gamblerColor.color or Color.WHITE, factor)
			draw(drawArgs)
		end

		local item = data.isLocal and data.items[data.select]
		if item then
			local args = {
				buffer = buffer,
				x = centerX,
				y = centerY - (gridWidth + .5) * .5 * TileSize,
				alignX = .5,
				alignY = 1,
			}

			if item.Roulette_hintLabel then
				args.font = UI.Font.SMALL
				args.text = item.Roulette_hintLabel.text
				args.y = args.y - UI.drawText(args).height - 2
			end

			if item.friendlyName then
				args.font = UI.Font.SMALL
				args.text = item.friendlyName.name
				args.y = args.y - UI.drawText(args).height
			end
		end
	end
end

event.render.add("renderUIBags", "overlayBack", function()
	for entityID, data in pairs(bagData) do
		local entity = ECS.getEntityByID(entityID)
		if entity then
			local bag, holder = getBagAndHolder(entity)
			if bag and holder.gameObject and holder.gameObject.tangible then
				renderUIBag(bag, holder, data)
				goto continue
			end
		end

		bagData[entityID] = nil
		::continue::
	end
end)

do
	bagData = script.persist(function()
		return bagData
	end)

	for _, data in pairs(bagData) do
		data.items = nil
	end
end

return RouletteUIBag
