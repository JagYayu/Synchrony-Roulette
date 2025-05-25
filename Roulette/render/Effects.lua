local RouletteGambler = require "Roulette.Gambler"

local AnimationTimer = require "necro.render.AnimationTimer"
local Color = require "system.utils.Color"
local ECS = require "system.game.Entities"
local Render = require "necro.render.Render"
local Tile = require "necro.game.tile.Tile"
local Utilities = require "system.utils.Utilities"
local VisualExtent = require "necro.render.level.VisualExtent"

local floor = math.floor
local isGambling = RouletteGambler.isGambling

event.render.add("renderGamblerStatusFreezeParticles", "particles", function()
	local draw = Render.getBuffer(Render.Buffer.PARTICLE).draw
	local args
	local blink = (AnimationTimer.getTime() % (1 / 6)) < (1 / 12)

	for entity in ECS.entitiesWithComponents { "Roulette_gamblerStatusFreeze", "particleFreeze", "visibility", "rowOrder" } do
		if entity.Roulette_gamblerStatusFreeze.turns > 0 and isGambling(entity.Roulette_gambler) and entity.visibility.visible then
			args = args or {
				rect = { 0, 0, 0, 0 },
				texRect = { 0, 0, 0, 0 }
			}

			local x, y = Render.tileRenderingOrigin(entity.position.x, entity.position.y)
			local params = entity.particleFreeze
			local frameY = params.silhouette and entity.silhouette and entity.silhouette.active and 1 or 0
			local shadow = entity.shadow or {
				offsetX = 0,
				offsetY = 0
			}

			args.rect[1] = x + shadow.offsetX + params.offsetX
			args.rect[2] = y + shadow.offsetY + params.offsetY
			args.rect[3] = params.width
			args.rect[4] = params.height
			args.texRect[2] = params.height * frameY
			args.texRect[3] = params.width
			args.texRect[4] = params.height
			args.texture = params.texture
			args.z = entity.sprite.y + entity.rowOrder.z + params.offsetZ
			args.color = (blink and entity.Roulette_gamblerStatusFreeze.turns == 1) and 0 or -1

			draw(args)
		end
	end
end)

event.render.add("renderGamblerStatusShieldParticles", "particles", function()
	local draw = Render.getBuffer(Render.Buffer.PARTICLE).draw
	local args
	local time = AnimationTimer.getTime()
	local blink = (time % (1 / 6)) < (1 / 12)

	for entity in ECS.entitiesWithComponents { "Roulette_gamblerStatusShield", "particleBarrier", "visibility" } do
		local params = entity.particleBarrier

		if entity.Roulette_gamblerStatusShield.turns > 0 and isGambling(entity.Roulette_gambler) and entity.visibility.fullyVisible and entity.sprite.visible then
			args = args or {
				anim = 0,
				z = 0,
				rect = { 0, 0, 0, 0 },
				texRect = { 0, 0, 0, 0 },
			}

			local frameX = floor(time / params.animationPeriod % 1 * params.numFrames)
			local x, y, z = VisualExtent.getOrigin(entity)

			args.rect[1] = x + params.offsetX - params.width * 0.5
			args.rect[2] = y + z + params.offsetY - params.height
			args.rect[3] = params.width
			args.rect[4] = params.height - (entity.croppedSprite and entity.croppedSprite.bottom or 0)
			args.texRect[1] = params.width * frameX
			args.texRect[3] = params.width
			args.texRect[4] = args.rect[4]
			--- @diagnostic disable-next-line: undefined-field
			args.anim = entity.spriteExtrapolatable and entity.spriteExtrapolatable.animID or 0
			args.color = (blink and entity.Roulette_gamblerStatusShield.turns < 1) and 0 or -1

			local zOrder = VisualExtent.getZOrder(entity)

			args.texture = params.frontTexture
			args.z = zOrder + params.frontZ
			draw(args)

			args.texture = params.backTexture
			args.z = zOrder + params.backZ
			draw(args)
		end
	end
end)

do
	local function apply(entity, component, animationTime)
		local currentX = component.x * floor(animationTime / component.period % 2)

		entity.sprite.x = entity.sprite.x - currentX
		entity.visualExtent.x = entity.visualExtent.x + currentX
	end

	event.renderEffects.add("gamblerVibrateEffect", "vibrate", function()
		local animationTime = AnimationTimer.getTime()

		for entity in ECS.entitiesWithComponents {
			"Roulette_gamblerVibrateEffect",
			"sprite",
			"!spriteVibrate",
		} do
			if entity.Roulette_gamblerVibrateEffect.active then
				apply(entity, entity.Roulette_gamblerVibrateEffect, animationTime)
			end
		end

		for entity in ECS.entitiesWithComponents {
			"Roulette_gamblerVibrateEffect",
			"sprite",
			"spriteVibrate",
		} do
			if not entity.spriteVibrate.active and entity.Roulette_gamblerVibrateEffect.active then
				apply(entity, entity.Roulette_gamblerVibrateEffect, animationTime)
			end
		end
	end)
end

event.renderEffects.add("gunStatusBurnt", "opacity", function()
	for entity in ECS.entitiesWithComponents { "Roulette_gunStatusBurnt", "sprite" } do
		local s = Utilities.clamp(0, (entity.Roulette_gunStatusBurnt.multiplier - 1) / 2, 1)
		entity.sprite.color = Color.hsv(0, s, 1)
	end
end)

event.objectUpdateScale.add("gamblerShrinkSpriteScale", {
	filter = "Roulette_gamblerStatusShrink",
	order = "multiply",
}, function(ev)
	if ev.entity.Roulette_gamblerStatusShrink.turns > 0 then
		ev.scale = ev.scale * ev.entity.Roulette_gamblerStatusShrink.spriteSizeMultiplier
		if ev.entity.Roulette_gamblerStatusShrink.turns == 1 and (AnimationTimer.getTime() % (1 / 6)) < (1 / 12) then
			ev.scale = Utilities.lerp(ev.scale, ECS.getEntityPrototype(ev.entity.name).sprite.scale, .2)
		end
	end
end)
