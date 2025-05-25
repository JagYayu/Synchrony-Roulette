local RouletteCursor = require "Roulette.Cursor"
local RouletteGambler = require "Roulette.Gambler"
local RouletteGun = require "Roulette.Gun"
local RouletteItem = require "Roulette.Item"
local RouletteJudge = require "Roulette.Judge"
local RouletteRogueAI = {}
local RouletteUtility = require "Roulette.Utility"

local Character = require "necro.game.character.Character"
local Delay = require "necro.game.system.Delay"
local ECS = require "system.game.Entities"
local Enum = require "system.utils.Enum"
local EnumSelector = require "system.events.EnumSelector"
local ObjectEvents = require "necro.game.object.ObjectEvents"
local OrderedSelector = require "system.events.OrderedSelector"
local RNG = require "necro.game.system.RNG"
local Snapshot = require "necro.game.system.Snapshot"
local Turn = require "necro.cycles.Turn"
local Utilities = require "system.utils.Utilities"

RouletteRogueAI.RNG_Channel = RNG.Channel.extend "Roulette_RogueAI"

RouletteRogueAI.Type = Enum.sequence {
	Standard = 1,
	--- Specific to Clones.
	Clone = 2,
	--- Specific to Warlocks.
	Warlock = 3,
}

local rogueAIGamblerPlanSelectorFire = EnumSelector.new(event.Roulette_rogueAIGamblerPlan, RouletteRogueAI.Type).fire

local rogueAITimeExceed
local rogueAINoResponse
local rogueAISoftLocked
do
	local set = {}

	local function skipTurn(entity)
		local judgeEntity = RouletteJudge.getFromGamblerEntity(entity)
		if judgeEntity then
			RouletteJudge.nextTurn(judgeEntity)
		end

		return true
	end

	--- @param entity Entity
	--- @param parameter RouletteRogueAI.ProcessRogueAIGamblerDelayedParameter
	rogueAITimeExceed = function(entity, parameter)
		if parameter.exceedTime < Turn.getTurnTimestamp(Turn.getCurrentTurnID()) then
			if not set[entity.name] then
				set[entity.name] = true
				log.error("Rogue AI %s:%d's turn has exceeded time!", entity.name, entity.id)
			end

			return skipTurn(entity)
		end
	end

	--- @param entity Entity
	--- @param parameter RouletteRogueAI.ProcessRogueAIGamblerDelayedParameter
	rogueAINoResponse = function(entity, parameter)
		if parameter.noResponseTimes < 5 then
			parameter.noResponseTimes = parameter.noResponseTimes + 1

			return
		end

		if not set[entity.name] then
			set[entity.name] = true
			log.error("Rogue AI %s:%d has no response for 5 times!", entity.name, entity.id)
		end

		return skipTurn(entity)
	end

	--- Expected maximum number of processing is: 8 monkey paws + 8 items + bullet_count
	--- @param entity Entity
	--- @param parameter RouletteRogueAI.ProcessRogueAIGamblerDelayedParameter
	rogueAISoftLocked = function(entity, parameter)
		if parameter.processTimes > parameter.maxProcessTimes then
			if not set[entity.name] then
				set[entity.name] = true
				log.error("Rogue AI %s:%d processor has soft locked!", entity.name, entity.id)
			end

			return skipTurn(entity)
		end
	end
end

