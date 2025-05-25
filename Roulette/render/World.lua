local RouletteJudge = require "Roulette.Judge"
local RouletteRenderWorld = {}

local Color = require "system.utils.Color"
local ECS = require "system.game.Entities"
local Focus = require "necro.game.character.Focus"
local OutlineFilter = require "necro.render.filter.OutlineFilter"
local Render = require "necro.render.Render"
local Tile = require "necro.game.tile.Tile"
local Utilities = require "system.utils.Utilities"
local Vision = require "necro.game.vision.Vision"

local TileSize = 24
local getEntityByID = ECS.getEntityByID
local reduceCoordinates = Tile.reduceCoordinates

event.render.add("gamblerSetCursorColor", "spriteEffects", function()
	for entity in ECS.entitiesWithComponents { "Roulette_gambler", "Roulette_gamblerColor" } do
		local cursorEntity = getEntityByID(entity.Roulette_gambler.cursor)
		if cursorEntity and cursorEntity.sprite then
			cursorEntity.sprite.color = entity.Roulette_gamblerColor.color

			if not entity.Roulette_gambler.turn then
				cursorEntity.sprite.color = Color.fade(cursorEntity.sprite.color, entity.Roulette_gamblerColor.fade)
			end
		end
	end
end)

event.render.add("gamblerJudgeStartGameTiles", "floors", function()
	local drawArgs
	local function drawImpl(id, judge, position)
		local index = Utilities.arrayFind(judge.gamblers, id)
		local location = index and judge.locations[index]
		if location and type(location[1]) == "number" and type(location[2]) == "number" then
			drawArgs = drawArgs or {
				texture = "mods/Roulette/gfx/cursor.png",
				rect = { 0, 0, TileSize, TileSize },
				color = -1,
			}

			drawArgs.rect[1] = TileSize * ((position.x - .5) + location[1])
			drawArgs.rect[2] = TileSize * ((position.y - .5) + location[2])
			drawArgs.color = location[3] or -1

			Render.getBuffer(Render.Buffer.FLOOR).draw(drawArgs)
		end
	end

	for _, entity in ipairs(Focus.getAll()) do
		if entity.Roulette_gambler then
			local judgeEntity = getEntityByID(entity.Roulette_gambler.judge)
			if judgeEntity and judgeEntity.Roulette_judge and not RouletteJudge.hasStarted(judgeEntity.Roulette_judge) and judgeEntity.position then
				drawImpl(entity.id, judgeEntity.Roulette_judge, judgeEntity.position)
			end
		end
	end
end)

event.render.add("cursorSelectionOutline", "outlines", function()
	local function draw(entity, color)
		if entity.visibility and entity.visibility.visible then
			local visual = OutlineFilter.getEntityVisual(entity)
			visual.color = color
			visual.z = visual.z - 1e-6
			Render.getBuffer(Render.Buffer.ATTACHMENT).draw(visual)

			return true
		end
	end

	for entity in ECS.entitiesWithComponents { "Roulette_cursor", "sprite" } do
		local color = entity.sprite.color
		local selectedEntity = getEntityByID(entity.Roulette_cursor.selected)

		if selectedEntity and draw(selectedEntity, color) and selectedEntity.characterWithAttachment then
			selectedEntity = getEntityByID(selectedEntity.characterWithAttachment.attachmentID)
			if selectedEntity then
				draw(selectedEntity, color)
			end
		end
	end
end)

event.render.add("renderGamblingArea", "floors", function()
	if 1 then
		return
	end

	local draw = Render.getBuffer(Render.Buffer.FLOOR).draw
	local args = { color = -1, rect = { 0, 0, 0, 0 }, z = 0 }
	local color = Color.hsv(.5, 1, 1)
	local offset = -TileSize / 2

	for entity in ECS.entitiesWithComponents { "Roulette_judgeRoom", "position" } do
		if entity.Roulette_judgeRogue then
			local x, y = entity.position.x, entity.position.y

			args.rect[2] = y - 4 * TileSize + offset
			args.rect[3] = 24
			args.rect[4] = 1
			args.z = -y * TileSize
			for i = -4, 4 do
				local tx, ty = x + i, y - 4
				if Vision.isVisibleAndLit(tx, ty) then
					args.rect[1] = tx * TileSize + offset
					args.color = Color.fade(color, Vision.getEffectiveBrightness(tx, ty) / 255)
					draw(args)
				end
			end

			args.rect[2] = y + 5 * TileSize - 1 + offset
			for i = -4, 4 do
				local tx, ty = x + i, y + 4
				if Vision.isVisibleAndLit(tx, ty) then
					args.rect[1] = tx * TileSize + offset
					args.color = Color.fade(color, Vision.getEffectiveBrightness(tx, ty) / 255)
					draw(args)
				end
			end

			args.rect[1] = x - 4 * TileSize + offset
			args.rect[3] = 1
			args.rect[4] = 24
			for i = -4, 4 do
				local tx, ty = x - 4, y + i
				if Vision.isVisibleAndLit(tx, ty) then
					args.rect[2] = ty * TileSize + offset
					args.color = Color.fade(color, Vision.getEffectiveBrightness(tx, ty) / 255)
					draw(args)
				end
			end

			args.rect[1] = x + 5 * TileSize + offset - 1
			for i = -4, 4 do
				local tx, ty = x + 4, y + i
				if Vision.isVisibleAndLit(tx, ty) then
					args.rect[2] = ty * TileSize + offset
					args.color = Color.fade(color, Vision.getEffectiveBrightness(tx, ty) / 255)
					draw(args)
				end
			end
		end
	end
end)
