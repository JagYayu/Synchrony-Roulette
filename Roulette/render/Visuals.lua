local RouletteGambler = require "Roulette.Gambler"
local RouletteGame = require "Roulette.Game"
local RouletteGun = require "Roulette.Gun"
local RouletteJudge = require "Roulette.Judge"
local RouletteRogue = require "Roulette.Rogue"
local RouletteRenderUITexts = require "Roulette.render.UITexts"
local RouletteUtility = require "Roulette.Utility"
local RouletteVisuals = {}

local Action = require "necro.game.system.Action"
local Color = require "system.utils.Color"
local ECS = require "system.game.Entities"
local EntitySelector = require "system.events.EntitySelector"
local Focus = require "necro.game.character.Focus"
local Flyaway = require "necro.game.system.Flyaway"
local MoveAnimations = require "necro.render.level.MoveAnimations"
local Particle = require "necro.game.system.Particle"
local PlayerList = require "necro.client.PlayerList"
local Settings = require "necro.config.Settings"
local SettingsStorage = require "necro.config.SettingsStorage"
local TextFormat = require "necro.config.i18n.TextFormat"
local Turn = require "necro.cycles.Turn"
local Utilities = require "system.utils.Utilities"

local addTextOverlay = RouletteRenderUITexts.addTextOverlay

--#region Display Name

local entityDisplayNameSelectorFire = EntitySelector.new(event.Roulette_entityDisplayName, {
	"aiName",
	"playerName",
	"friendlyName",
	"default",
	"color",
}).fire

event.Roulette_entityDisplayName.add("aiNickname", {
	filter = "Roulette_aiGamblerNickname",
	order = "aiName",
}, function(ev)
	if not ev.name and ev.entity.Roulette_aiGamblerNickname.name ~= "" then
		ev.name = ev.entity.Roulette_aiGamblerNickname.name
	end
end)

event.Roulette_entityDisplayName.add("playerName", {
	filter = "controllable",
	order = "playerName"
}, function(ev)
	if not ev.name then
		ev.name = PlayerList.getName(ev.entity.controllable.playerID)
	end
end)

event.Roulette_entityDisplayName.add("default", "default", function(ev)
	if not ev.name then
		ev.name = ("%s#%s"):format(ev.entity.name, ev.entity.id)
	end
end)

event.Roulette_entityDisplayName.add("friendlyName", {
	filter = "friendlyName",
	order = "friendlyName",
}, function(ev)
	if not ev.name then
		ev.name = ev.entity.friendlyName.name
	end
end)

event.Roulette_entityDisplayName.add("gamblerColoring", {
	filter = { "Roulette_gambler", "Roulette_gamblerColor" },
	order = "color",
}, function(ev)
	if ev.name and ev.entity.Roulette_gambler.judge then
		ev.name = TextFormat.color(ev.name, ev.entity.Roulette_gamblerColor.color)
	end
end)

function RouletteVisuals.getEntityDisplayName(entity)
	--- @class Event.Roulette_entityDisplayName
	--- @field entity Entity
	--- @field name? string
	local ev = {
		entity = entity,
	}
	entityDisplayNameSelectorFire(ev, entity.name)
	return ev.name or ""
end

--#endregion

--#region Gun

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot1.add("enableGamblerVibrateEffect", "effect", function(ev)
	if ev.target.Roulette_gamblerVibrateEffect then
		ev.target.Roulette_gamblerVibrateEffect.active = true
	end
end)

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot2.add("disableGamblerVibrateEffect", "effect", function(ev)
	if ev.target.Roulette_gamblerVibrateEffect then
		ev.target.Roulette_gamblerVibrateEffect.active = false
	end
end)

event.Roulette_gunReload.add("reloadFlyaway", {
	filter = "Roulette_gunReloadFlyaway",
	order = "flyaway",
}, function(ev)
	if ev.blanks and ev.lives then
		local component = ev.entity.Roulette_gunReloadFlyaway
		local parameters = Utilities.fastCopy(component.parameters)
		parameters.entity = ev.entity
		parameters.text = component.format:format(ev.lives, ev.blanks)
		Flyaway.create(parameters)
	end
end)

event.Roulette_gunReload.add("reloadFlyawayOverlayText", {
	filter = "Roulette_gunReloadFlyawayOverlayText",
	order = "text",
}, function(ev) ---@param ev Event.Roulette_gunReload
	if ev.blanks and ev.lives then
		local judgeEntity = ECS.getEntityByID(ev.component.judge)
		if judgeEntity then
			local text = ev.entity.Roulette_gunReloadFlyaway.format:format(ev.lives, ev.blanks)
			for _, entity in ipairs(RouletteUtility.getEntitiesFromIDs(judgeEntity.Roulette_judge.gamblers)) do
				addTextOverlay(entity, text, ev.entity.Roulette_gunReloadFlyawayOverlayText.duration)
			end
		end
	end
end)

