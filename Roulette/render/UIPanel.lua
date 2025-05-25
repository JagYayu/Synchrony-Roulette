local RouletteUIPanel = {}
local RouletteUtility = require "Roulette.Utility"
local RouletteVisual = require "Roulette.render.Visuals"

local Beatmap = require "necro.audio.Beatmap"
local Color = require "system.utils.Color"
local ECS = require "system.game.Entities"
local Focus = require "necro.game.character.Focus"
local GFX = require "system.gfx.GFX"
local ObjectRenderer = require "necro.render.level.ObjectRenderer"
local ObjectSelector = require "necro.game.object.ObjectSelector"
local Render = require "necro.render.Render"
local RenderTimestep = require "necro.render.RenderTimestep"
local UI = require "necro.render.UI"
local Utilities = require "system.utils.Utilities"

local TileSize = Render.TILE_SIZE

--- @type Entity.ID
local activeTurnEntityID = 0
--- @type { [1]: number, [2]: number, [3]: number } | false
local arrowScreenPosition = false
--- @type number
local entityInfoOpacity = 0
--- @type table<Entity, true>
local entityMidJoinedSet = setmetatable({}, { __mode = "k" })
--- @type table<Entity, { [1]: number, [2]: number, [3]: number, [4]: number }>
local entityScreenPositionMap = setmetatable({}, { __mode = "k" })

event.gameStateLevel.add("resetUIPanelVariables", "resetLevelVariables", function()
	activeTurnEntityID = 0
	arrowScreenPosition = false
	entityInfoOpacity = 0
	entityMidJoinedSet = setmetatable({}, { __mode = "k" })
	entityScreenPositionMap = setmetatable({}, { __mode = "k" })
end)

--- @param entity Entity
function RouletteUIPanel.markEntityMidJoined(entity)
	entityMidJoinedSet[entity] = true
end

local function entityScreenPosition(entity, x, y)
	local position = entityScreenPositionMap[entity]

	if position then
		position[1] = x
		position[2] = y
	else
		position = { x, y, x, y }
		entityScreenPositionMap[entity] = position
	end

	return position[3], position[4]
end

local function arrowPosition(x, y)
	if not (x and y) then
		arrowScreenPosition = {}
		return 0, 0
	end

	if arrowScreenPosition then
		arrowScreenPosition[1] = x
		arrowScreenPosition[2] = y
	else
		arrowScreenPosition = { x, y, x }
	end

	return arrowScreenPosition[3], arrowScreenPosition[2]
end

local snap = 0

event.windowSizeChanged.add("gamblingPanelSnaps", "menu", function()
	snap = 2
end)

event.render.add("gamblingPanelTransitions", {
	order = "hud",
	sequence = 1,
}, function()
	local f = 1 - 1e-20 ^ RenderTimestep.getDeltaTime()
	f = f * f
	local lerp = Utilities.lerp

	if snap > 0 then
		snap = snap - 1

		if arrowScreenPosition then
			arrowScreenPosition[3] = arrowScreenPosition[1]
		end

		for _, entry in pairs(entityScreenPositionMap) do
			entry[3] = entry[1]
			entry[4] = entry[2]
		end
	else
		if arrowScreenPosition then
			arrowScreenPosition[3] = lerp(arrowScreenPosition[3], arrowScreenPosition[1], f)
		end

		for _, entry in pairs(entityScreenPositionMap) do
			entry[3] = lerp(entry[3], entry[1], f)
			entry[4] = lerp(entry[4], entry[2], f)
		end
	end

	local activeEntity = ECS.getEntityByID(activeTurnEntityID)
	if activeEntity then
		entityInfoOpacity = lerp(entityInfoOpacity, activeEntity.Roulette_gambler.turn and 1 or 0, f)
	end
end)

local entityStatusImagesSelectorFire = ObjectSelector.new("Roulette_entityStatusImages", {
	"gamblerDelay",
	"beatDelay",
	"freeze",
	"shielding",
	"silence",
	"shrink",
	"charm",
}).fire

