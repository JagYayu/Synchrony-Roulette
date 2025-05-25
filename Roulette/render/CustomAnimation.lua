local AnimationTimer = require "necro.render.AnimationTimer"
local Character = require "necro.game.character.Character"
local ECS = require "system.game.Entities"
local RenderTimestep = require "necro.render.RenderTimestep"
local Utilities = require "system.utils.Utilities"

event.animateObjects.add("applyShrineActiveAnimations", "trapActivation", function()
	for entity in ECS.entitiesWithComponents { "Roulette_shrineOfTime", "spriteSheet" } do
		entity.spriteSheet.frameX = entity.Roulette_shrineOfTime.level > 1 and 2 or 1
	end
end)

local customAnimationDataMap = {
	dragon = {},
	ogre = {},
	plasmaCannon = {},
}

event.objectDelete.add("removeFromCustomAnimationData", "effects", function(ev)
	for _, map in pairs(customAnimationDataMap) do
		map[ev.entity.id] = nil
	end
end)

event.gameStateLevel.add("resetCustomData", "resetLevelVariables", function()
	for k in pairs(customAnimationDataMap) do
		customAnimationDataMap[k] = {}
	end
end)

--#region Gun

event.animateObjects.add("applyPlasmaCannonAnimation", "custom", function()
	local time = AnimationTimer.getTime()
	local plasmaCannonDataMap = customAnimationDataMap.plasmaCannon

	for entity in ECS.entitiesWithComponents { "Roulette_gun", "Roulette_plasmaCannon", "spriteSheet" } do
		local data = plasmaCannonDataMap[entity.id] or {}
		plasmaCannonDataMap[entity.id] = data

		local bulletNum = data.visualBulletNumber and data.visualBulletNumber or #entity.Roulette_gun.bullets
		if bulletNum ~= data.prevNum then
			data = data or {}
			data.blinkTime = time + .5
			data.prevNum = bulletNum
			plasmaCannonDataMap[entity.id] = data
		end

		if time <= data.blinkTime then
			entity.spriteSheet.frameX = math.floor(time * 32) % 2 + 1
		else
			entity.spriteSheet.frameX = bulletNum ~= 0 and 1 or 2
		end
	end
end)

event.Roulette_sequenceGunShot.add("plasmaCannonOverrideVisualBulletNumber", {
	filter = "Roulette_plasmaCannon",
	order = "shot",
	sequence = 1,
}, function(ev)
	local data = customAnimationDataMap.plasmaCannon[ev.entity.id]
	if data then
		data.visualBulletNumber = #ev.component.bullets + (ev.parameter.bullet and 1 or 0)
	end
end)

event.Roulette_sequenceGunShot2.add("plasmaCannonOverrideVisualBulletNumber", {
	filter = "Roulette_plasmaCannon",
	order = "shot",
	sequence = 1,
}, function(ev)
	local data = customAnimationDataMap.plasmaCannon[ev.entity.id]
	if data then
		data.visualBulletNumber = nil
	end
end)

--#endregion

--#region Dragon

event.animateObjects.add("dragonAnimation", "custom", function()
	local dragonDataMap = customAnimationDataMap.dragon
	for entity in ECS.entitiesWithComponents { "Roulette_dragon", "spriteSheet" } do
		local id = entity.id
		if entity.Roulette_dragon.state == 0 then
			dragonDataMap[id] = nil
		else
			dragonDataMap[id] = dragonDataMap[id] or { state = entity.Roulette_dragon.state, timer = 0 }
			local data = dragonDataMap[id]

			if data.state ~= entity.Roulette_dragon.state then
				data.state = entity.Roulette_dragon.state
				data.timer = 0
			end

			data.timer = data.timer + RenderTimestep.getDeltaTime()
			entity.spriteSheet.frameX = 1 + data.state * 3 + Utilities.lowerBound(data.state == 1 and { .2, .4 } or { .2 }, data.timer)
		end
	end
end)

--#endregion

--#region Ogre

event.animateObjects.add("ogreAnimation", "custom", function()
	local ogreDataMap = customAnimationDataMap.ogre
	for entity in ECS.entitiesWithComponents { "Roulette_gamblerOgre", "clonkingSprite", "facingDirection" } do
		local id = entity.id
		local data = ogreDataMap[id]
		if entity.Roulette_gamblerOgre.state then
			if not data then
				data = { timer = 0 }
				ogreDataMap[id] = data
			end

			local sprite = entity.clonkingSprite.sprites[entity.facingDirection.direction]
			if sprite then
				data.timer = data.timer + RenderTimestep.getDeltaTime()
				Character.setDynamicSprite(entity, entity.clonkingSprite.sprites[entity.facingDirection.direction])
				entity.spriteSheet.frameX = Utilities.lowerBound({ .1, .2, .3, .5, .6, .675, .75, .9 }, data.timer)
				entity.spriteSheet.frameX = entity.spriteSheet.frameX > 8 and 1 or entity.spriteSheet.frameX
			end
		elseif data then
			ogreDataMap[id] = nil
			Character.setDynamicSprite(entity)
		end
	end
end)

--#endregion
