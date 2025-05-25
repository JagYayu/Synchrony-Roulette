local RouletteRenderUITexts = {}

local Focus = require "necro.game.character.Focus"
local GFX = require "system.gfx.GFX"
local HUD = require "necro.render.hud.HUD"
local HUDLayout = require "necro.render.hud.HUDLayout"
local InstantReplay = require "necro.client.replay.InstantReplay"
local Render = require "necro.render.Render"
local RenderTimestep = require "necro.render.RenderTimestep"
local SpeedrunTimer = require "necro.client.SpeedrunTimer"
local Turn = require "necro.cycles.Turn"
local UI = require "necro.render.UI"
local Utilities = require "system.utils.Utilities"

RouletteRenderUITexts.HUDLayout_TextOverlay = HUDLayout.register {
	name = "Roulette_textOverlay",
	blocking = false,
	slotSize = { 0, 0 },
}
RouletteRenderUITexts.HUDLayout_TextOverlay = RouletteRenderUITexts.HUDLayout_TextOverlay

local textOverlayYMap = {}

event.gameStateLevel.add("resetTextOverlayYPositions", "resetLevelVariables", function()
	textOverlayYMap = {}
end)

event.render.add("updateTextOverlayYPositions", "animationTimer", function()
	local f = 1 - 1e-16 ^ RenderTimestep.getDeltaTime()
	local time = SpeedrunTimer.getTime()
	for id, entry in pairs(textOverlayYMap) do
		if time > entry[1][2] then
			textOverlayYMap[id] = nil
		else
			entry[2] = Utilities.lerp(entry[2], entry[3], f)
		end
	end
end)

local function textOverlayY(line, y)
	local id = line[3]
	textOverlayYMap[id] = textOverlayYMap[id] or { line, y, y }
	textOverlayYMap[id][3] = y
	return textOverlayYMap[id][2]
end

function RouletteRenderUITexts.drawTextOverlay(lines)
	local time = SpeedrunTimer.getTime()
	Utilities.removeIf(lines, function(line)
		return time > line[2]
	end)

	if lines[1] then
		local font = UI.Font.MEDIUM
		local y = (GFX.getHeight() - #lines * font.size) / 2 - 22
		local args = {
			text = "",
			alignX = .5,
			alignY = .5,
			spacingY = 11,
			buffer = Render.Buffer.UI_HUD,
			x = GFX.getWidth() / 2,
			y = y,
			font = font,
			size = font.size * HUD.getScaleFactor(),
		}

		for _, line in ipairs(lines) do
			args.text = line[1]
			args.opacity = line[2] - time
			args.y = textOverlayY(line, y)
			UI.drawText(args)
			y = y + font.size * HUD.getScaleFactor()
		end
	end
end

event.renderGlobalHUD.add("drawTextOverlay", "textOverlay", function()
	if InstantReplay.isActive() then
		return
	end

	local focusedEntity
	for _, entity in ipairs(Focus.getAll()) do
		if entity.Roulette_textOverlay then
			if focusedEntity then
				return
			end

			focusedEntity = entity
		end
	end

	if focusedEntity then
		RouletteRenderUITexts.drawTextOverlay(focusedEntity.Roulette_textOverlay.lines)
	end
end)

local textOverlayLineID = 0

function RouletteRenderUITexts.addTextOverlay(entity, text, time)
	if entity.Roulette_textOverlay then
		local turnID = Turn.getCurrentTurnID()
		for _, line in ipairs(entity.Roulette_textOverlay.lines) do
			if turnID == line[3] then
				return
			end
		end

		entity.Roulette_textOverlay.lines[#entity.Roulette_textOverlay.lines + 1] = {
			text,
			SpeedrunTimer.getTime() + time,
			textOverlayLineID,
		}
		textOverlayLineID = textOverlayLineID + 1
	end
end

-- local grooveChainLinked = false

-- event.updateVisuals.add("cacheGrooveChainLinked", "hud", function(ev)
-- 	grooveChainLinked = not InstantReplay.isActive() and not not SoulLink.allFocusedEntitiesLinked("soulLinkGrooveChain")
-- end)

-- local function drawCoinMultiplier(entity)

-- end

-- event.renderGlobalHUD.override("renderGrooveChain", function(func, ev)
-- 	if grooveChainLinked and RouletteGame.isGameModeActive() then
-- 		return drawCoinMultiplier(Focus.getFirst(Focus.Flag.HUD))
-- 	end

-- 	func(ev)
-- end)

return RouletteRenderUITexts
