local RouletteAI = {}
local RouletteCursor = require "Roulette.Cursor"
local RouletteGambler = require "Roulette.Gambler"
local RouletteGun = require "Roulette.Gun"
local RouletteItem = require "Roulette.Item"
local RouletteJudge = require "Roulette.Judge"
local RouletteUtility = require "Roulette.Utility"

local Delay = require "necro.game.system.Delay"
local ECS = require "system.game.Entities"
local EntitySelector = require "system.events.EntitySelector"
local RNG = require "necro.game.system.RNG"
local Tile = require "necro.game.tile.Tile"
local Turn = require "necro.cycles.Turn"
local Utilities = require "system.utils.Utilities"

local getEntityByID = ECS.getEntityByID
local reduceCoordinates = Tile.reduceCoordinates
local unwrapCoordinates = Tile.unwrapCoordinates

--#region AI Gambler Decision

local aiGamblerDecisionSelectorFire = EntitySelector.new(event.Roulette_aiGamblerDecision, {
	"items",
	"target",
	"decision",
}).fire

--#region Filter Item

local aiGamblerFilterItemSelectorFire = EntitySelector.new(event.Roulette_aiGamblerFilterItem, {
	"all",
}).fire

event.Roulette_aiGamblerFilterItem.add("noPosition", {
	filter = "!position",
	order = "all",
}, function(ev) --- @param ev Event.Roulette_aiGamblerFilterItem
	ev.filtered = true
end)

event.Roulette_aiGamblerFilterItem.add("itemUseDamageUser", {
	filter = "Roulette_itemUseDamageUser",
	order = "all",
}, function(ev) --- @param ev Event.Roulette_aiGamblerFilterItem
	if not ev.filtered and ev.parentEv.entity.health and ev.parentEv.entity.health.health <= ev.entity.Roulette_itemUseDamageUser.damage then
		ev.filtered = true
	end
end)

event.Roulette_aiGamblerFilterItem.add("conditionalDamageLater", {
	filter = "Roulette_itemUseConditionalDamageLater",
	order = "all",
}, function(ev) --- @param ev Event.Roulette_aiGamblerFilterItem
	if not ev.filtered and ev.parentEv.entity.health then
		local component = ev.entity.Roulette_itemUseConditionalDamageLater
		local health = ev.parentEv.entity.health.health

		if ev.entity.Roulette_itemUseHeal then
			health = health + ev.entity.Roulette_itemUseHeal.health
		end

		if health - component.damage <= 0 then
			ev.filtered = not RNG.roll(component.chance, ev.parentEv.entity)
		end
	end
end)

event.Roulette_aiGamblerFilterItem.add("aiUseItemOnce", {
	filter = "Roulette_itemTagAIUseLimit",
	order = "all",
}, function(ev) --- @param ev Event.Roulette_aiGamblerFilterItem
	if not ev.filtered then
		local component = ev.entity.Roulette_itemTagAIUseLimit
		if component.key ~= "" and (ev.parentEv.aiComponent.usedItems[component.key] or 0) >= component.times then
			ev.filtered = true
		end
	end
end)

--- @param parentEv Event.Roulette_aiGambler
--- @param itemEntity Entity
--- @return boolean
local function tryFilter(parentEv, itemEntity)
	--- @class Event.Roulette_aiGamblerFilterItem
	--- @field filtered boolean
	--- @field parentEv Event.Roulette_aiGambler
	local ev = {
		entity = itemEntity,
		filtered = false,
		parentEv = parentEv,
	}
	aiGamblerFilterItemSelectorFire(ev, itemEntity.name)
	return ev.filtered
end

--#endregion

