local RouletteParticles = {}

local AnimationTimer = require "necro.render.AnimationTimer"
local Collision = require "necro.game.tile.Collision"
local Color = require "system.utils.Color"
local RenderTimestep = require "necro.render.RenderTimestep"
local ECS = require "system.game.Entities"
local GFX = require "system.gfx.GFX"
local Player = require "necro.game.character.Player"
local Particle = require "necro.game.system.Particle"
local ParticleRenderer = require "necro.render.level.ParticleRenderer"
local Random = require "system.utils.Random"
local Render = require "necro.render.Render"
local Utilities = require "system.utils.Utilities"
local VertexAnimation = require "system.gfx.VertexAnimation"

local Collision_Type_Wall = Collision.Type.WALL
local Color_Black = Color.BLACK
local HalfTileSize = Render.TILE_SIZE / 2
local InvTileSize = 1 / Render.TILE_SIZE
local TileSize = Render.TILE_SIZE
local checkCollision = Collision.check
local cos = math.cos
local buffer = Render.getBuffer(Render.Buffer.PARTICLE)
local fade = Color.fade
local float3 = Random.float3
local floor = math.floor
local fmod = math.fmod
local max = math.max
local min = math.min
local opacity = Color.opacity
local pi2 = math.pi * 2
local lerp = Utilities.lerp
local sin = math.sin
local sqrt = math.sqrt
local tau = math.pi * 2
local tileCenter = Render.tileCenter
local transientLinearFreezable = VertexAnimation.transientLinearFreezable

local function processParticleShell(ev)
	ev.Roulette_shells = ev.Roulette_shells or {}
	local shells = ev.Roulette_shells

	local bounciness = tonumber(ev.bounciness) or 1
	local centerX, centerY = tileCenter(ev.x, ev.y)
	local gravity = tonumber(ev.gravity) or 0
	local hh = GFX.getImageHeight(ev.texture) / 2
	local hw = GFX.getImageWidth(ev.texture) / 2
	local id = ev.id
	local smoothness = tonumber(ev.smoothness) or 1
	local turnID = ev.turnID
	local enableVertexAnimation = Player.isAlone()

	local draw = buffer.draw
	local drawArgs = {
		rect = { 0, 0 },
		texture = ev.texture,
		color = Color.WHITE,
		angle = 0,
		origin = { hw, hh },
	}
	local drawArgsRect = drawArgs.rect

	for i = 1, ev.particleCount do
		local shell = shells[i]
		if not shell then
			local w, h = GFX.getImageSize(ev.texture)
			local v = tonumber(ev.velocity) or 0
			local s = bit.bxor(turnID, id)
			local t = float3(0, i, s)

			shell = {
				t = ev.time,
				a = 0,
				x = centerX - w / 2,
				y = centerY - h / 2,
				z = h + HalfTileSize,
				vx = max(t - 0, float3(1, i, s)) * (float3(4, i, s) < .5 and 1 or -1) * v,
				vy = max(1 - t, float3(2, i, s)) * (float3(5, i, s) > .5 and 1 or -1) * v,
				vz = max(.5, float3(3, i, s) + .25) * v,
			}
			shells[i] = shell
		elseif not shell.fixed then
			local dt = min(ev.time - shell.t, .1)
			shell.t = ev.time
			shell.vz = shell.vz - gravity * dt
			shell.x = shell.x + shell.vx * dt
			if checkCollision(floor(shell.x * InvTileSize + .5), floor(shell.y * InvTileSize + .5), Collision_Type_Wall) then
				shell.x = shell.x - shell.vx * dt
				shell.vx = -shell.vx * bounciness
			end
			shell.y = shell.y + shell.vy * dt
			if checkCollision(floor(shell.x * InvTileSize + .5), floor(shell.y * InvTileSize + .5), Collision_Type_Wall) then
				shell.y = shell.y - shell.vy * dt
				shell.vy = -shell.vy * bounciness
			end
			shell.z = shell.z + shell.vz * dt
			if shell.z < 0 then
				shell.z = -shell.z * bounciness
				shell.vx = shell.vx * smoothness
				shell.vy = shell.vy * smoothness
				shell.vz = -shell.vz * bounciness
			end
			shell.a = fmod(shell.a + sqrt(shell.vx * shell.vx + shell.vy * shell.vy) * (float3(turnID, i, id) > .5 and 1 or -1) * dt, pi2)

			local gv = sqrt(shell.vx * shell.vx + shell.vy * shell.vy + shell.vz * shell.vz)
			if gv < .1 then
				shell.fixed = true
			end
		end

		local alpha = min(ev.duration - ev.time, 1)
		drawArgsRect[1] = shell.x - hw
		drawArgsRect[2] = shell.y - hh - shell.z
		if enableVertexAnimation then
			drawArgs.anim = transientLinearFreezable(floor(drawArgsRect[1] + .5), floor(drawArgsRect[2] + .5), 0.3)
		else
			drawArgs.anim = 0
		end
		drawArgs.angle = shell.a
		drawArgs.color = opacity(alpha)
		drawArgs.z = drawArgsRect[2] - TileSize
		draw(drawArgs)

		drawArgsRect[2] = shell.y - hh + 1
		local maxHeight = 24
		if enableVertexAnimation then
			drawArgs.anim = transientLinearFreezable(floor(drawArgsRect[1] + .5), floor(drawArgsRect[2] + .5), 0.3)
		else
			drawArgs.anim = 0
		end
		drawArgs.color = fade(Color_Black, min(min(maxHeight - shell.z, maxHeight) / maxHeight, alpha, .75))
		drawArgs.z = drawArgs.z - .1
		draw(drawArgs)
	end
