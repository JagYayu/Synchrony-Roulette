local RouletteCursor = require "Roulette.Cursor"
local RouletteGun = require "Roulette.Gun"
local RouletteRenderLabels = {}
local RouletteRogue = require "Roulette.Rogue"
local RouletteVisual = require "Roulette.render.Visuals"

local Collision = require "necro.game.tile.Collision"
local Color = require "system.utils.Color"
local ECS = require "system.game.Entities"
local Focus = require "necro.game.character.Focus"
local InstantReplay = require "necro.client.replay.InstantReplay"
local ObjectMap = require "necro.game.object.Map"
local Render = require "necro.render.Render"
local SettingsStorage = require "necro.config.SettingsStorage"
local TextFormat = require "necro.config.i18n.TextFormat"
local Tile = require "necro.game.tile.Tile"
local UI = require "necro.render.UI"
local Utilities = require "system.utils.Utilities"
local VisualExtent = require "necro.render.level.VisualExtent"

local checkCollision = Collision.check
local clamp = Utilities.clamp
local distanceL1 = Utilities.distanceL1
local getEntityByID = ECS.getEntityByID
local hsv = Color.hsv
local min = math.min
local reduceCoordinates = Tile.reduceCoordinates

--- @param entity Entity
--- @return string
function RouletteRenderLabels.getHintLabelText(entity)
	if entity.Roulette_hintLabel then
		--- @diagnostic disable-next-line: return-type-mismatch
		return entity.Roulette_hintLabelVanilla and entity.itemHintLabel.text or entity.Roulette_hintLabel.text
	end

	return ""
end

local getHintLabelText = RouletteRenderLabels.getHintLabelText