--- @param ev Event.Roulette_aiGambler
event.Roulette_aiGamblerDecision.add("collectItems", "items", function(ev)
	if not ev.items then
		ev.items = {}

		for entity in ECS.entitiesWithComponents { "Roulette_item", "Roulette_selectable" } do
			if entity.Roulette_selectable.belonging == ev.entity.id and not tryFilter(ev, entity) then
				ev.items[#ev.items + 1] = entity
			end
		end

		RNG.shuffle(ev.items, ev.entity)
	end
end)

event.Roulette_aiGamblerDecision.add("removeCollectItemsIfSilenced", {
	filter = "Roulette_gamblerStatusSilence",
	order = "items",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_aiGambler
	if ev.items and RouletteGambler.isSilenced(ev.entity) then
		ev.items = nil
	end
end)

--- @param ev Event.Roulette_aiGambler
event.Roulette_aiGamblerDecision.add("selectTargetOpponent", "target", function(ev)
	if ev.opponent then
		return
	end

	-- select opponent gambler that has higher priority.
	-- default -> 1 ~ 10
	-- health -> 100, 50%&health<=2 -> *2
	-- maxHealth -> 1
	-- item -> 30
	local targets = {}
	for _, entityID in ipairs(ev.judgeComponent.gamblers) do
		if entityID ~= ev.entity.id then
			local entity = getEntityByID(entityID)
			if entity then
				local priority = RNG.int(10, ev.entity)
				local multiply = 1

				if entity.health then
					priority = priority + entity.health.health * 100 + entity.health.maxHealth

					if entity.health.health <= 2 and RNG.roll(.5, ev.entity) then
						multiply = multiply + 1
					end
				end

				for itemEntity in ECS.entitiesWithComponents { "Roulette_selectable", "Roulette_item" } do
					if itemEntity.Roulette_selectable.belonging == entity.id then
						priority = priority + 30
					end
				end

				targets[#targets + 1] = {
					priority = priority * multiply,
					entity = entity,
				}
			end
		end
	end

	if targets[2] then
		table.sort(targets, function(l, r)
			if l.priority ~= r.priority then
				return l.priority > r.priority
			else
				return l.entity.id < r.entity.id
			end
		end)
	end

	if targets[1] then
		ev.opponent = targets[1].entity
	end
end)

--#region Item Using Target

local aiGamblerItemUsingTargetSelectorFire = EntitySelector.new(event.Roulette_aiGamblerItemUsingTarget, {
	"all",
}).fire

event.Roulette_aiGamblerItemUsingTarget.add("targetSelf", {
	filter = "Roulette_itemUseOnSelf",
	order = "all",
}, function(ev) --- @param ev Event.Roulette_aiGamblerItemUsingTarget
	if not ev.target then
		ev.target = ev.parentEv.entity
	end
end)

event.Roulette_aiGamblerItemUsingTarget.add("targetGun", {
	filter = "Roulette_itemUseOnGun",
	order = "all",
}, function(ev) --- @param ev Event.Roulette_aiGamblerItemUsingTarget
	if not ev.target then
		ev.target = ev.parentEv.gunEntity
	end
end)

event.Roulette_aiGamblerItemUsingTarget.add("targetOpponent", {
	filter = "Roulette_itemUseOnOpponent",
	order = "all",
}, function(ev) --- @param ev Event.Roulette_aiGamblerItemUsingTarget
	if not ev.target then
		ev.target = ev.parentEv.opponent
	end
end)

event.Roulette_aiGamblerItemUsingTarget.add("targetOpponentItem", {
	filter = "Roulette_itemUseOnOpponentItem",
	order = "all",
}, function(ev) --- @param ev Event.Roulette_aiGamblerItemUsingTarget
	if not ev.target and ev.parentEv.opponent then
		local targets = {}
		for entity in ECS.entitiesWithComponents { "Roulette_selectable", "Roulette_item" } do
			if entity.Roulette_selectable.belonging == ev.parentEv.opponent.id then
				targets[#targets + 1] = entity
			end
		end

		ev.target = RNG.choice(targets, ev.parentEv.entity)
	end
end)

local function getUsingTarget(itemEntity, parentEv)
	--- @class Event.Roulette_aiGamblerItemUsingTarget
	--- @field entity Entity
	--- @field parentEv Event.Roulette_aiGambler | Event.Roulette_rogueAIGamblerPlan
	--- @field target Entity?
	local ev = {
		entity = itemEntity,
		parentEv = parentEv,
		target = nil,
	}
	aiGamblerItemUsingTargetSelectorFire(ev, itemEntity.name)
	return ev.target
end

--#endregion

event.Roulette_aiGamblerDecision.add("makeDecision", {
	filter = "health",
	order = "decision",
}, function(ev) --- @param ev Event.Roulette_aiGambler
	--- @type Entity[]
	local itemEntities = ev.items or RouletteUtility.emptyTable
	local function popItem(componentName)
		for index, entity in ipairs(itemEntities) do
			if entity:hasComponent(componentName) then
				table.remove(itemEntities, index)
				return entity
			end
		end
	end

	local itemControl = popItem "Roulette_itemTagControl"
	local itemDefensive = popItem "Roulette_itemTagDefensive"
	local itemHeal = popItem "Roulette_itemTagHeal"
	local itemOffensive = popItem "Roulette_itemTagOffensive"
	local itemMisc = popItem "Roulette_itemTagMisc"
	local itemRetreat = popItem "Roulette_itemTagRetreat"
	local itemSteal = popItem "Roulette_itemTagSteal"
	local itemTransmute = popItem "Roulette_itemTagTransmute"

	local function roll(probability)
		return RNG.roll(probability, ev.entity)
	end

	local function shotSelf()
		ev.use(ev.gunEntity, ev.entity)
	end

	local function shotTargetOffensive(intensity)
		if itemControl and roll(intensity) then
			ev.use(itemControl)
		end

		if not (ev.opponent and ev.opponent.Roulette_gamblerStatusShield and ev.opponent.Roulette_gamblerStatusShield.turns > 0) then
			while itemOffensive and roll(intensity) do
				ev.use(itemOffensive)
				itemOffensive = popItem "Roulette_itemTagOffensive"
			end
		end

		ev.use(ev.gunEntity, ev.opponent)
	end

	local health = ev.entity.health.health
	local maxHealth = ev.entity.health.maxHealth

	-- Heal
	if itemHeal and health < maxHealth and ev.use(itemHeal) then
		return
	end

	-- Defensive
	if itemDefensive and (health <= 2 or (health < maxHealth / 2 and roll(health / maxHealth * 2))) and ev.use(itemDefensive) then
		return
	end

	-- Steal
	if itemSteal and (#itemEntities < 4 or roll(.2)) and ev.use(itemSteal) then
		return
	end

	local bulletAmount = #ev.gunComponent.bullets
	local currentBullet = ev.aiComponent.memoryBullets[bulletAmount]
	if RouletteGun.isBlankBullet(currentBullet) then
		if itemTransmute and roll(.9) then
			ev.use(itemTransmute)
			return shotTargetOffensive(1)
		else
			return shotSelf()
		end
	elseif RouletteGun.isLiveBullet(currentBullet) then
		return shotTargetOffensive(1)
	end

	if bulletAmount == 2 and itemRetreat and roll(.9) and ev.use(itemRetreat) then
		return
	end

	if itemMisc then
		local usedSet = {}
		repeat
			if not usedSet[itemMisc.name] then
				ev.use(itemMisc)
			else
				usedSet[itemMisc.name] = true
			end

			itemMisc = popItem "Roulette_itemTagMisc"
		until not (itemMisc and roll(#itemEntities / 8))

		return
	end

	if #itemEntities > 6 then
		ev.use(popItem "Roulette_item")
	end

	local liveAmount = 0
	for _, bullet in ipairs(ev.gunComponent.bullets) do
		liveAmount = liveAmount + (RouletteGun.isLiveBullet(bullet) and 1 or 0)
	end
	local liveProbability = liveAmount / bulletAmount

	if liveProbability < .5 and itemTransmute then
		return ev.use(itemTransmute)
	end

	if not (ev.opponent and ev.opponent.Roulette_gamblerStatusFreeze and ev.opponent.Roulette_gamblerStatusFreeze.turns > 0) -- don't shoot self if opponent is frozen.
		and roll(liveProbability)
	then
		if itemDefensive and roll(.3) then
			ev.use(itemDefensive)
		end

		return shotSelf()
	end

	return shotTargetOffensive(.2)
end)

--#endregion

--- @param aiGambler Component.Roulette_aiGamblerDeprecated
local function resetTurnFields(aiGambler)
	aiGambler.usedItems = {}
end

_G.ProcessGamblerAIDelayed = Delay.new(function(entity, parameter)
	if not entity.Roulette_gambler or not entity.Roulette_gambler.turn then
		return
	end

	local ai = entity.Roulette_aiGamblerDeprecated
	if not ai then
		return
	end

	local cursorEntity = RouletteCursor.getFromGamblerEntity(entity)
	if not cursorEntity then
		return
	end

	local judgeEntity = RouletteJudge.getFromGamblerEntity(entity)
	if not judgeEntity then
		return
	elseif parameter.exceedTime < Turn.getTurnTimestamp(Turn.getCurrentTurnID()) then
		return RouletteJudge.nextTurn(judgeEntity)
	end

	local gunEntity = getEntityByID(judgeEntity.Roulette_judge.gun)
	if not gunEntity then
		return
	end

	parameter = parameter or {}
	parameter.tiles = parameter.tiles or {}

	if cursorEntity.Roulette_cursor.active and not RouletteItem.isJudgePlacingItems(judgeEntity) then
		--- @class Event.Roulette_aiGambler
		--- @field entity Entity
		--- @field component Component.Roulette_gambler
		--- @field aiComponent Component.Roulette_aiGamblerDeprecated
		--- @field judgeEntity Entity
		--- @field judgeComponent Component.Roulette_judge
		--- @field gunEntity Entity
		--- @field gunComponent Component.Roulette_gun
		--- @field parameter table
		--- @field use fun(what: Entity, target: Entity?): boolean?
		--- @field items? Entity[]
		--- @field opponent Entity?
		local ev = {
			entity = entity,
			component = entity.Roulette_gambler,
			aiComponent = ai,
			judgeEntity = judgeEntity,
			judgeComponent = judgeEntity.Roulette_judge,
			gunEntity = gunEntity,
			gunComponent = gunEntity.Roulette_gun,
			parameter = parameter,
		}

		function ev.use(what, target)
			if what == nil then
				return
			end

			target = target or getUsingTarget(what, ev)
			if not target or not target.position or not what.position then
				return
			end

			if not RouletteItem.checkUse(entity, what, target) then
				return false
			end

			parameter.tiles[#parameter.tiles + 1] = reduceCoordinates(what.position.x, what.position.y)
			parameter.tiles[#parameter.tiles + 1] = reduceCoordinates(target.position.x, target.position.y)

			local useLimit = what.Roulette_itemTagAIUseLimit
			if useLimit and useLimit.key ~= "" then
				ev.aiComponent.usedItems[useLimit.key] = (ev.aiComponent.usedItems[useLimit.key] or 0) + 1
			end

			return true
		end

		if not parameter.tiles[1] then
			aiGamblerDecisionSelectorFire(ev, entity.name)
			parameter.tiles = Utilities.reverse(parameter.tiles)
		end

		while parameter.tiles[#parameter.tiles] do
			local x, y = unwrapCoordinates(parameter.tiles[#parameter.tiles])
			parameter.tiles[#parameter.tiles] = nil

			if x and y then
				RouletteCursor.interactAt(cursorEntity, x, y)
				break
			end
		end
	end

	_G.ProcessGamblerAIDelayed(entity, parameter, ai.actionDelay * (ai.actionDelayRandomize and (.5 + RNG.float(.5, entity)) or 1))
end, {
	immediate = false,
	unique = true,
})

function RouletteAI.process(entity)
	if entity.Roulette_aiGamblerDeprecated then
		ProcessGamblerAIDelayed(entity, { exceedTime = Turn.getTurnTimestamp(Turn.getCurrentTurnID()) + 20 }, entity.Roulette_aiGamblerDeprecated.actionDelay)
	end
end

event.Roulette_gamblerBeginTurn.add("processGamblerAI", {
	filter = "Roulette_aiGamblerDeprecated",
	order = "ai",
}, function(ev) --- @param ev Event.Roulette_gamblerBeginTurn
	resetTurnFields(ev.entity.Roulette_aiGamblerDeprecated)

	RouletteAI.process(ev.entity)
end)

--- @param ev Event.Roulette_gunReload
event.Roulette_gunReload.add("initGamblerAIMemory", "ai", function(ev)
	local len = #ev.component.bullets
	for entity in ECS.entitiesWithComponents { "Roulette_aiGamblerDeprecated", "Roulette_gambler" } do
		if entity.Roulette_gambler.judge == ev.component.judge then
			for i = 1, len do
				entity.Roulette_aiGamblerDeprecated.memoryBullets[i] = RouletteGun.Bullet.Unknown
			end
		end
	end
end)

--- @param ev Event.Roulette_itemUse
event.Roulette_itemUse.add("aiGamblerMemoryTell", "ai", function(ev)
	if ev.tellBullet and ev.tellBullet.bulletIndex then
		for entity in ECS.entitiesWithComponents { "Roulette_aiGamblerDeprecated" } do
			if ev.user.id == entity.id then
				entity.Roulette_aiGamblerDeprecated.memoryBullets[ev.tellBullet.bulletIndex] = ev.tellBullet.bullet

				return
			end
		end
	end
end)

--- @param ev Event.Roulette_itemUse
event.Roulette_itemUse.add("aiGamblerMemoryTransmute", "ai", function(ev)
	if ev.transmuteBullets then
		local function set(bullets)
			for _, entry in ipairs(ev.transmuteBullets) do
				if bullets[entry.index] ~= RouletteGun.Bullet.Unknown then
					bullets[entry.index] = entry.bullet
				end
			end
		end

		local judge = RouletteJudge.getJudgeFromGamblerEntity(ev.user)
		if judge then
			for _, entityID in ipairs(judge.gamblers) do
				local gamblerEntity = getEntityByID(entityID)
				if gamblerEntity and gamblerEntity.Roulette_aiGamblerDeprecated then
					set(gamblerEntity.Roulette_aiGamblerDeprecated.memoryBullets)
				end
			end
		end
	end
end)

--- @warn This function only work for entity with `Roulette_aiGamblerDeprecated` component
--- @param entity Entity
--- @param position integer
--- @param bulletType RouletteGun.Bullet?
function RouletteAI.fillMemoryBullets(entity, position, bulletType)
	if entity.Roulette_aiGamblerDeprecated then
		for index = position, #entity.Roulette_aiGamblerDeprecated.memoryBullets do
			entity.Roulette_aiGamblerDeprecated.memoryBullets[index] = bulletType
		end
	end
end

event.Roulette_itemUse.add("aiGamblersMemoryRemoveGunBullet", {
	filter = "Roulette_itemUseRemoveGunBullet",
	order = "ai",
}, function(ev) --- @param ev Event.Roulette_itemUse
	if ev.removeGunBulletPos then
		local judge = RouletteJudge.getJudgeFromGamblerEntity(ev.user)
		if judge then
			for _, entity in ipairs(RouletteUtility.getEntitiesFromIDs(judge.gamblers)) do
				RouletteAI.fillMemoryBullets(entity, ev.removeGunBulletPos, nil)
			end
		end
	end
end)

event.Roulette_itemUse.add("aiGamblersMemory", {
	filter = "Roulette_itemUseUpdateAI",
	order = "ai",
	sequence = 100,
}, function(ev) --- @param ev Event.Roulette_sequenceGunShot
	local judge = ev.user and RouletteJudge.getJudgeFromGamblerEntity(ev.user)
	if not judge then
		return
	end

	local gun = RouletteGun.getGunFromGamblerEntity(ev.user)
	if not (gun and gun.bullets[1]) then
		return
	end

	-- we can assume the remaining bullets if there are only same type of bullets left, so does the ai.
	local knownBulletType = gun.bullets[1]
	for _, bullet in ipairs(gun.bullets) do
		if bullet ~= knownBulletType then
			knownBulletType = nil

			break
		end
	end

	for _, gamblerEntity in ipairs(RouletteUtility.getEntitiesFromIDs(judge.gamblers)) do
		RouletteAI.fillMemoryBullets(gamblerEntity, #gun.bullets + 1, nil)

		if knownBulletType then
			RouletteAI.fillMemoryBullets(gamblerEntity, 1, knownBulletType)
		end
	end
end)

--- @param ev Event.Roulette_sequenceJudgeNextRound
event.Roulette_sequenceJudgeNextRound.add("aiGamblerClearMemory", "ai", function(ev)
	for entity in ECS.entitiesWithComponents { "Roulette_aiGamblerDeprecated", "Roulette_gambler" } do
		if entity.Roulette_gambler.judge == ev.entity.id then
			entity.Roulette_aiGamblerDeprecated.memoryBullets = {}
		end
	end
end)

return RouletteAI