local StatusBaseWidth = 12
local StatusBaseHeight = 12
local StatusImageEntries = {
	delay = {
		texture = "mods/Roulette/gfx/gambler_status.png",
		textureShiftX = 0,
		textureShiftY = 0,
		textureWidth = StatusBaseWidth,
		textureHeight = StatusBaseHeight,
		color = Color.WHITE,
	},
	freeze = {
		texture = "mods/Roulette/gfx/gambler_status.png",
		textureShiftX = 12,
		textureShiftY = 0,
		textureWidth = StatusBaseWidth,
		textureHeight = StatusBaseHeight,
		color = Color.WHITE,
	},
	shielding = {
		texture = "mods/Roulette/gfx/gambler_status.png",
		textureShiftX = 24,
		textureShiftY = 0,
		textureWidth = StatusBaseWidth,
		textureHeight = StatusBaseHeight,
		color = Color.WHITE,
	},
	silence = {
		texture = "mods/Roulette/gfx/gambler_status.png",
		textureShiftX = 36,
		textureShiftY = 0,
		textureWidth = StatusBaseWidth,
		textureHeight = StatusBaseHeight,
		color = Color.WHITE,
	},
	charm = {
		texture = "mods/Roulette/gfx/gambler_status.png",
		textureShiftX = 0,
		textureShiftY = 12,
		textureWidth = StatusBaseWidth,
		textureHeight = StatusBaseHeight,
		color = Color.WHITE,
	},
}

event.objectRoulette_entityStatusImages.add("gamblerTurnDelay", {
	filter = "Roulette_gambler",
	order = "gamblerDelay",
	sequence = -1,
}, function(ev) --- @param ev Event.objectRoulette_entityStatusImages
	if ev.entity.Roulette_gambler.turnDelay > 0 then
		ev.entries.delay = Utilities.fastCopy(StatusImageEntries.delay)
	end
end)

event.objectRoulette_entityStatusImages.add("beatDelay", {
	filter = "beatDelay",
	order = "beatDelay",
}, function(ev) --- @param ev Event.objectRoulette_entityStatusImages
	local counter = ev.entity.beatDelay.counter
	if counter > 0 and not (ev.entity.Roulette_gambler and ev.entity.Roulette_gambler.turn) then
		ev.entries.delay = Utilities.fastCopy(StatusImageEntries.delay)
		if counter > 1 then
			ev.entries.delay.number = counter
		end
	end
end)

event.objectRoulette_entityStatusImages.add("freeze", {
	filter = "Roulette_gamblerStatusFreeze",
	order = "freeze",
}, function(ev) --- @param ev Event.objectRoulette_entityStatusImages
	local turns = ev.entity.Roulette_gamblerStatusFreeze.turns - 1
	if turns > 0 then
		ev.entries.freeze = Utilities.fastCopy(StatusImageEntries.freeze)
		if turns > 1 then
			ev.entries.freeze.number = turns
		end
	end
end)

event.objectRoulette_entityStatusImages.add("shielding", {
	filter = "Roulette_gamblerStatusShield",
	order = "shielding",
}, function(ev) --- @param ev Event.objectRoulette_entityStatusImages
	local turns = math.ceil(ev.entity.Roulette_gamblerStatusShield.turns)
	if turns > 0 then
		ev.entries.shielding = Utilities.fastCopy(StatusImageEntries.shielding)
		if turns > 1 then
			ev.entries.shielding.number = turns
		end
	end
end)

event.objectRoulette_entityStatusImages.add("silence", {
	filter = "Roulette_gamblerStatusSilence",
	order = "freeze",
}, function(ev) --- @param ev Event.objectRoulette_entityStatusImages
	local turns = ev.entity.Roulette_gamblerStatusSilence.turns
	if turns > 0 then
		ev.entries.silence = Utilities.fastCopy(StatusImageEntries.silence)
		if turns > 1 then
			ev.entries.silence.number = turns
		end
	end
end)

