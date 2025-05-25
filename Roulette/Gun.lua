local RouletteDelayEvents = require "Roulette.DelayEvents"
local RouletteGame = require "Roulette.Game"
local RouletteGun = {}
local RouletteJudge = require "Roulette.Judge"
local RouletteLocalization = require "Roulette.data.Localization"
local RouletteUtility = require "Roulette.Utility"
local RouletteVisuals = require "Roulette.render.Visuals"

local Action = require "necro.game.system.Action"
local Attack = require "necro.game.character.Attack"
local Color = require "system.utils.Color"
local Damage = require "necro.game.system.Damage"
local Delay = require "necro.game.system.Delay"
local ECS = require "system.game.Entities"
local EntitySelector = require "system.events.EntitySelector"
local Enum = require "system.utils.Enum"
local GrooveChain = require "necro.game.character.GrooveChain"
local Move = require "necro.game.system.Move"
local Random = require "system.utils.Random"
local RNG = require "necro.game.system.RNG"
local Sound = require "necro.audio.Sound"
local TextFormat = require "necro.config.i18n.TextFormat"
local Utilities = require "system.utils.Utilities"

local getEntityByID = ECS.getEntityByID
local getMoveType = Move.getMoveType
local max = math.max
local min = math.min
local type = type

RouletteGun.BulletNameInvalid = RouletteLocalization.Bullet_Invalid

local BulletNameBlank = TextFormat.color(RouletteLocalization.Bullet_Blank, Color.GREEN)
local BulletNameLive = TextFormat.color(RouletteLocalization.Bullet_Live, Color.RED)
RouletteGun.Bullet = Enum.protocol {
	Unknown = Enum.entry(0, {
		name = RouletteGun.BulletNameInvalid,
	}),
	Blank = Enum.entry(1, {
		name = BulletNameBlank,
		continue = true,
	}),
	Live = Enum.entry(2, {
		name = BulletNameLive,
		success = true,
	}),
	UncertainBlank = Enum.entry(3, {
		name = BulletNameBlank,
		continue = true,
	}),
	UncertainLive = Enum.entry(4, {
		name = BulletNameLive,
		success = true,
	}),
}
local BulletData = RouletteGun.Bullet.data
BulletData[RouletteGun.Bullet.Blank].transmute = RouletteGun.Bullet.Live
BulletData[RouletteGun.Bullet.Live].transmute = RouletteGun.Bullet.Blank
BulletData[RouletteGun.Bullet.UncertainBlank].transmute = RouletteGun.Bullet.UncertainLive
BulletData[RouletteGun.Bullet.UncertainLive].transmute = RouletteGun.Bullet.UncertainBlank
BulletData[RouletteGun.Bullet.UncertainBlank].uncertain = RouletteGun.Bullet.Blank
BulletData[RouletteGun.Bullet.UncertainLive].uncertain = RouletteGun.Bullet.Live

function RouletteGun.isBlankBullet(bullet)
	local t = BulletData[bullet]
	return not t.success and t.continue
end

function RouletteGun.isLiveBullet(bullet)
	return not not BulletData[bullet].success
end

function RouletteGun.isUncertainBullet(bullet)
	return not not BulletData[bullet].uncertain
end

--- @param bullet RouletteGun.Bullet
--- @return string
function RouletteGun.getBulletName(bullet)
	local data = BulletData[bullet]
	return data and data.name or RouletteGun.BulletNameInvalid
end

--- @param bullet RouletteGun.Bullet
--- @return RouletteGun.Bullet
function RouletteGun.getBulletTransmuteType(bullet)
	local data = BulletData[bullet]
	return data and data.transmute or bullet
end

--- @param bullet RouletteGun.Bullet
--- @return RouletteGun.Bullet
function RouletteGun.getBulletCertaintifiedType(bullet)
	local data = BulletData[bullet]
	return data and data.uncertain or bullet
end

--- @param bullets RouletteGun.Bullet[]
--- @param index integer
function RouletteGun.certaintifyBullet(bullets, index)
	local bullet = bullets[index]
	if not not BulletData[bullet].uncertain then
		bullet = BulletData[bullet].uncertain
		bullets[index] = bullet
	end
	return bullet