--- @param parameter RouletteRogueAI.ProcessRogueAIGamblerDelayedParameter
_G.ProcessRogueAIGamblerDelayed = Delay.new(function(entity, parameter)
	if not (entity.Roulette_gambler and entity.Roulette_gambler.turn) or rogueAITimeExceed(entity, parameter) then
		return
	end

	local cursorEntity = ECS.getEntityByID(parameter.cursorID)
	local gunEntity = ECS.getEntityByID(parameter.gunID)
	local judgeEntity = ECS.getEntityByID(parameter.judgeID)
	if not (cursorEntity and gunEntity and judgeEntity) then
		return
	end

	local interactionList = parameter.interactionList
	if cursorEntity.Roulette_cursor.active and not RouletteItem.isJudgePlacingItems(judgeEntity) then
		if #interactionList == 0 then
			--- @class Event.Roulette_rogueAIGamblerPlan
			--- @field entity Entity
			--- @field component Component.Roulette_gambler
			--- @field aiComponent Component.Roulette_aiGamblerRogue
			--- @field cursorEntity Entity
			--- @field cursor Component.Roulette_cursor
			--- @field gunEntity Entity
			--- @field gun Component.Roulette_gun
			--- @field judgeEntity Entity
			--- @field judge Component.Roulette_judge
			--- @field interactionList { x: integer, y: integer }[]
			--- @field bulletList RouletteGun.Bullet[] @Temporary memorized bullets.
			--- @field itemList Entity[]
			--- @field parameter RouletteRogueAI.ProcessRogueAIGamblerDelayedParameter
			--- @field usedItemSet? table<string, integer>
			local ev = {
				entity = entity,
				component = entity.Roulette_gambler,
				aiComponent = entity.Roulette_aiGamblerRogue,
				cursorEntity = cursorEntity,
				cursor = cursorEntity.Roulette_cursor,
				gunEntity = gunEntity,
				gun = gunEntity.Roulette_gun,
				judgeEntity = judgeEntity,
				judge = judgeEntity.Roulette_judge,
				interactionList = interactionList,
				bulletList = Utilities.fastCopy(entity.Roulette_aiGamblerRogue.memoryBullets),
				itemList = RouletteGambler.getItems(entity),
				parameter = parameter,
			}
			rogueAIGamblerPlanSelectorFire(ev, ev.aiComponent.type)
		end

		if (#interactionList == 0 and rogueAINoResponse(entity, parameter)) or rogueAISoftLocked(entity, parameter) then
			return
		end
		parameter.noResponseTimes = 0

		local tilePosition = table.remove(interactionList, #interactionList)
		if tilePosition then
			RouletteCursor.interactAt(cursorEntity, tilePosition.x, tilePosition.y)
			parameter.processTimes = parameter.processTimes + 1
		end
	end

	ProcessRogueAIGamblerDelayed(entity, parameter, parameter.delay)
end, { unique = true })

--- @param gamblerEntity Entity
function RouletteRogueAI.process(gamblerEntity)
	if not (gamblerEntity.Roulette_aiGamblerRogue and gamblerEntity.Roulette_gambler and gamblerEntity.Roulette_gambler.turn) then
		return
	end

	local cursorEntity = RouletteCursor.getFromGamblerEntity(gamblerEntity)
	if not (cursorEntity and cursorEntity.Roulette_cursor and cursorEntity.Roulette_cursor.active) then
		return
	end

	local judgeEntity = RouletteJudge.getFromGamblerEntity(gamblerEntity)
	if not (judgeEntity and judgeEntity.Roulette_judge and RouletteJudge.hasStarted(judgeEntity.Roulette_judge)) then
		return
	end

	local gunEntity = RouletteGun.getFromGamblerEntity(gamblerEntity)
	if not (gunEntity and gunEntity.Roulette_gun) then
		return
	end

	--- @class RouletteRgueAI.ProcessRogueAIGamblerDelayedParameter
	--- @field gamblerID Entity.ID
	--- @field cursorID Entity.ID
	--- @field judgeID Entity.ID
	--- @field interactionList { x: integer, y: integer }[]
	--- @field exceedTime number
	--- @field noResponseTime integer
	--- @field processTimes integer
	--- @field maxProcessTimes integer
	local parameter = {
		cursorID = cursorEntity.id,
		judgeID = judgeEntity.id,
		gunID = gunEntity.id,
		interactionList = {},
		exceedTime = Turn.getTurnTimestamp(Turn.getCurrentTurnID()) + 15,
		delay = .4,
		noResponseTimes = 0,
		processTimes = 0,
		maxProcessTimes = (16 + #gunEntity.Roulette_gun.bullets) * 2,
	}
	ProcessRogueAIGamblerDelayed(gamblerEntity, parameter, parameter.delay)
end

event.Roulette_gamblerBeginTurn.add("processGamblerRogueAI", {
	filter = { "Roulette_aiGamblerRogue", "Roulette_gambler" },
	order = "ai",
}, function(ev) ---@param ev Event.Roulette_gamblerBeginTurn
	if not ev.suppressed and (not ev.entity.controllable or ev.entity.controllable.playerID == 0) then
		RouletteRogueAI.process(ev.entity)
	end
end)

event.Roulette_gunReload.add("initRogueAIGamblersMemoryBullets", "ai", function(ev) --- @param ev Event.Roulette_gunReload
	for entity in ECS.entitiesWithComponents { "Roulette_aiGamblerRogue", "Roulette_gambler" } do
		if entity.Roulette_gambler.judge == ev.component.judge then
			RouletteUtility.arrayFill(entity.Roulette_aiGamblerRogue.memoryBullets, RouletteGun.Bullet.Unknown, #ev.component.bullets)
		end
	end
end)

--- @param ev Event.Roulette_itemUse
event.Roulette_itemUse.add("rogueAIGamblersMemoryTell", "ai", function(ev)
	if ev.tellBullet and ev.tellBullet.bulletIndex then
		for entity in ECS.entitiesWithComponents { "Roulette_aiGamblerRogue" } do
			if ev.user.id == entity.id then
				entity.Roulette_aiGamblerRogue.memoryBullets[ev.tellBullet.bulletIndex] = ev.tellBullet.bullet

				return
			end
		end
	end
end)

--- @param ev Event.Roulette_itemUse
event.Roulette_itemUse.add("rogueAIGamblersMemoryTransmuteBullets", "ai", function(ev)
	if ev.transmuteBullets then
		local function impl(memoryBullets)
			for _, entry in ipairs(ev.transmuteBullets) do
				if RouletteGun.isUncertainBullet(memoryBullets[entry.index]) then
					memoryBullets[entry.index] = entry.bullet
				end
			end
		end

		local judge = RouletteJudge.getJudgeFromGamblerEntity(ev.user)
		if judge then
			for _, entityID in ipairs(judge.gamblers) do
				local gamblerEntity = ECS.getEntityByID(entityID)
				if gamblerEntity and gamblerEntity.Roulette_aiGamblerRogue then
					impl(gamblerEntity.Roulette_aiGamblerRogue.memoryBullets)
				end
			end
		end
	end
end)

event.Roulette_itemUse.add("rogueAIGamblersMemoryRemoveGunBullet", {
	filter = "Roulette_itemUseRemoveGunBullet",
	order = "ai",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local judge = ev.removeGunBulletPos and RouletteJudge.getJudgeFromGamblerEntity(ev.user)
	if judge then
		for _, entityID in ipairs(judge.gamblers) do
			local entity = ECS.getEntityByID(entityID)
			if entity and entity.Roulette_aiGamblerRogue then
				RouletteUtility.arrayFill(entity.Roulette_aiGamblerRogue.memoryBullets, nil, nil, ev.removeGunBulletPos)
			end
		end
	end
end)

event.Roulette_itemUse.add("rogueAIGamblersMemory", {
	filter = "Roulette_itemUseUpdateAI",
	order = "ai",
	sequence = 100,
}, function(ev) --- @param ev Event.Roulette_sequenceGunShot
	local judge = ev.user and RouletteJudge.getJudgeFromGamblerEntity(ev.user)
	local gun = ev.user and RouletteGun.getGunFromGamblerEntity(ev.user)
	if not (judge and gun and gun.bullets[1]) then
		return
	end

	local function countBullets(certaintifiedBullet)
		local count = 0
		for _, bullet in ipairs(gun.bullets) do
			if RouletteGun.getBulletCertaintifiedType(bullet) == certaintifiedBullet then
				count = count + 1
			end
		end
		return count
	end

	local function bulletsConjectured(gamblerEntity)
		local blankCount = countBullets(RouletteGun.Bullet.Blank)
		if blankCount == 0 then
			return true
		end

		local liveCount = countBullets(RouletteGun.Bullet.Live)
		if liveCount == 0 then
			return true
		end

		for _, bullet in ipairs(gamblerEntity.Roulette_aiGamblerRogue.memoryBullets) do
			if bullet == RouletteGun.Bullet.Blank then
				blankCount = blankCount - 1
				if blankCount <= 0 then
					return true
				end
			elseif bullet == RouletteGun.Bullet.Live then
				liveCount = liveCount - 1
				if liveCount <= 0 then
					return true
				end
			end
		end

		return false
	end

	for _, entityID in ipairs(judge.gamblers) do
		local gamblerEntity = ECS.getEntityByID(entityID)
		if gamblerEntity and gamblerEntity.Roulette_aiGamblerRogue then
			RouletteUtility.arrayFill(gamblerEntity.Roulette_aiGamblerRogue.memoryBullets, nil, nil, #gun.bullets + 1)

			if gamblerEntity.Roulette_aiGamblerRogue.traits.conjectureBullets and bulletsConjectured(gamblerEntity) then
				gamblerEntity.Roulette_aiGamblerRogue.memoryBullets = gun.bullets
				for i = 1, #gamblerEntity.Roulette_aiGamblerRogue.memoryBullets do
					RouletteGun.certaintifyBullet(gamblerEntity.Roulette_aiGamblerRogue.memoryBullets, i)
				end
			end
		end
	end
end)

--- @param ev Event.Roulette_sequenceJudgeNextRound
event.Roulette_sequenceJudgeNextRound.add("rogueAIGamblersClearMemory", "ai", function(ev)
	for entity in ECS.entitiesWithComponents { "Roulette_aiGamblerRogue", "Roulette_gambler" } do
		if entity.Roulette_gambler.judge == ev.entity.id then
			entity.Roulette_aiGamblerRogue.memoryBullets = {}
		end
	end
end)

local planHelperSelectorFire = OrderedSelector.new(event.Roulette_planHelper, { "" }).fire

--- @param ev Event.Roulette_rogueAIGamblerPlan
function RouletteRogueAI.planHelper(ev)
	ev.usedItemSet = ev.usedItemSet or {}

	--- @class Roulette.RogueAI.PlanHelper
	--- @field plan Event.Roulette_rogueAIGamblerPlan
	--- @field items Entity[]
	--- @field controlItems Entity[]
	--- @field defensiveItems Entity[]
	--- @field healthItems Entity[]
	--- @field offensiveItems Entity[]
	--- @field retreatItems Entity[]
	--- @field stealItems Entity[]
	--- @field tellFirstItems Entity[]
	--- @field tellRestItems Entity[]
	--- @field transmuteItems Entity[]
	--- @field bombItems Entity[]
	--- @field usedItemSet table<string, integer>
	--- @field stolenItemCount integer
	local helper = {
		plan = ev,
		items = {},
		controlItems = {},
		defensiveItems = {},
		healthItems = {},
		offensiveItems = {},
		retreatItems = {},
		stealItems = {},
		tellFirstItems = {},
		tellRestItems = {},
		transmuteItems = {},
		bombItems = {},
		usedItemSet = ev.usedItemSet,
		memoryBullets = Utilities.fastCopy(ev.aiComponent.memoryBullets),
		blankBullets = RouletteUtility.arrayCountIf(ev.gun.bullets, RouletteGun.isBlankBullet),
		liveBullets = RouletteUtility.arrayCountIf(ev.gun.bullets, RouletteGun.isLiveBullet),
		stolenItemCount = 0,
	}
	local mapping = {
		Roulette_itemTagControl = helper.controlItems,
		Roulette_itemTagDefensive = helper.defensiveItems,
		Roulette_itemTagHeal = helper.healthItems,
		Roulette_itemTagOffensive = helper.offensiveItems,
		Roulette_itemTagRetreat = helper.retreatItems,
		Roulette_itemTagSteal = helper.stealItems,
		Roulette_itemTagTellFirstBullet = helper.tellFirstItems,
		Roulette_itemTagTellRestBullet = helper.tellRestItems,
		Roulette_itemTagTransmute = helper.transmuteItems,
		Roulette_itemTagBomb = helper.bombItems,
	}

	local filterLethal = ev.aiComponent.traits.itemFilterLethal and ev.entity.health
	for entity in ECS.entitiesWithComponents { "Roulette_item", "Roulette_selectable" } do
		if entity.Roulette_selectable.belonging == ev.entity.id
			and not (filterLethal and entity.Roulette_itemUseDamageUser and (ev.entity.health.health - entity.Roulette_itemUseDamageUser.damage <= 0))
		then
			table.insert(helper.items, entity)

			for component, list in pairs(mapping) do
				if entity[component] then
					table.insert(list, entity)
				end
			end
		end
	end

	function helper.popItem(itemList, pos)
		local item = table.remove(itemList, pos or #itemList)
		if item then
			Utilities.arrayRemove(helper.items, item)
			return item
		end
	end

	local function interactAt(x, y)
		ev.interactionList[#ev.interactionList + 1] = { x = x, y = y }
	end

	--- @param item Entity
	--- @param toEntity Entity
	function helper.useToward(item, toEntity)
		interactAt(item.position.x, item.position.y)
		interactAt(toEntity.position.x, toEntity.position.y)
	end

	local enableItemUseLimit = not not ev.aiComponent.traits.followItemUseLimit
	--- @param item Entity
	--- @param target Entity?
	--- @return boolean @If this item can be used propertly
	function helper.use(item, target)
		if enableItemUseLimit and item.Roulette_itemTagAIUseLimit then
			helper.usedItemSet[item.Roulette_itemTagAIUseLimit.key] = (helper.usedItemSet[item.Roulette_itemTagAIUseLimit.key] or 0) + 1
			if helper.usedItemSet[item.Roulette_itemTagAIUseLimit.key] > item.Roulette_itemTagAIUseLimit.times then
				return false
			end
		end

		if not target then
			local temp = ev.opponent
			--- @diagnostic disable-next-line: inject-field
			ev.opponent = ECS.getEntityByID(ev.aiComponent.opponent)
			--- @type Event.Roulette_aiGamblerItemUsingTarget
			local ev1 = {
				entity = item,
				parentEv = ev,
				target = nil,
			}
			event.Roulette_aiGamblerItemUsingTarget.fire(ev1, item.name)
			--- @diagnostic disable-next-line: inject-field
			ev.opponent = temp
			target = ev1.target
		end

		if target and target.position then
			if RouletteItem.checkUse(ev.entity, item, target) then
				helper.useToward(item, target)
				return true
			end
		end

		return false
	end

	--- @param target Entity
	function helper.shoot(target)
		helper.useToward(ev.gunEntity, target)
		Utilities.clearTable(ev.usedItemSet)
	end

	function helper.shootOpponent()
		local entity = ECS.getEntityByID(ev.aiComponent.opponent)
		if entity then
			helper.shoot(entity)
		end
	end

	--- Would shoot opponent if they can't select themselves
	function helper.shootSelf()
		if ev.entity.Roulette_selectable and not ev.entity.Roulette_selectable.suppressed then
			helper.shoot(ev.entity)
		else
			helper.shootOpponent()
		end
	end

	planHelperSelectorFire(helper)
	return helper, function()
		Utilities.reverse(ev.interactionList)
		Utilities.clearTable(helper)
	end
end

RouletteRogueAI.Implements = {}

RouletteRogueAI.Implements.ChooseOpponent = {
	HostileHigherHealth = 1,
	HostileLowerHealth = 2,
	Random = 3,
	RandomHostile = 4,
	AllieLowerHealth = 5,
}

local function filterSelectable(entity)
	return not entity.Roulette_selectable or entity.Roulette_selectable.suppressed
end

---@param helper Roulette.RogueAI.PlanHelper
function RouletteRogueAI.Implements.chooseOpponent(helper)
	local entity = helper.plan.entity
	local opponent

	local value = helper.plan.aiComponent.traits.chooseOpponent
	if value == RouletteRogueAI.Implements.ChooseOpponent.HostileHigherHealth or value == RouletteRogueAI.Implements.ChooseOpponent.HostileLowerHealth then
		local targetRealTeam = not not (entity.Roulette_gamblerCharmable and entity.Roulette_gamblerCharmable.turns > 0 and helper.plan.aiComponent.traits.chooseOpponentRealTeam)
		local list = Utilities.removeIf(RouletteGambler.getOpponents(entity, targetRealTeam), filterSelectable)

		opponent = Utilities.sort(list, function(l, r)
			local lh = l.health and l.health.health or 0
			local rh = r.health and r.health.health or 0
			if lh ~= rh then
				return lh < rh
			else
				return l.id < r.id
			end
		end)[value == RouletteRogueAI.Implements.ChooseOpponent.HostileHigherHealth and #list or 1]
	elseif value == RouletteRogueAI.Implements.ChooseOpponent.Random then
		local list = Utilities.removeIf(RouletteUtility.getEntitiesFromIDs(helper.plan.judge.gamblers), filterSelectable)

		opponent = RNG.choice(list, entity.random and entity or RouletteRogueAI.RNG_Channel)
	elseif value == RouletteRogueAI.Implements.ChooseOpponent.AllieLowerHealth then
		local list = Utilities.removeIf(RouletteUtility.getEntitiesFromIDs(helper.plan.judge.gamblers), function(entity)
			return filterSelectable(entity) or RouletteGambler.isHostile(entity, entity)
		end)

		opponent = Utilities.sort(list, function(l, r)
			local lp = l.health and (l.health.health / l.health.maxHealth) or 0
			local rp = r.health and (r.health.health / r.health.maxHealth) or 0
			if lp ~= rp then
				return lp < rp
			elseif l.health and r.health and l.health.maxHealth ~= r.health.maxHealth then
				return l.health.maxHealth > r.health.maxHealth
			else
				return l.id < r.id
			end
		end)[1]
	end

	local id = opponent and opponent.id or 0
	helper.plan.aiComponent.opponent = id
	if id == 0 then
		log.warn("Rogue AI %s:%d didn't choose any opponent!", entity.name, entity.id)
	end
	return id
end

--- @class Component.Roulette_aiGamblerRogue.traits
--- @field chooseOpponent integer?
--- @field conjectureBullets boolean?
--- @field itemFilterLethal boolean?
--- @field gunShoot number? @nil->0
--- @field gunShootUseOffensiveItemsAffirmative boolean? @Decide if ai use offensive items before shotting opponent when know its a live.
--- @field gunShootUseOffensiveItems boolean? @Decide if ai use offensive items before shotting opponent.
--- @field gunShootUseDefensiveItems boolean? @Decide if ai use defensive items before shotting self.
--- @field controlItemsCleanup number? @nil->math.huge. Use when total item number is greater then x.
--- @field defensiveItemThreshold number? @nil->1. Use when health is lower or equal than x.
--- @field healthItemPreferMatch boolean? @Prefer using healing items that match empty health.
--- @field healthItemThreshold number? @nil->1. Use when health is lower or equal than x.
--- @field offensiveItemCleanup number? @nil->math.huge.
--- @field offensiveItemMax number? @nil->1. How many can be used at one time?
--- @field tellFirstItemCleanup boolean?
--- @field tellRestItemMax boolean?
--- @field itemUsages RogueAI.ItemUsageType[]?

--- @alias RogueAI.ItemUsageType "control" | "defensive" | "health" | "offensive" | "retreat" | "steal" | "tellFirst" | "tellRest" | "transmute" | "bomb"
--- @type table<RogueAI.ItemUsageType, fun(helper: Roulette.RogueAI.PlanHelper, arg: any): true?>
RouletteRogueAI.Implements.ItemUsages = {
	control = function(helper)
		local items = helper.controlItems
		if not items[1] then
			return
		end

		if #helper.items >= (tonumber(helper.plan.aiComponent.traits.controlItemsCleanup) or math.huge) then
			helper.use(helper.popItem(items))
		end
	end,
	--- @param arg number? @Is forced.
	defensive = function(helper, arg)
		local items = helper.defensiveItems
		if not items[1] then
			return
		end

		if not arg then
			local hp = helper.plan.entity.health
			if hp.health / hp.maxHealth > (tonumber(helper.plan.aiComponent.traits.defensiveItemThreshold) or 0) then
				return
			end
		end

		helper.use(helper.popItem(items))
	end,
	health = function(helper) ---@param helper Roulette.RogueAI.PlanHelper
		local hp = helper.plan.entity.health
		if not helper.healthItems[1]
			or hp.health / hp.maxHealth > (tonumber(helper.plan.aiComponent.traits.healthItemThreshold) or 0)
		then
			return
		end

		local emptyHealth = hp.maxHealth - hp.health
		local items = helper.healthItems

		if helper.plan.aiComponent.traits.healthItemPreferMatch then
			for i, e in ipairs(items) do
				if e.Roulette_itemUseHeal.health == emptyHealth then
					return helper.use(helper.popItem(items, i))
				end
			end
		end

		table.sort(items, function(l, r)
			if l.Roulette_itemUseHeal.health ~= r.Roulette_itemUseHeal.health then
				return l.Roulette_itemUseHeal.health > r.Roulette_itemUseHeal.health
			else
				return l.id > r.id
			end
		end)

		while emptyHealth > 0 do
			local item = helper.popItem(items)
			if not item then
				break
			end
			helper.use(item)
		end
	end,
	offensive = function(helper, forced)
		local items = helper.offensiveItems
		if not items[1] then
			return
		end

		for _ = 1, (tonumber(forced) or tonumber(helper.plan.aiComponent.traits.offensiveItemMax) or 1) do
			local item = helper.popItem(items)
			if not item then
				break
			end
			helper.use(item)
		end
	end,
	retreat = function(helper)
		local items = helper.retreatItems
		if not items[1] then
			return
		end

		while #items >= (helper.plan.aiComponent.traits.retreatItemCleanup or math.huge) do
			local item = helper.popItem(items)
			if not item then
				break
			end
			helper.use(item)
		end
	end,
	steal = function(helper, entity)
		local items = helper.stealItems
		if items[1] and helper.stolenItemCount <= (tonumber(helper.plan.aiComponent.traits.stealItemMax) or 1) and helper.use(helper.popItem(items)) then
			helper.stolenItemCount = helper.stolenItemCount + 1
			return true
		end
	end,
	tellFirst = function(helper)
		local items = helper.tellFirstItems
		if not items[1] then
			return
		end

		if helper.plan.aiComponent.traits.tellFirstItemNoWaste and helper.memoryBullets[#helper.memoryBullets] ~= RouletteGun.Bullet.Unknown then
			return
		end

		if helper.use(helper.popItem(items)) then
			return true
		end
	end,
	tellRest = function(helper)
		local items = helper.tellRestItems
		if not items[1] then
			return
		end

		if helper.plan.aiComponent.traits.tellRestItemNoWaste then
			local allKnown = true
			for _, bullet in ipairs(helper.memoryBullets) do
				if bullet == RouletteGun.Bullet.Unknown then
					allKnown = false
					break
				end
			end
			if allKnown then
				return
			end
		end

		helper.use(helper.popItem(items))
	end,
	transmute = function(helper)
		local item = helper.popItem(helper.transmuteItems)
		if item then
			if item.Roulette_itemUseTransmuteBullet then
				local component = item.Roulette_itemUseTransmuteBullet
				RouletteGun.transmute(helper.memoryBullets, component.count)
			end
			helper.use(item)
		end
	end,
	bomb = function(helper)
		local item = helper.popItem(helper.bombItems)
		if item then
			helper.use(item)
			return true
		end
	end,
}

--- @param helper Roulette.RogueAI.PlanHelper
--- @return boolean continue
function RouletteRogueAI.Implements.useItems(helper)
	if not RouletteCursor.checkAvailability(helper.plan.cursorEntity, helper.plan.entity) then
		return true
	end

	if type(helper.plan.aiComponent.traits.itemUsages) == "table" then
		for _, key in ipairs(helper.plan.aiComponent.traits.itemUsages) do
			local func = RouletteRogueAI.Implements.ItemUsages[key]
			if type(func) == "function" then
				local skip = func(helper)
				if skip then
					return false
				end
			end
		end
	end

	return true
end

--- @param helper Roulette.RogueAI.PlanHelper
function RouletteRogueAI.Implements.useGun(helper)
	local bullet = helper.memoryBullets[#helper.memoryBullets]
	if RouletteGun.isLiveBullet(bullet) then
		if helper.plan.aiComponent.traits.gunShootUseOffensiveItemsAffirmative then
			RouletteRogueAI.Implements.ItemUsages.offensive(helper, true)
		end

		return helper.shootOpponent()
	elseif RouletteGun.isBlankBullet(bullet) then
		if helper.plan.aiComponent.traits.gunShootUseTransmuteItems and helper.transmuteItems[1] then
			RouletteRogueAI.Implements.ItemUsages.transmute(helper, true)

			return helper.shootOpponent()
		end

		return helper.shootSelf()
	end

	if helper.liveBullets / (helper.liveBullets + helper.blankBullets) >= 1 - (tonumber(helper.plan.aiComponent.traits.gunShoot) or 1) then
		if helper.plan.aiComponent.traits.gunShootUseOffensiveItems then
			RouletteRogueAI.Implements.ItemUsages.offensive(helper, true)
		end

		return helper.shootOpponent()
	else
		if helper.plan.aiComponent.traits.gunShootUseDefensiveItems then
			RouletteRogueAI.Implements.ItemUsages.defensive(helper, true)
		end

		return helper.shootSelf()
	end
end

--#region Standard AI

--- @param ev Event.Roulette_rogueAIGamblerPlan
event.Roulette_rogueAIGamblerPlan.add("standard", RouletteRogueAI.Type.Standard, function(ev)
	local helper, finalize = RouletteRogueAI.planHelper(ev)
	RouletteRogueAI.Implements.chooseOpponent(helper)
	if RouletteRogueAI.Implements.useItems(helper) then
		RouletteRogueAI.Implements.useGun(helper)
	end
	finalize()
end)

--#endregion

--#region Clone AI

RouletteRogueAI.RNG_Channel_CloneAIRandomInitialTarget = RNG.Channel.extend "Roulette_CloneAIRandomInitialTarget"

--- @class RogueAI.CloneAIData
--- @field targetLock Entity.ID
--- @field useItems boolean
--- @field shootSequences boolean[]

--- @type table<Entity.ID, RogueAI.CloneAIData>
CloneAIDataMap = Snapshot.levelVariable {}

function RouletteRogueAI.clearCloneAIData(entityID)
	CloneAIDataMap[entityID] = nil
end

event.objectDespawn.add("removeCloneAIData", "despawnEntity", function(ev)
	RouletteRogueAI.clearCloneAIData(ev.entity.id)
end)

--- @warn The returned tables are stored as snapshot variables, so do not put non-serializable values into them!
--- @param entityID Entity.ID
--- @param targetID Entity.ID?
--- @return RogueAI.CloneAIData
function RouletteRogueAI.getOrInitCloneAIData(entityID, targetID)
	local data = CloneAIDataMap[entityID]
	if not data then
		data = { targetLock = targetID or 0, useItems = false, shootSequences = {} }
		if ECS.entityExists(entityID) then
			CloneAIDataMap[entityID] = data
		end
	end
	return data
end

event.Roulette_gamblerStartGame.add("resetAndInitCloneAIData", {
	filter = "Roulette_aiGamblerRogue",
	order = "ai",
}, function(ev)
	RouletteRogueAI.clearCloneAIData(ev.entity.id)
	if ev.entity.Roulette_aiGamblerRogue.type == RouletteRogueAI.Type.Clone then
		local opponent = RNG.choice(RouletteGambler.getOpponents(ev.entity, true), RouletteRogueAI.RNG_Channel_CloneAIRandomInitialTarget)
		if opponent then
			RouletteRogueAI.getOrInitCloneAIData(ev.entity.id, opponent.id)
			Character.setCloneTarget(ev.entity, opponent)

			if opponent.health and ev.entity.health then
				local health = math.floor(opponent.health.maxHealth / 2)
				ev.entity.health.health = health
				ev.entity.health.maxHealth = health
			end
			if ev.entity.useCloneSprite then
				ObjectEvents.fire("updateCloneSprite", ev.entity, { target = opponent })
			end
		end
	end
end)

--- @param ev Event.Roulette_rogueAIGamblerPlan
event.Roulette_rogueAIGamblerPlan.add("clone", RouletteRogueAI.Type.Clone, function(ev)
	local data = RouletteRogueAI.getOrInitCloneAIData(ev.entity.id)
	local helper, finalize = RouletteRogueAI.planHelper(ev)

	local target = ECS.getEntityByID(data.targetLock)
	if not (target and Character.isAlive(target)) then
		data.targetLock = RouletteRogueAI.Implements.chooseOpponent(helper)
	else
		ev.aiComponent.opponent = data.targetLock
	end

	local useGun = true
	if data.useItems and not RouletteRogueAI.Implements.useItems(helper) then
		useGun = false
	end
	if useGun then
		local targetOrSelf = table.remove(data.shootSequences, #data.shootSequences)
		if targetOrSelf == nil then
			targetOrSelf = data.shootSequences[0]
		else
			data.shootSequences[0] = targetOrSelf
		end
		; (targetOrSelf and helper.shootOpponent or helper.shootSelf)()
	end

	finalize()
end)

--- @param ev Event.Roulette_gamblerBeginTurn
event.Roulette_gamblerBeginTurn.add("cloneAI", "ai", function(ev)
	local id = ev.entity.id

	for _, data in pairs(CloneAIDataMap) do
		if data.targetLock == id then
			data.useItems = false
			data.shootSequences = {}
		end
	end
end)

event.Roulette_sequenceJudgeNextRound.add("cloneAI", "ai", function(_)
	for _, data in pairs(CloneAIDataMap) do
		data.useItems = false
		data.shootSequences = {}
	end
end)

--- @param ev Event.Roulette_itemUse
event.Roulette_itemUse.add("cloneAI", "ai", function(ev)
	if ev.item.Roulette_item then
		local id = ev.user.id
		for _, data in pairs(CloneAIDataMap) do
			if data.targetLock == id then
				data.useItems = true
			end
		end
	end
end)

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot2.add("cloneAI", "ai", function(ev)
	local id = ev.target and ev.user and ev.user.id
	if not id then
		return
	end

	for _, data in pairs(CloneAIDataMap) do
		if data.targetLock == id then
			data.shootSequences[#data.shootSequences + 1] = ev.target.id ~= id
		end
	end
end)

--#endregion

--#region Warlock AI

event.Roulette_rogueAIGamblerPlan.add("warlock", RouletteRogueAI.Type.Warlock, function(ev)
	local helper, finalize = RouletteRogueAI.planHelper(ev)
	do -- Use items based on opponent
		local opponent = Utilities.sort(Utilities.removeIf(RouletteGambler.getOpponents(helper.plan.entity, true), filterSelectable), function(l, r)
			if l.health.health ~= r.health.health then
				return l.health.health > r.health.health
			else
				return l.id < r.id
			end
		end)[1]
		if opponent then
			helper.plan.aiComponent.opponent = opponent.id
			if not RouletteRogueAI.Implements.useItems(helper) then
				return
			end
		end
	end
	RouletteRogueAI.Implements.chooseOpponent(helper)
	RouletteRogueAI.Implements.useGun(helper)
	finalize()
end)

--#endregion

return RouletteRogueAI
