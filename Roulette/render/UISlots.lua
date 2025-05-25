local RouletteCursor = require "Roulette.Cursor"
local RouletteGambler = require "Roulette.Gambler"

local ECS = require "system.game.Entities"
local HUD = require "necro.render.hud.HUD"
local ObjectMap = require "necro.game.object.Map"
local ObjectRenderer = require "necro.render.level.ObjectRenderer"
local OutlineFilter = require "necro.render.filter.OutlineFilter"
local RenderTimestep = require "necro.render.RenderTimestep"
local TextFormat = require "necro.config.i18n.TextFormat"
local UI = require "necro.render.UI"
local Utilities = require "system.utils.Utilities"

local floor = math.floor

event.inventoryHUDRenderSlot.add("cursor", {
	filter = "Roulette_cursorSlotLabel",
	order = "slotHeaderLabel",
}, function(ev)
	ev.slotLabel = ev.item.Roulette_cursorSlotLabel.text
end)

-- event.inventoryHUDRenderSlot.add("cursorSpriteOverride", {
-- 	filter = "Roulette_cursorSlotLabel",
-- 	order = "item",
-- 	sequence = 1,
-- }, function(ev)
-- 	local entity = ev.drawArgs and RouletteCursor.getSelectionAtCursorEntity(ev.item)
-- 	if entity then
-- 		local drawArgs = Utilities.fastCopy(ev.drawArgs)
-- 		local visual = ObjectRenderer.getObjectVisual(entity)

-- 		drawArgs.texRect = visual.texRect
-- 		drawArgs.texture = visual.texture
-- 		drawArgs.color = visual.color
-- 		ev.drawArgs = drawArgs
-- 	end
-- end)

event.inventoryHUDRenderSlot.add("renderItemChargeOutline", {
	filter = "Roulette_itemChargeRenderOutline",
	order = "renderSprite",
}, function(ev)
	if ev.drawArgs and ev.item.Roulette_itemCharge.charged > 0 then
		local visual = OutlineFilter.getEntityVisual(ev.item, Utilities.fastCopy(ev.drawArgs))
		visual.color = ev.item.Roulette_itemChargeRenderOutline.color
		ev.buffer.draw(visual)
	end
end)

local armorDurabilityPercentages = {}

local function renderItemArmorDurabilityHandler(ev)
	if not (ev.slotPosInfo and ev.slotPosInfo.image and ev.elementInfo.element ~= "actions") then
		return
	end

	if ev.holder.Roulette_gambler and not RouletteGambler.isGambling(ev.holder.Roulette_gambler) then
		armorDurabilityPercentages[ev.item.id] = nil
		return
	end

	local id = ev.item.id
	local percentage = ev.item.Roulette_itemCharge.charged / ECS.getEntityPrototype(ev.item.name).Roulette_itemCharge.charged
	if not armorDurabilityPercentages[id] then
		armorDurabilityPercentages[id] = percentage
	else
		armorDurabilityPercentages[id] = Utilities.lerp(armorDurabilityPercentages[id], percentage,
			(1 - 1e-20 ^ RenderTimestep.getDeltaTime()) ^ 2)
	end
	percentage = armorDurabilityPercentages[id]
	if percentage < 1e-3 then
		return
	end

	local args = Utilities.fastCopy(ev.slotPosInfo)
	args.element = ev.elementInfo.element
	args.slot = ev.slotPosInfo.slot
	args.z = -1
	args.image = "mods/Roulette/gfx/durability.png"
	args.imageRect = { 0, 0, 30, 42 }
	args.imageRect[1] = floor(percentage * 28 + 0.5) * args.imageRect[3]

	local frameX = 6
	local frameWidth = 30
	local frameHeight = 33
	local frames = 29
	local w, h, x = frameWidth, frameHeight, frameX
	local i = math.max(math.ceil(Utilities.clamp(0, percentage, 1) * (frames - 1)) - 1, 0)
	HUD.drawSprite {
		image = "mods/Roulette/gfx/durability.png",
		element = ev.elementInfo.element,
		slot = ev.slotPosInfo.slot,
		imageRect = { (i % x) * w, math.floor(i / x) * h, w, h },
		z = ev.elementInfo.order - 3,
	}
end

event.inventoryHUDRenderSlot.add("renderItemArmorDurability", {
	filter = { "Roulette_itemArmor", "!Roulette_itemChargeRenderOutline" },
	order = "renderSprite",
}, renderItemArmorDurabilityHandler)
event.inventoryHUDRenderSlot.add("renderItemArmorProtectiveDurability", {
	filter = { "Roulette_itemArmorProtective", "!Roulette_itemChargeRenderOutline" },
	order = "renderSprite",
}, renderItemArmorDurabilityHandler)

event.objectDespawn.add("removeFromArmorDurabilityPercentages", {
	filter = { "Roulette_itemArmor", "Roulette_itemCharge" },
	order = "despawnExtras",
}, function(ev)
	armorDurabilityPercentages[ev.entity.id] = nil
end)

event.inventoryHUDRenderSlot.add("itemUseSetGamblerDisengageOpacity", {
	filter = "Roulette_itemUseSetGamblerDisengage",
	order = "opacity",
}, function(ev)
	if not ev.item.Roulette_itemUseSetGamblerDisengage.activation then
		ev.opacity = ev.item.Roulette_itemUseSetGamblerDisengage.opacityInactive
	end
end)

event.inventoryHUDRenderSlot.add("itemUseSetGamblerDisengageGolds", {
	filter = "Roulette_itemUseSetGamblerDisengage",
	order = "ammoCount",
}, function(ev)
	if ev.item.Roulette_itemUseSetGamblerDisengage.activation then
		local gold = TextFormat.icon("mods/Roulette/gfx/spell_disengage_gold.png", UI.getScaleFactor())
		ev.labels[#ev.labels + 1] = {
			text = tostring(ev.item.Roulette_itemUseSetGamblerDisengage.gold) .. "x" .. gold,
			alignY = .9,
			alignX = 1,
		}
	end
end)