end

local processParticleShellErrorMessage

event.particle.add("particleShell", "Roulette_particleShell", function(ev)
	local success, errMsg = pcall(processParticleShell, ev)
	if not success and not processParticleShellErrorMessage then
		processParticleShellErrorMessage = errMsg
	end
end)

event.render.add("particleShellError", "overlayBack", function()
	if processParticleShellErrorMessage then
		local errMsg = processParticleShellErrorMessage
		processParticleShellErrorMessage = nil
		error(errMsg)
	end
end)

event.Roulette_sequenceGunShot3.add("playParticle", {
	filter = { "Roulette_gunShotParticle", "position" },
	order = "chamber",
}, function(ev) --- @param ev Event.Roulette_sequenceGunShot
	local p = ev.entity.Roulette_gunShotParticle

	Particle.playFromTable {
		bounciness = .85,
		duration = 15,
		gravity = 360,
		id = ev.entity.id,
		particleCount = 1,
		smoothness = .5,
		texture = ev.parameter.success and p.textureLive or p.textureBlank,
		type = "Roulette_particleShell",
		velocity = p.velocity,
		x = ev.entity.position.x,
		y = ev.entity.position.y,
	}
end)

local charmRingsTimers = {}

event.objectDelete.add("removeFromCharmRingsTimers", "effects", function(ev)
	charmRingsTimers[ev.entity.id] = nil
end)

event.gameStateLevel.add("resetCharmRingsTimers", "resetLevelVariables", function()
	charmRingsTimers = {}
end)

event.render.add("renderGamblerCharmRings", "particlesFront", function()
	local draw = buffer.draw
	local drawArgs = {
		texture = "mods/Roulette/gfx/particle_charm.png",
		rect = { 0, 0 },
		color = -1,
		z = 0,
	}
	local deltaTime = RenderTimestep.getDeltaTime()
	local time = AnimationTimer.getTime()
	local offsetX = -2.5
	local offsetY = 2
	local particleCount = 8
	local radiusX = 10
	local radiusY = 4
	local rotationPeriod = 3.5

	for entity in ECS.entitiesWithComponents { "Roulette_gambler", "Roulette_gamblerCharmable", "visibility" } do
		local id = entity.id
		local charmed = entity.Roulette_gamblerCharmable.turns > 0

		if charmed then
			charmRingsTimers[id] = (charmRingsTimers[id] or 0) + deltaTime
		elseif charmRingsTimers[id] then
			if charmRingsTimers[id] > 0 then
				charmRingsTimers[id] = math.min(charmRingsTimers[id], 1) - deltaTime
			else
				charmRingsTimers[id] = nil
			end
		end

		if entity.visibility.visible and entity.sprite.visible and charmRingsTimers[id] then
			local factor = min(charmRingsTimers[id] * 2, 1)
			local sprite = entity.sprite
			local centerX = sprite.x + offsetX + (sprite.width + sprite.mirrorOffsetX * sprite.mirrorX) * 0.5
			local centerY = sprite.y + offsetY - (sprite.height * 0.5 + sprite.originY) * (sprite.scale - 1)
			local zOff = entity.rowOrder.z + 7

			for i = 1, particleCount do
				local angle = (time / rotationPeriod + i / particleCount) * tau
				drawArgs.rect[1] = centerX + cos(angle) * lerp(0, radiusX, factor)
				drawArgs.rect[2] = centerY + sin(angle) * lerp(0, radiusY, factor)
				drawArgs.z = drawArgs.rect[2] + zOff
				drawArgs.color = entity.Roulette_gamblerCharmable.color
				draw(drawArgs)
			end
		end
	end
end)

event.particle.add("gamblerFreezeParticle", "Roulette_gamblerFreezeParticle", ParticleRenderer.initStatefulParticles)
event.particle.add("gunBurntParticle", "Roulette_gunBurntParticle", ParticleRenderer.initStatefulParticles)

charmRingsTimers = script.persist(function()
	return charmRingsTimers
end)

return RouletteParticles