end

--- @param entity Entity
--- @return Entity?
function RouletteGun.getFromGamblerEntity(entity)
	local judge = RouletteJudge.getJudgeFromGamblerEntity(entity)
	local gunEntity = judge and getEntityByID(judge.gun)
	if gunEntity and gunEntity.Roulette_gun then
		return gunEntity
	end
end

local getFromGamblerEntity = RouletteGun.getFromGamblerEntity

--- @param entity Entity
--- @return Component.Roulette_gun?
function RouletteGun.getGunFromGamblerEntity(entity)
	local gunEntity = getFromGamblerEntity(entity)
	if gunEntity then
		return gunEntity.Roulette_gun
	end
end

local getGunFromGamblerEntity = RouletteGun.getGunFromGamblerEntity

local burnGunSelectorFire = EntitySelector.new(event.Roulette_burnGun, {
	"multiply",
	"particle",
}).fire

event.Roulette_burnGun.add("multiply", "multiply", function(ev)
	ev.status.multiplier = ev.status.multiplier * ev.multiplier
end)

--- Burn gun, multiply damage and play particles, but does not play sounds.
--- @param gunEntity Entity
--- @param multiplier number
function RouletteGun.burn(gunEntity, multiplier)
	local status = gunEntity.Roulette_gunStatusBurnt
	if status then
		local ev = {
			gunEntity = gunEntity,
			status = status,
			multiplier = multiplier,
		}
		burnGunSelectorFire(ev, gunEntity.name)
	end
end

event.Roulette_gamblerBeginTurn.add("gunSetGambler", "gun", function(ev)
	local gun = getGunFromGamblerEntity(ev.entity)
	if gun then
		gun.gambler = ev.entity.id
	end
end)

event.Roulette_gamblerEndTurn.add("gunResetGambler", "gun", function(ev)
	local gun = getGunFromGamblerEntity(ev.entity)
	if gun then
		gun.gambler = 0
	end
end)

function RouletteGun.getFromJudgeEntity(entity)
	local gunEntity = entity.Roulette_judge and getEntityByID(entity.Roulette_judge.gun)
	if gunEntity and gunEntity.Roulette_gun then
		return gunEntity
	end
end

local getFromJudgeEntity = RouletteGun.getFromJudgeEntity

function RouletteGun.getGunFromJudgeEntity(entity)
	local gunEntity = getFromJudgeEntity(entity)
	if gunEntity then
		return gunEntity.Roulette_gun
	end
end

local getGunFromJudgeEntity = RouletteGun.getGunFromJudgeEntity

event.Roulette_itemGenerationWeight.add("gunBulletsRequired", {
	filter = "Roulette_itemGenGunBulletsRequired",
	order = "override",
}, function(ev) --- @param ev Event.Roulette_itemGenerationWeight
	local gun = getGunFromJudgeEntity(ev.judgeEntity)
	if gun and #gun.bullets < ev.prototype.Roulette_itemGenGunBulletsRequired.minimum then
		ev.weight = ev.prototype.Roulette_itemGenGunBulletsRequired.weightOverride
	end
end)

local gunResetStatusSelectorFire = EntitySelector.new(event.Roulette_gunResetStatusFields, {
	"damageCombo",
	"damageDouble",
	"burnt",
}).fire

event.Roulette_gunResetStatusFields.add("resetDamageCombo", {
	filter = "Roulette_gunStatusDamageCombo",
	order = "damageCombo",
}, function(ev)
	ev.entity.Roulette_gunStatusDamageCombo.combo = 0
end)

event.Roulette_gunResetStatusFields.add("resetDamageDouble", {
	filter = "Roulette_gunStatusDamageDouble",
	order = "damageDouble",
}, function(ev)
	ev.entity.Roulette_gunStatusDamageDouble.active = false
end)