event.Roulette_itemUse.add("tellGunBulletFlyaway", {
	filter = "Roulette_itemUseTellGunBulletFlyaway",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local component = ev.item.Roulette_itemUseTellGunBulletFlyaway

	local parameters = Utilities.fastCopy(component.parameters)
	parameters.text = component.fallback
	parameters.entity = ev.user

	if ev.tellBullet and ev.tellBullet.bulletName then
		parameters.text = component.format:format(component.texts[ev.tellBullet.index], ev.tellBullet.bulletName)

		if component.focusedOnly and not (parameters.entity and Focus.check(parameters.entity, Focus.Flag.FLYAWAY)) then
			parameters.text = RouletteUtility.encodeString(parameters.text)
		end
	end

	parameters.entity = RouletteGun.getFromGamblerEntity(ev.user) or parameters.entity
	Flyaway.create(parameters)
end)

event.objectRoulette_gamblerFreeze.add("playParticle", {
	filter = "Roulette_gamblerFreezeParticle",
	order = "particle",
}, function(ev) --- @param ev Event.Roulette_gamblerFreeze
	Particle.play(ev.entity, "Roulette_gamblerFreezeParticle", {
		particleCount = ev.entity.Roulette_gamblerFreezeParticle.baseParticleCount * (ev.turns + 1)
	})
end)

event.Roulette_burnGun.add("playParticle", {
	filter = "Roulette_gunBurntParticle",
	order = "particle",
}, function(ev)
	Particle.play(ev.gunEntity, "Roulette_gunBurntParticle")
end)

event.Roulette_itemUse.add("playParticle", {
	filter = "Roulette_itemUseParticle",
	order = "effect",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local targetEntity = ev[ev.item.Roulette_itemUseParticle.evTarget]
	if type(targetEntity) == "table" and ECS.isValidEntityType(targetEntity.name) and ECS.entityExists(targetEntity.id) then
		local params = Utilities.deepCopy(ev.item.Roulette_itemUseParticle)

		params.id = targetEntity.id
		params.x = targetEntity.position and targetEntity.position.x
		params.y = targetEntity.position and targetEntity.position.y

		Particle.playFromTable(params)
	end
end)

event.swipe.add("gun", "Roulette_gun", function(ev)
	ev.swipe.texture = "ext/swipes/swipe_blunderbuss.png"
	ev.swipe.frameCount = 8
	ev.swipe.width = 88
	ev.swipe.height = 109
	ev.swipe.offsetY = ev.swipe.mirrorY and 5 or -5
	ev.swipe.offsetX = -22
end)

event.swipe.add("plasmaCannon", "Roulette_plasmaCannon", function(ev)
	ev.swipe.texture = "mods/Roulette/gfx/swipe_plasma_cannon.png"
	ev.swipe.frameCount = 8
	ev.swipe.width = 88
	ev.swipe.height = 109
	ev.swipe.offsetY = ev.swipe.mirrorY and 5 or -5
	ev.swipe.offsetX = -22
end)

--#endregion

--#region Gambler

event.objectTakeDamage.add("gamblerBounceTween", {
	filter = { "Roulette_gambler", "movable", "tween" },
	order = "tween",
	sequence = 100,
}, function(ev)
	if not (ev.suppressed or ev.shielded or ev.damage <= 0 or ev.entity.tween.turnID == -1)
		and RouletteGambler.isGambling(ev.entity.Roulette_gambler)
		and Turn.getTurnTimestamp(Turn.getCurrentTurnID() - ev.entity.tween.turnID) > ev.entity.tween.duration
	then
		local x, y = ev.entity.position.x, ev.entity.position.y
		local dx, dy = Action.getMovementOffset(ev.direction)
		MoveAnimations.play(ev.entity, ev.damage > 2 and MoveAnimations.Type.BOUNCE or MoveAnimations.Type.BOUNCE_FLAT, x + dx, y + dy)
	end
end)

event.gameStateLevel.add("resetTextOverlays", "resetLevelVariables", function()
	for entity in ECS.entitiesWithComponents { "Roulette_textOverlay" } do
		entity.Roulette_textOverlay.lines = {}
	end
end)

event.Roulette_gamblerBeginTurn.add("createText", {
	filter = "Roulette_gamblerTextBeginTurn",
	order = "hud",
}, function(ev) --- @param ev Event.Roulette_gamblerBeginTurn
	if ev.suppressed then
		return
	end

	local component = ev.entity.Roulette_gamblerTextBeginTurn
	local text = component.format:format(RouletteVisuals.getEntityDisplayName(ev.entity))
	for _, entity in ipairs(Focus.getAll()) do
		if entity.Roulette_gambler and entity.Roulette_gambler.judge == ev.component.judge then
			addTextOverlay(entity, entity.id == ev.entity.id and component.text or text, component.duration)
		end
	end

	local judgeEntity = RouletteJudge.getFromGamblerEntity(ev.entity)
	if judgeEntity then
		local parameters = Utilities.fastCopy(component.parameters)
		parameters.entity = judgeEntity
		parameters.text = text
		Flyaway.create(parameters)
	end
end)

event.objectHeal.add("rogueModePlayHealParticles", {
	filter = { "Roulette_rogueParticleHeal", "!particlePuff" },
	order = "particles",
}, function(ev)
	if RouletteRogue.isModeActive() then
		Particle.play(ev.entity, "Roulette_rogueParticleHeal", { type = "particlePuff" })
	end
end)

event.Roulette_gamblerEndTurn.add("createText", {
	filter = "Roulette_gamblerTextEndTurn",
	order = "text",
}, function(ev) --- @param ev Event.Roulette_gamblerEndTurn
	local component = ev.entity.Roulette_gamblerTextEndTurn
	local text = component.text
	if Focus.check(ev.entity) then
		addTextOverlay(ev.entity, text, component.duration)
	end

	local judgeEntity = RouletteJudge.getFromGamblerEntity(ev.entity)
	if judgeEntity then
		local parameters = Utilities.fastCopy(component.parameters)
		parameters.entity = judgeEntity
		parameters.text = text
		Flyaway.create(parameters)
	end
end)

RouletteVisuals.PlayerGamblerColors = {
	Color.hsv(0 / 8, .5, 1, 1),
	Color.hsv(1 / 8, .5, 1, 1),
	Color.hsv(2 / 8, .5, 1, 1),
	Color.hsv(3 / 8, .5, 1, 1),
	Color.hsv(4 / 8, .5, 1, 1),
	Color.hsv(5 / 8, .5, 1, 1),
	Color.hsv(6 / 8, .5, 1, 1),
	Color.hsv(7 / 8, .5, 1, 1),
}

function RouletteVisuals.getPlayerGamblerColor(playerID)
	local list = RouletteVisuals.PlayerGamblerColors
	return list[(playerID - 1) % #list + 1]
end

event.visibility.add("silhouettedGamblerHideHealthBar", {
	order = "healthBarVisibility",
	sequence = 300,
}, function()
	for entity in ECS.entitiesWithComponents { "Roulette_gambler", "healthBar", "silhouette" } do
		if entity.healthBar.visible and entity.silhouette.active and RouletteGambler.isGambling(entity.Roulette_gambler) then
			entity.healthBar.visible = false
		end
	end
end)

--#endregion

--#region Judge

event.Roulette_judgeEndGame.add("createFlyaway", {
	filter = { "Roulette_judgeFlyawayEndGame", "position" },
	order = "flyaway",
}, function(ev)
	if ev.winner then
		local winnerName = RouletteVisuals.getEntityDisplayName(ev.winner)
		Flyaway.create {
			text = ev.entity.Roulette_judgeFlyawayEndGame.format:format(winnerName),
			entity = ev.entity,
		}
	end
end)

event.Roulette_sequenceJudgeNextRound.add("createFlyaway", {
	filter = "Roulette_judgeFlyawayNextRound",
	order = "flyaway",
}, function(ev) --- @param ev Event.Roulette_sequenceJudgeNextRound
	local component = ev.entity.Roulette_judgeFlyawayNextRound
	local parameters = Utilities.fastCopy(component.parameters)
	parameters.entity = ev.entity
	parameters.text = component.format:format(ev.component.round)
	Flyaway.create(parameters)
end)

--#endregion

event.gameStateLevel.add("overrideEnemyHealthBarSetting", {
	order = "resetSettings",
	sequence = 1,
}, function()
	SettingsStorage.set("video.alwaysShowEnemyHearts", RouletteGame.isAnyModeActive() and true or nil, Settings.Layer.SCRIPT_OVERRIDE)
end)

return RouletteVisuals