event.objectRoulette_entityStatusImages.add("charm", {
	filter = "Roulette_gamblerCharmable",
	order = "charm",
}, function(ev) --- @param ev Event.objectRoulette_entityStatusImages
	local turns = ev.entity.Roulette_gamblerCharmable.turns
	if turns > 0 then
		ev.entries.charm = Utilities.fastCopy(StatusImageEntries.charm)
		ev.entries.charm.color = ev.entity.Roulette_gamblerCharmable.color
		if turns > 1 then
			ev.entries.charm.number = turns
		end
	end
end)

--- @class RouletteUIPanel.StatusImage
--- @field texture string
--- @field textureShiftX string
--- @field textureShiftY string
--- @field textureWidth string
--- @field textureHeight string
--- @field color Color
--- @field number string?
--- @field key string
--- @field priority number

--- @param entity Entity
--- @return RouletteUIPanel.StatusImage[]
function RouletteUIPanel.getEntityStatusImages(entity)
	--- @class Event.objectRoulette_entityStatusImages
	--- @field texture string
	--- @field textureShiftX integer
	--- @field textureShiftY integer
	--- @field textureWidth integer
	--- @field textureHeight integer
	--- @field color integer
	--- @field number number?
	--- @field priority number?

	--- @class Event.objectRoulette_entityStatusImages
	--- @field entity Entity
	--- @field entries table<string, Event.objectRoulette_entityStatusImages>
	local ev = {
		entity = entity,
		entries = {},
	}
	entityStatusImagesSelectorFire(ev, entity)

	local imageList = {}
	for key, entry in pairs(ev.entries) do
		--- @diagnostic disable-next-line: inject-field
		entry.key = key
		entry.priority = tonumber(entry.priority) or #imageList
		imageList[#imageList + 1] = entry
	end

	return Utilities.sort(imageList, function(l, r)
		if l.priority ~= r.priority then
			return l.priority > r.priority
		else
			return l.key < r.key
		end
	end)
end

local PanelEntryWidth = TileSize + 4

local function renderGamblingPanel(judge, gamblerEntities)
	local bufferID = Render.Buffer.UI_HUD
	local draw = Render.getBuffer(bufferID).draw
	local screenCenterX = GFX.getWidth() / 2
	local scale = UI.getScaleFactor()

	local screenTopY = 0
	local visuals = Utilities.newTable(#gamblerEntities, 0)
	for i, gamblerEntity in ipairs(gamblerEntities) do
		visuals[i] = Utilities.fastCopy(ObjectRenderer.getObjectVisual(gamblerEntity))
		screenTopY = math.min(math.max(math.abs(visuals[i].rect[3]), screenTopY), 32)
	end
	screenTopY = (screenTopY + 2) * 2

	local arrowTexture = "mods/Roulette/gfx/arrow.png"
	local arrowWidth, arrowHeight = GFX.getImageSize(arrowTexture)
	arrowWidth = arrowWidth * 2
	arrowHeight = arrowHeight * 2

	local totalWidth = math.min(#gamblerEntities, 8) * PanelEntryWidth
	local numberFont = Utilities.fastCopy(UI.Font.MONO_SMALL)
	numberFont.size = numberFont.size * scale

	for i, entity in ipairs(gamblerEntities) do
		local activeTurn = entity.Roulette_gambler and entity.Roulette_gambler.turn
		activeTurnEntityID = (activeTurn and entity.id) or activeTurnEntityID

		local visual = visuals[i]
		local offsetY = activeTurn and 0 or arrowHeight
		local rect
		local z
		do
			local w = visual.rect[3] * scale
			local h = visual.rect[4] * scale
			local x = screenCenterX + (-totalWidth / 2 + (i - .5) * PanelEntryWidth - visual.rect[3] / 2) * scale + w / 2
			local y = screenTopY - visual.rect[4] * scale + offsetY + h / 2

			local entityX, entityY = entityScreenPosition(entity, x, y)
			if entityMidJoinedSet[entity] then
				entityMidJoinedSet[entity] = nil
				entityY = -visual.rect[4] * scale * 20
				entityScreenPositionMap[entity][4] = entityY
			end

			rect = {
				entityX - w / 2,
				entityY - h / 2,
				w,
				h,
			}
			local col = Color.darken(Color.WHITE, activeTurn and 1 or .5)
			z = (activeTurn and 1 or 0) - .01 * i

			draw {
				texture = visual.texture,
				texRect = visual.texRect,
				rect = rect,
				color = col,
				z = z,
			}

			local headEntity = entity.characterWithAttachment and ECS.getEntityByID(entity.characterWithAttachment.attachmentID)
			if headEntity then
				local headVisual = ObjectRenderer.getObjectVisual(headEntity)
				draw {
					texture = headVisual.texture,
					texRect = headVisual.texRect,
					rect = rect,
					color = col,
					z = z,
				}
			end
		end

		for j, image in ipairs(RouletteUIPanel.getEntityStatusImages(entity)) do
			local x = rect[1] + (rect[3] < 0 and rect[3] or 0) + (entity.visualExtent and entity.visualExtent.x)
			local y = rect[2] + rect[4] - (StatusBaseHeight + (j - 1) * 8) * scale
			local zOrd = z - j + 200
			draw {
				texture = image.texture,
				texRect = { image.textureShiftX, image.textureShiftY, image.textureWidth, image.textureHeight },
				rect = { x, y, StatusBaseWidth * scale, StatusBaseHeight * scale },
				color = Color.fade(image.color, activeTurn and 1 or .7),
				z = zOrd,
			}

			if image.number then
				UI.drawText {
					buffer = bufferID,
					font = numberFont,
					text = image.number > 99 and "∞" or tostring(image.number),
					opacity = activeTurn and 1 or .9,
					x = x,
					y = y + StatusBaseWidth * scale - numberFont.size,
					z = zOrd,
				}
			end
		end

		if i == judge.Roulette_judge.gamblerIndex then
			local f = Beatmap.getPrimary().getMusicBeatFraction()
			local arrowX, arrowY = arrowPosition(
				rect[1] + rect[3] / 2 - arrowWidth / 2,
				rect[2] + rect[4] * (.95 + Utilities.lerp(0, activeTurn and .2 or .1, f * f)) - offsetY / 2)
			draw {
				texture = arrowTexture,
				rect = {
					arrowX,
					arrowY,
					arrowWidth,
					arrowHeight,
				},
				color = Color.darken(Color.WHITE, activeTurn and 1 or .7),
				z = 1,
			}
		end
	end

	local activeEntity = ECS.getEntityByID(activeTurnEntityID)
	if activeEntity and entityInfoOpacity > 0 then
		local f = Beatmap.getPrimary().getMusicBeatFraction()
		local opacity = math.min(entityInfoOpacity, .75 + f ^ 1.75, 1)

		screenTopY = screenTopY + scale

		local font = Utilities.fastCopy(UI.Font.LARGE)
		--- @diagnostic disable-next-line: inject-field
		font.outlineThickness = 2

		UI.drawText {
			buffer = bufferID,
			text = RouletteVisual.getEntityDisplayName(activeEntity),
			font = font,
			x = screenCenterX,
			y = screenTopY,
			alignX = .5,
			alignY = -1,
			opacity = opacity,
		}
	end
end

event.renderGlobalHUD.add("renderGamblingPanel", "grooveChain", function()
	local judge
	for _, entity in ipairs(Focus.getAll(Focus.Flag.CAMERA)) do
		if entity.Roulette_gambler then
			if not judge then
				judge = ECS.getEntityByID(entity.Roulette_gambler.judge)
			elseif judge.id ~= entity.Roulette_gambler.judge then
				return false
			end
		end
	end

	if judge then
		local gamblerEntities = RouletteUtility.getEntitiesFromIDs(judge.Roulette_judge.gamblers)
		if gamblerEntities[1] then
			renderGamblingPanel(judge, gamblerEntities)
		end
	end
end)

activeTurnEntityID, arrowScreenPosition, entityInfoOpacity, entityMidJoinedSet, entityScreenPositionMap = script.persist(function()
	return activeTurnEntityID, arrowScreenPosition, entityInfoOpacity, entityMidJoinedSet, entityScreenPositionMap
end)

return RouletteUIPanel