function RouletteRenderLabels.applyVisibilityHiddens(handlerName, orderName, componentName)
	local hiddenVisibilities = {}

	event.render.add(handlerName, {
		order = orderName,
		sequence = -1,
	}, function()
		if next(hiddenVisibilities) then
			hiddenVisibilities = {}
		end

		for entity in ECS.entitiesWithComponents { componentName, "visibility" } do
			if entity.visibility.visible and entity[componentName].hide then
				hiddenVisibilities[#hiddenVisibilities + 1] = entity.visibility

				entity.visibility.visible = false
			end
		end
	end)

	event.render.add(handlerName .. "Restore", {
		order = orderName,
		sequence = 1,
	}, function()
		for _, visibility in ipairs(hiddenVisibilities) do
			visibility.visible = true
		end
	end)
end

do
	local apply = RouletteRenderLabels.applyVisibilityHiddens
	apply("visibilityHideItemHintLabel", "hintLabels", "Roulette_visibilityHideItemHintLabel")
	apply("visibilityHideItemStackQuantityLabel", "itemStackSizes", "Roulette_visibilityHideItemStackQuantityLabel")
end

local function fullyVisibleAndNotShadowed(entity)
	return entity.visibility and entity.visibility.fullyVisible and not (entity.silhouette and entity.silhouette.active)
end

local function drawHintLabel(drawnTiles, x, y, drawText, gamblerHintLabel)
	local i = reduceCoordinates(x, y)
	if not i then
		return
	end

	drawnTiles = drawnTiles or {}
	if drawnTiles[i] then
		return
	end
	drawnTiles[i] = true

	local entity

	entity = gamblerHintLabel and ObjectMap.firstWithComponent(x, y, "Roulette_gamblerHintLabelOnCursor")
	if entity and entity.Roulette_judge and fullyVisibleAndNotShadowed(entity) then
		local gamblerEntity = getEntityByID(entity.Roulette_judge.gamblers[entity.Roulette_judge.gamblerIndex])
		x, y = VisualExtent.getTileCenter(entity)
		-- TODO

		return
	end

	entity = ObjectMap.firstWithComponent(x, y, "Roulette_judgeHintLabelOnCursor")
	if entity and entity.Roulette_judge and fullyVisibleAndNotShadowed(entity) then
		local gamblerEntity = getEntityByID(entity.Roulette_judge.gamblers[entity.Roulette_judge.gamblerIndex])
		x, y = VisualExtent.getTileCenter(entity)
		return drawText(entity.Roulette_judgeHintLabelOnCursor.format:format(entity.Roulette_judge.round,
				gamblerEntity and RouletteVisual.getEntityDisplayName(gamblerEntity) or "nil"),
			x, y + entity.Roulette_judgeHintLabelOnCursor.offsetY)
	end

	entity = ObjectMap.firstWithComponent(x, y, "Roulette_gunHintLabelOnCursor")
	if entity and fullyVisibleAndNotShadowed(entity) then
		x, y = VisualExtent.getTileCenter(entity)
		local damage = RouletteGun.calculateDamage(entity)
		damage = tonumber(damage) or 0
		local text = entity.Roulette_gunHintLabelOnCursor.text
		text = text:format(TextFormat.color(damage, hsv(0, clamp(0, (damage - 1) * .25, 1), 1, 1)))
		return drawText(text, x, y + entity.Roulette_gunHintLabelOnCursor.offsetY)
	end

	entity = ObjectMap.firstWithComponent(x, y, "Roulette_hintLabelOnCursor")
	if entity and entity.Roulette_hintLabel and fullyVisibleAndNotShadowed(entity) then
		x, y = VisualExtent.getTileCenter(entity)
		return drawText(entity.Roulette_hintLabel.text, x, y + entity.Roulette_hintLabel.offsetY)
	end
end

event.render.add("renderHintLabelOnCursor", {
	order = "hintLabels",
	sequence = 10,
}, function()
	local drawTextArgs
	local function drawText(text, x, y)
		drawTextArgs = drawTextArgs or {
			alignX = 0.5,
			alignY = 1,
			buffer = Render.Buffer.TEXT_LABEL_FRONT,
			color = -1,
			font = UI.Font.SMALL,
		}
		drawTextArgs.text = text
		drawTextArgs.x = x
		drawTextArgs.y = y
		UI.drawText(drawTextArgs)
	end

	local drawnTiles = {}
	local gamblerHintLabel = RouletteRogue.isModeActive()

	for _, entity in ipairs(Focus.getAll()) do
		local cursorEntity = RouletteCursor.getFromGamblerEntity(entity)
		if cursorEntity and cursorEntity.position then
			drawHintLabel(drawnTiles, cursorEntity.position.x, cursorEntity.position.y, drawText, gamblerHintLabel)
		end
	end
end)

do
	local itemHints
	local itemHintsDistance
	local itemNames

	local function isFocusedEntityClose(entity)
		for _, focusedEntity in ipairs(Focus.getAll(Focus.Flag.TEXT_LABEL)) do
			local distance = distanceL1(focusedEntity.position.x - entity.position.x, focusedEntity.position.y - entity.position.y)

			if distance > 0 and distance <= itemHintsDistance then
				return true
			end
		end
	end

	local function renderHintOrName(entity)
		local text

		if itemHints and getHintLabelText(entity) and isFocusedEntityClose(entity) then
			text = getHintLabelText(entity)
		elseif itemNames then
			text = entity.friendlyName and entity.friendlyName.name or entity.name
		else
			return
		end

		local adjacentItems = 0

		for dx = 1, itemNames and 5 or min(itemHintsDistance - 1, 5) do
			if not checkCollision(entity.position.x - dx, entity.position.y, Collision.Type.ITEM) then
				break
			end

			adjacentItems = adjacentItems + 1
		end

		local x, y = VisualExtent.getTileCenter(entity)

		return UI.drawText {
			font = UI.Font.SMALL,
			text = text,
			x = x,
			y = y + entity.Roulette_hintLabel.offsetY - 8 * adjacentItems,
			buffer = Render.Buffer.TEXT_LABEL_FRONT,
			alignX = 0.5,
			alignY = 1,
		}
	end

	event.render.add("rogueModeRenderItemHintLabels", "hintLabels", function(ev)
		if InstantReplay.isActive() or not RouletteRogue.isModeActive() then
			return
		end

		itemHints = SettingsStorage.get "video.itemHints"
		itemNames = SettingsStorage.get "video.itemNames"
		itemHintsDistance = SettingsStorage.get "video.itemHintsDistance"

		if itemHints or itemNames then
			for entity in ECS.entitiesWithComponents { "Roulette_hintLabel", "visibility" } do
				if entity.visibility.visible and (not entity.silhouette or not entity.silhouette.active) then
					renderHintOrName(entity)
				end
			end
		end
	end)
end
