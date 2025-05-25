local RouletteGame = require "Roulette.Game"
local RouletteCameraLock = {}

local Camera = require "necro.render.Camera"
local CameraTarget = require "necro.render.CameraTarget"
local Collision = require "necro.game.tile.Collision"
local ECS = require "system.game.Entities"
local EntitySelector = require "system.events.EntitySelector"
local Enum = require "system.utils.Enum"
local Focus = require "necro.game.character.Focus"
local Render = require "necro.render.Render"

local TileSize = Render.TILE_SIZE

local getCameraRectFromEntitySelectorFire = EntitySelector.new(event.Roulette_getCameraRectFromEntity, {
	"fixed",
	"room",
	"default",
}).fire

--- @param entity Entity
--- @param baseWidth number
--- @param baseHeight number
--- @return Rectangle?
--- @return Event.Roulette_getCameraRectFromEntity
function RouletteCameraLock.getCameraRectFromEntity(entity, baseWidth, baseHeight)
	--- @class Event.Roulette_getCameraRectFromEntity
	--- @field entity Entity
	--- @field baseWidth number
	--- @field baseHeight number
	--- @field rect Rectangle?
	local ev = {
		entity = entity,
		baseWidth = baseWidth,
		baseHeight = baseHeight,
		rect = nil,
	}
	getCameraRectFromEntitySelectorFire(ev, entity.name)
	return ev.rect, ev
end

event.Roulette_getCameraRectFromEntity.add("fixed", {
	filter = { "Roulette_cameraRectFixed", "position" },
	order = "fixed",
}, function(ev) --- @param ev Event.Roulette_getCameraRectFromEntity
	local component = ev.entity.Roulette_cameraRectFixed
	local position = ev.entity.position
	local t = component.radius * TileSize
	ev.rect = {
		(position.x + component.offsetX) * TileSize - t,
		(position.y + component.offsetY) * TileSize - t,
		t * 2,
		t * 2,
	}
end)

event.Roulette_getCameraRectFromEntity.add("roomRaycast", {
	filter = "Roulette_cameraRectRaycast",
	order = "room",
}, function(ev) --- @param ev Event.Roulette_getCameraRectFromEntity
	local comp = ev.entity.Roulette_cameraRectRaycast
	ev.rect = { comp.x, comp.y, comp.w, comp.h }
end)

local RaycastCollisionMask = Collision.Type.mask(Collision.Type.WALL, Collision.Type.PREBOSS)

local function rayCheck(x, y)
	return not Collision.check(x, y, RaycastCollisionMask)
end

--- @param cameraRectRaycast Component.Roulette_cameraRectRaycast
--- @param position Component.position
local function cameraRectRaycastImpl(cameraRectRaycast, position)
	local b
	local x
	local y
	local w
	local h

	local t
	local mt = 100
	b = true
	x = position.x
	y = position.y
	w = 1
	h = 1
	t = 0
	repeat
		x = x - 1
		t = t + 1
		if t > mt then
			b = false
			break
		end
	until not rayCheck(x, y)
	t = 0
	repeat
		y = y - 1
		t = t + 1
		if t > mt then
			b = false
			break
		end
	until not rayCheck(x + 1, y)
	t = 0
	repeat
		w = w + 1
		t = t + 1
		if t > mt then
			b = false
			break
		end
	until not rayCheck(x + w, y + h)
	t = 0
	repeat
		h = h + 1
		t = t + 1
		if t > mt then
			b = false
			break
		end
	until not rayCheck(x + w - 1, y + h)

	if b then
		x, y, w, h = CameraTarget.rectangleWithSizeAtLeast((x - .5) * TileSize, (y - 1) * TileSize, (w + 1) * TileSize, (h + 1) * TileSize, 0, 0)
		cameraRectRaycast.x, cameraRectRaycast.y, cameraRectRaycast.w, cameraRectRaycast.h = x, y, w, h
	end
end

event.updateVisuals.add("updateCameraRectRaycast", "visionRadius", function()
	for entity in ECS.entitiesWithComponents { "Roulette_cameraRectRaycast", "position" } do
		cameraRectRaycastImpl(entity.Roulette_cameraRectRaycast, entity.position)
	end
end)

RouletteCameraLock.CameraMode = Camera.Mode.extend("Roulette_LockToRoom", Enum.data {
	getTargetRect = function(baseWidth, baseHeight)
		local focus = Focus.getAll(Focus.Flag.CAMERA)
		if #focus == 1 and focus[1].Roulette_gambler then
			local judgeEntity = ECS.getEntityByID(focus[1].Roulette_gambler.judge)
			local rect = judgeEntity and RouletteCameraLock.getCameraRectFromEntity(judgeEntity, baseWidth, baseHeight)
			if rect then
				return rect[1], rect[2], rect[3], rect[4]
			end
		end

		return Camera.Mode.data[Camera.Mode.TRACK_LOCAL_PLAYER].getTargetRect(baseWidth, baseHeight)
	end,
})

event.levelLoad.add("cameraModeOverride", "camera", function()
	if RouletteGame.isAnyModeActive() then
		Camera.setModeOverride(RouletteCameraLock.CameraMode)
	end
end)