event.Roulette_gunResetStatusFields.add("resetBurnt", {
	filter = "Roulette_gunStatusBurnt",
	order = "damageDouble",
}, function(ev)
	if ev.isNewRound then
		ev.entity.Roulette_gunStatusBurnt.multiplier = ECS.getEntityPrototype(ev.entity.name).Roulette_gunStatusBurnt.multiplier
	end
end)

--- @param entity Entity
--- @param isNewRound boolean?
function RouletteGun.resetStatus(entity, isNewRound)
	if entity and entity.Roulette_gun then
		--- @class Event.Roulette_gunResetStatusFields
		--- @field entity Entity
		--- @field component Component.Roulette_gun
		--- @field isNewRound boolean
		local ev = {
			entity = entity,
			component = entity.Roulette_gun,
			isNewRound = not not isNewRound,
		}
		gunResetStatusSelectorFire(ev, entity.name)
	end
end

event.Roulette_sequenceGunShot2.add("resetStatus", {
	order = "shot",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_sequenceGunShot
	RouletteGun.resetStatus(ev.entity, false)
end)

event.Roulette_itemUse.add("tellGunBullet", {
	filter = "Roulette_itemUseTellGunBullet",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	if ev.tellBullet then
		return
	end

	local gunEntity = getFromGamblerEntity(ev.user)
	if not gunEntity then
		return
	end

	local judge = RouletteJudge.getJudgeFromGamblerEntity(ev.user)
	local currentTurn = judge and judge.turn or 0

	local component = ev.item.Roulette_itemUseTellGunBullet
	local index = Random.noise3(currentTurn, gunEntity.id, RNG.getDungeonSeed(), #component.indices)
	index = component.indices[index + 1]
	local bullet

	for i = index, component.indices[1], -1 do
		bullet = gunEntity.Roulette_gun.bullets[#gunEntity.Roulette_gun.bullets - i + 1]
		if bullet ~= nil then
			index = i
			break
		end
	end

	if bullet then
		local bulletIndex = #gunEntity.Roulette_gun.bullets - index + 1
		bullet = RouletteGun.certaintifyBullet(gunEntity.Roulette_gun.bullets, bulletIndex)

		ev.tellBullet = {
			bullet = bullet,
			bulletName = RouletteGun.getBulletName(bullet),
			bulletIndex = bulletIndex,
			index = assert(Utilities.arrayFind(component.indices, index)),
		}
	end
end)

event.Roulette_itemUse.add("addGunDamageCombo", {
	filter = "Roulette_itemUseAddGunDamageCombo",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local gunEntity = getFromGamblerEntity(ev.user)
	local component = gunEntity and gunEntity.Roulette_gunStatusDamageCombo
	if component then
		component.combo = component.combo + 1
	end
end)

event.Roulette_itemUse.add("setGunDamageDouble", {
	filter = "Roulette_itemUseSetGunDamageDouble",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local gunEntity = getFromGamblerEntity(ev.user)
	if gunEntity and gunEntity.Roulette_gunStatusDamageDouble then
		gunEntity.Roulette_gunStatusDamageDouble.active = true
	end
end)

--- @param bullets RouletteGun.Bullet[]
--- @param count integer
--- @param records table | true?
--- @return table?
function RouletteGun.transmute(bullets, count, records)
	for i = #bullets, #bullets - count + 1, -1 do
		if bullets[i] == nil then
			break
		end

		local newBullet = RouletteGun.getBulletTransmuteType(bullets[i])
		if newBullet then
			bullets[i] = newBullet

			if records then
				if type(records) ~= "table" then
					records = {}
				end
				records[#records + 1] = { index = i, bullet = newBullet }
			end
		end
	end

	return type(records) == "table" and records or nil
end

event.Roulette_itemUse.add("transmuteGunBullets", {
	filter = "Roulette_itemUseTransmuteBullet",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local gun = getGunFromGamblerEntity(ev.user)
	if gun then
		local component = ev.item.Roulette_itemUseTransmuteBullet
		ev.transmuteBullets = RouletteGun.transmute(gun.bullets, component.count, true)
	end
end)

event.Roulette_itemUse.add("removeGunBullet", {
	filter = "Roulette_itemUseRemoveGunBullet",
	order = "use",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_itemUse
	local gun = getGunFromGamblerEntity(ev.user)
	if gun then
		ev.removeGunBulletPos = #gun.bullets - ev.item.Roulette_itemUseRemoveGunBullet.index + 1
		table.remove(gun.bullets, ev.removeGunBulletPos)

		if #gun.bullets == 0 then
			ev.nextRound = true
		end
	end
end)

local sequenceGunShotSend = RouletteDelayEvents.register("Roulette_sequenceGunShot", {
	"luck",
	"shot",
	"counterAttack",
	"chamber",
	"grooveChain",
	"effect",
	"heal",
	"move",
	"disengage",
	"ai",
	"next",
	"cursor",
	"sound",
}, { -- 1.5s
	.4, -- move
	.4, -- attack
	.3, -- chamber
	.1, -- move back
	.3, -- next turn
}, {
	--- @param entity Entity
	--- @param parameter Event.Roulette_sequenceGunShot.Parameter
	--- @return table
	eventBuilder = function(entity, parameter)
		--- @class Event.Roulette_sequenceGunShot
		--- @field entity Entity @The gun entity.
		--- @field parameter Event.Roulette_sequenceGunShot.Parameter
		--- @field component Component.Roulette_gun
		--- @field user Entity?
		--- @field target Entity?
		--- @field performedAttack? boolean
		local ev = {
			entity = entity,
			parameter = parameter,
			component = entity.Roulette_gun,
			user = getEntityByID(parameter.userID),
			target = getEntityByID(parameter.targetID),
		}
		return ev
	end,
	flags = { unique = true },
})

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot.add("popBullet", "shot", function(ev)
	ev.parameter.bullet = ev.component.bullets[#ev.component.bullets]
	ev.component.bullets[#ev.component.bullets] = nil
end)

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot2.add("updateGrooveChain", "grooveChain", function(ev)
	if ev.user and ev.user.grooveChain and ev.target then
		if ev.target.id == ev.user.id then
			ev.user.grooveChain.killCount = ev.user.grooveChain.killCount + 1
			GrooveChain.increase(ev.user)
		elseif not ev.parameter.success then
			GrooveChain.drop(ev.user, RouletteGame.GrooveChain_Type_ShootingBlank)
		end
	end
end)

event.Roulette_sequenceGunShot.add("moveGun", {
	filter = "position",
	order = "move",
}, function(ev) --- @param ev Event.Roulette_sequenceGunShot
	local position = ev.target.position
	if position then
		local dx, dy = Action.getMovementOffset(Action.rotateDirection(ev.parameter.direction, Action.Rotation.MIRROR))
		dx = dx * 2
		dy = dy * 2
		Move.absolute(ev.entity, position.x + dx, position.y + dy, getMoveType(ev.entity))
	end
end)

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot2.add("updateGamblerDisengage", "disengage", function(ev)
	if ev.user and ev.user.Roulette_gamblerDisengage and ev.target and ev.user.id == ev.target.id then
		if ev.parameter.success then
			if ev.user.Roulette_gamblerDisengage.live then
				ev.user.Roulette_gamblerDisengage.success = true
			end
		else
			if ev.user.Roulette_gamblerDisengage.blank then
				ev.user.Roulette_gamblerDisengage.success = true
			end
		end
	end
end)

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot2.add("performAttack", "shot", function(ev)
	if not ev.parameter.bullet then
		return
	end

	local data = BulletData[ev.parameter.bullet] or RouletteUtility.emptyTable
	ev.parameter.success = data.success

	if not ev.target then
		return
	end

	if data.success and not ev.performedAttack then
		ev.performedAttack = Attack.performInnateAttack(ev.entity, ev.target, false, ev.component.damageMultiplier)
	end

	if ev.parameter.continue == nil and #ev.component.bullets ~= 0 then              -- Undetermined keep turn or not.
		if data.continue and (not ev.user or ev.target.id == ev.user.id) then        -- bullet has `continue` tag, user shoots at self.
			ev.parameter.continue = true
		elseif ev.user.Roulette_gambler and ev.user.Roulette_gambler.extraActions > 0 then -- user has an extra action.
			ev.user.Roulette_gambler.extraActions = ev.user.Roulette_gambler.extraActions - 1
			ev.parameter.continue = true
		end
	end
end)

event.Roulette_sequenceGunShot2.add("soundEmpty", { -- handler name is not well, it should be `soundShot` not `soundEmpty`.
	filter = "Roulette_gunShotSound",
	order = "sound",
}, function(ev)
	if ev.parameter.bullet then
		Sound.playFromEntity(ev.entity.Roulette_gunShotSound.sound, ev.entity, ev.entity.Roulette_gunShotSound.soundData)
	end
end)

event.Roulette_sequenceGunShot3.add("soundChamber", {
	filter = "Roulette_gunChamberSound",
	order = "sound",
}, function(ev)
	if ev.parameter.bullet then
		Sound.playFromEntity(ev.entity.Roulette_gunChamberSound.sound, ev.entity, ev.entity.Roulette_gunChamberSound.soundData)
	end
end)

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot5.add("moveGunToPrevious", "move", function(ev)
	Move.absolute(ev.entity, ev.parameter.x, ev.parameter.y, getMoveType(ev.entity))
end)

event.Roulette_itemCheckUse.add("gun", {
	filter = "Roulette_gun",
	order = "target",
}, function(ev)
	if ev.success == nil then
		ev.success = ev.user.Roulette_gambler
			and ECS.entityExists(ev.user.Roulette_gambler.judge)
			and ev.target.Roulette_gambler
			and ev.user.Roulette_gambler.judge == ev.target.Roulette_gambler.judge
	end
end)

event.Roulette_itemUse.add("gun", {
	filter = { "Roulette_gun", "position" },
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local position = ev.target.position
	if not position then
		return
	end

	--- @class Event.Roulette_sequenceGunShot.Parameter
	--- @field userID Entity.ID
	--- @field targetID Entity.ID
	--- @field x integer
	--- @field y integer
	--- @field direction Action.Direction
	--- @field targetPosition { x: integer, y: integer }
	--- @field success? boolean
	--- @field continue? boolean
	--- @field bullet? RouletteGun.Bullet
	local parameter = {
		userID = ev.user.id,
		targetID = ev.target.id,
		x = ev.item.position.x,
		y = ev.item.position.y,
		direction = Action.getDirection(position.x - ev.item.position.x, position.y - ev.item.position.y),
		targetPosition = { x = position.x, y = position.y },
	}
	sequenceGunShotSend(ev.item, parameter)
end)

RouletteGun.RNGChannel = RNG.Channel.extend "Roulette_Gun"

local gunReloadSelectorFire = EntitySelector.new(event.Roulette_gunReload, {
	"reload",
	"ai",
	"flyaway",
	"text",
	"sound",
}).fire

event.Roulette_gunReload.add("reloadAmounts", {
	filter = { "Roulette_gunReloadAmounts", "random" },
	order = "reload",
}, function(ev) --- @param ev Event.Roulette_gunReload
	local judgeEntity = getEntityByID(ev.component.judge)
	if not judgeEntity or not judgeEntity.Roulette_judge then
		return
	end

	local component = ev.entity.Roulette_gunReloadAmounts
	local amount = component.list[judgeEntity.Roulette_judge.round] or component.list[#component.list]
	if type(amount) == "table" and type(amount[1]) == "number" and type(amount[2]) == "number" then
		amount = RNG.range(amount[1], amount[2], ev.entity)
	elseif type(amount) ~= "number" then
		return
	end
	amount = amount * #judgeEntity.Roulette_judge.gamblers / 2

	local liveAmountPct = RNG.float(component.livePctMax - component.livePctMin, ev.entity) + component.livePctMin
	local liveAmount = max(#judgeEntity.Roulette_judge.gamblers - 1, amount * liveAmountPct)
	for i = 1, amount do
		ev.component.bullets[#ev.component.bullets + 1] = (i <= liveAmount) and component.bulletLive or component.bulletBlank
	end
	RNG.shuffle(ev.component.bullets, ev.entity)

	ev.blanks = 0
	ev.lives = 0
	for _, bullet in ipairs(ev.component.bullets) do
		if RouletteGun.isBlankBullet(bullet) then
			ev.blanks = ev.blanks + 1
		elseif RouletteGun.isLiveBullet(bullet) then
			ev.lives = ev.lives + 1
		end
	end
end)

function RouletteGun.reload(entity)
	if entity.Roulette_gun then
		--- @class Event.Roulette_gunReload
		--- @field entity Entity
		--- @field component Component.Roulette_gun
		--- @field chamberDelay? number
		--- @field blanks? integer
		--- @field lives? integer
		local ev = {
			entity = entity,
			component = entity.Roulette_gun,
		}
		gunReloadSelectorFire(ev, entity.name)
		return ev
	end
end

event.Roulette_sequenceJudgeNextRound1.add("gunReload", "gun", function(ev)
	local gunEntity = getEntityByID(ev.component.gun)
	if gunEntity then
		RouletteGun.resetStatus(gunEntity, true)
		RouletteGun.reload(gunEntity)
	end
end)

PlaySoundLater = Delay.new(function(entity, parameter)
	Sound.playFromEntity(parameter.soundGroup, entity, parameter.soundData)
end)

event.Roulette_gunReload.add("sounds", {
	filter = "Roulette_gunReloadSound",
	order = "sound",
}, function(ev) --- @param ev Event.Roulette_gunReload
	local len = #ev.component.bullets
	local dt = math.min(2 / len, ev.entity.Roulette_gunReloadSound.deltaTime)

	for i = 1, len do
		PlaySoundLater(ev.entity, {
			soundGroup = ev.entity.Roulette_gunReloadSound.sound,
			soundData = ev.entity.Roulette_gunReloadSound.soundData,
		}, (i - 1) * dt)
	end
	ev.chamberDelay = len * dt
end)

event.Roulette_gunReload.add("soundLast", {
	filter = "Roulette_gunChamberSound",
	order = "sound",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_gunReload
	if ev.chamberDelay then
		PlaySoundLater(ev.entity, {
			soundGroup = ev.entity.Roulette_gunChamberSound.sound,
			soundData = ev.entity.Roulette_gunChamberSound.soundData,
		}, ev.chamberDelay)
	end
end)

local gunCalculateDamageSelectorFire = EntitySelector.new(event.Roulette_gunCalculateDamage, {
	"baseIncrease", -- baseIncrease 0
	"userParry",    -- baseIncrease 1
	"drumCombo",    -- baseIncrease 2
	"item",         -- baseIncrease 3
	"bloodDrum",    -- finalMultiplier -3
	"burnt",        -- finalMultiplier -2
	"innateDamage", -- finalMultiplier -1
	"finalMultiplier", -- finalMultiplier 0
	"damageCapacity", -- applyDamage 0
}).fire

--- @param gunEntity Entity
--- @return integer? damage
--- @return Event.Roulette_gunCalculateDamage | Event.ObjectDealDamage ev
function RouletteGun.calculateDamage(gunEntity)
	if gunEntity.Roulette_gun then
		--- @class Event.Roulette_gunCalculateDamage : Event.ObjectDealDamage
		--- @field calculate true
		local ev = {
			damage = gunEntity.Roulette_gun.damageMultiplier,
			direction = Action.Direction.NONE,
			entity = gunEntity,
			type = gunEntity.innateAttack.type,
			victim = gunEntity,
			calculate = true,
		}
		gunCalculateDamageSelectorFire(ev, gunEntity.name)
		return ev.damage, ev
	end
	return nil, RouletteUtility.emptyTable
end

--- Well this function is pending to be depreciated.
--- @param name string
--- @param args any
--- @param _ nil
--- @param func fun(ev: Event.Roulette_gunCalculateDamage | Event.ObjectDealDamage)
function RouletteGun.damageEventRegister(name, args, _, func)
	event.Roulette_gunCalculateDamage.add(name, args, func)
end

event.objectDealDamage.add("gunOverrideDamage", {
	filter = "Roulette_gun",
	order = "baseMultiplier",
}, function(ev) --- @param ev Event.ObjectDealDamage
	ev.damage = RouletteGun.calculateDamage(ev.entity) or ev.damage
end)

event.objectDealDamage.add("gunBurntDamageType", {
	filter = { "Roulette_gun", "Roulette_gunStatusBurnt" },
	order = "baseMultiplier",
	sequence = 1,
}, function(ev) --- @param ev Event.ObjectDealDamage
	if ev.entity.Roulette_gunStatusBurnt.multiplier > 0 then
		ev.type = Damage.Flag.mask(ev.type, Damage.Flag.FIRE)
	end
end)

event.objectDealDamage.add("gunSetKillerName", {
	filter = "Roulette_gun",
	order = "target",
}, function(ev)
	local gamblerEntity = ECS.getEntityByID(ev.entity.Roulette_gun.gambler)
	if gamblerEntity then
		if gamblerEntity.Roulette_enemy and gamblerEntity.friendlyName then
			ev.killerName = gamblerEntity.friendlyName.name or gamblerEntity.name
		else
			ev.killerName = RouletteVisuals.getEntityDisplayName(gamblerEntity)
		end
	end
end)

for _, entry in ipairs {
	{
		name = "applyGunUserParryDamageIncrement",
		args = {
			filter = "Roulette_gun",
			order = "userParry",
		},
		vanillaArgs = {
			filter = "Roulette_gun",
			order = "baseIncrease",
			sequence = 1,
		},
		func = function(ev) --- @param ev Event.Roulette_gunCalculateDamage
			local gun = ev.entity.Roulette_gun
			local userEntity = ECS.getEntityByID(gun and gun.gambler)
			if userEntity and userEntity.Roulette_gamblerParry and userEntity.Roulette_gamblerParry.active then
				ev.damage = ev.damage + userEntity.Roulette_gamblerParry.damageUp
			end
		end,
	},
	{
		name = "applyGunDamageComboIncrement",
		args = {
			filter = "Roulette_gunStatusDamageCombo",
			order = "drumCombo",
		},
		vanillaArgs = {
			filter = "Roulette_gunStatusDamageCombo",
			order = "baseIncrease",
			sequence = 2,
		},
		func = function(ev) --- @param ev Event.Roulette_gunCalculateDamage
			local component = ev.entity.Roulette_gunStatusDamageCombo
			if component.combo > 0 then
				ev.damage = ev.damage + Utilities.lowerBound(component.damages, component.combo)
			end
		end,
	},
	{
		name = "applyGunDamageDoubleMultiplier",
		args = {
			filter = "Roulette_gunStatusDamageDouble",
			order = "bloodDrum",
		},
		vanillaArgs = {
			filter = "Roulette_gunStatusDamageDouble",
			order = "finalMultiplier",
			sequence = -3,
		},
		func = function(ev) --- @param ev Event.Roulette_gunCalculateDamage
			if ev.entity.Roulette_gunStatusDamageDouble.active then
				ev.damage = ev.damage * 2
			end
		end,
	},
	{
		name = "applyGunRogueBurntMultiplier",
		args = {
			filter = "Roulette_gunStatusBurnt",
			order = "burnt",
		},
		vanillaArgs = {
			filter = "Roulette_gunStatusBurnt",
			order = "finalMultiplier",
			sequence = -2,
		},
		func = function(ev) --- @param ev Event.Roulette_gunCalculateDamage
			ev.damage = ev.damage * ev.entity.Roulette_gunStatusBurnt.multiplier
		end,
	},
	{
		name = "damageCapacity",
		args = "damageCapacity",
		vanillaArgs = "applyDamage",
		func = function(ev)
			ev.damage = min(ev.damage, 999)
		end
	},
} do
	RouletteGun.damageEventRegister(entry.name, entry.args, entry.vanillaArgs, entry.func)
end

return RouletteGun
