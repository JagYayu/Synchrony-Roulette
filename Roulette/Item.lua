local RouletteGambler = require "Roulette.Gambler"
local RouletteItem = {}
local RouletteJudge = require "Roulette.Judge"
local RouletteUtility = require "Roulette.Utility"

local Character = require "necro.game.character.Character"
local Collision = require "necro.game.tile.Collision"
local Damage = require "necro.game.system.Damage"
local Delay = require "necro.game.system.Delay"
local ECS = require "system.game.Entities"
local EntityGeneration = require "necro.game.level.EntityGeneration"
local EntitySelector = require "system.events.EntitySelector"
local Health = require "necro.game.character.Health"
local ItemPickup = require "necro.game.item.ItemPickup"
local Move = require "necro.game.system.Move"
local Object = require "necro.game.object.Object"
local ObjectSelector = require "necro.game.object.ObjectSelector"
local Random = require "system.utils.Random"
local RNG = require "necro.game.system.RNG"
local Snapshot = require "necro.game.system.Snapshot"
local Sound = require "necro.audio.Sound"
local SoundGroups = require "necro.audio.SoundGroups"
local Tile = require "necro.game.tile.Tile"
local Timer = require "system.utils.Timer"
local Utilities = require "system.utils.Utilities"
local Voice = require "necro.audio.Voice"

local getEntityByID = ECS.getEntityByID

event.inventoryCollectItem.add("trackItemPickupTime", {
	filter = "Roulette_item",
	order = "unlock",
}, function(ev)
	ev.item.Roulette_item.pickupTime = Timer.getGlobalTime()
end)

--- @param item Entity
--- @param entity Entity
--- @param canBeAlly boolean?
--- @return boolean
function RouletteItem.isOpponentItem(item, entity, canBeAlly)
	local judgeID = entity.Roulette_gambler and entity.Roulette_gambler.judge
	if ECS.entityExists(judgeID) and judgeID ~= 0 then
		local owner = item.Roulette_selectable and getEntityByID(item.Roulette_selectable.belonging)
		if owner and owner.id ~= entity.id and owner.Roulette_gambler and owner.Roulette_gambler.judge == judgeID
			and (canBeAlly or RouletteGambler.isHostile(entity, owner, true))
		then
			return true
		end
	end

	return false
end

local itemCheckUseSelectorFire = EntitySelector.new(event.Roulette_itemCheckUse, {
	"target",
	"targetNegate",
	"conditional",
}).fire

event.Roulette_itemCheckUse.add("onAlly", {
	filter = "Roulette_itemUseOnAlly",
	order = "target",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if not ev.success and ev.user.Roulette_gambler and ev.user.Roulette_gambler.judge ~= 0 and ev.target.Roulette_gambler then
		ev.success = RouletteGambler.isHostile(ev.user, ev.target, true) == false
	end
end)

event.Roulette_itemCheckUse.add("onOpponentItem", {
	filter = "Roulette_itemUseOnOpponentItem",
	order = "target",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if not ev.success then
		ev.success = RouletteItem.isOpponentItem(ev.target, ev.user, ev.item.Roulette_itemUseOnOpponentItem.canBeAlly)
	end
end)

event.Roulette_itemCheckUse.add("onGun", {
	filter = "Roulette_itemUseOnGun",
	order = "target",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if not ev.success then
		ev.success = not not ev.target.Roulette_gun
	end
end)

event.Roulette_itemCheckUse.add("onSelf", {
	filter = "Roulette_itemUseOnSelf",
	order = "target",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if not ev.success then
		ev.success = ev.user.id == ev.target.id
	end
end)

event.Roulette_itemCheckUse.add("onSelfItem", {
	filter = "Roulette_itemUseOnSelfItem",
	order = "target",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if not ev.success and ev.target.Roulette_item then
		ev.success = not RouletteItem.isOpponentItem(ev.target, ev.user, true)
	end
end)

event.Roulette_itemCheckUse.add("onOpponent", {
	filter = "Roulette_itemUseOnOpponent",
	order = "target",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if not ev.success and ev.user.Roulette_gambler and ev.user.Roulette_gambler.judge ~= 0 and ev.target.Roulette_gambler then
		ev.success = not not (ev.user.id ~= ev.target.id and ev.user.Roulette_gambler.judge == ev.target.Roulette_gambler.judge)

		if ev.success and not ev.item.Roulette_itemUseOnOpponent.canBeAlly and RouletteGambler.isHostile(ev.user, ev.target, true) == false then
			ev.success = false
		end
	end
end)

event.Roulette_itemCheckUse.add("negateOnOpponentItem", {
	filter = "!Roulette_itemUseAllowTargetOpponentItem",
	order = "targetNegate",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if ev.success and RouletteItem.isOpponentItem(ev.target, ev.user) then
		ev.success = false
	end
end)

event.Roulette_itemCheckUse.add("freezeCondition", {
	filter = "Roulette_itemUseSetGamblerFreeze",
	order = "conditional",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if ev.success and (RouletteGambler.isFreezing(ev.target) or RouletteGambler.isShielding(ev.target)) then
		ev.success = false
	end
end)

event.Roulette_itemCheckUse.add("shieldingCondition", {
	filter = "Roulette_itemUseSetGamblerShield",
	order = "conditional",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if ev.success then
		local status = ev.target.Roulette_gamblerStatusShield
		if status and status.turns + .5 > ev.item.Roulette_itemUseSetGamblerShield.turns then
			ev.success = false
		end
	end
end)

event.Roulette_itemCheckUse.add("steal", {
	filter = "Roulette_itemUseSteal",
	order = "conditional",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if ev.success and not (ev.target.Roulette_itemUseSteal or ev.target.Roulette_stealable) then
		ev.success = false
	end
end)

--- @param user any
--- @param item any
--- @param target any
--- @return boolean success
--- @return Event.Roulette_itemCheckUse ev
function RouletteItem.checkUse(user, item, target)
	--- @class Event.Roulette_itemCheckUse
	--- @field user Entity
	--- @field item Entity
	--- @field target Entity
	--- @field success boolean?
	local ev = {
		user = user,
		item = item,
		target = target,
		success = nil,
	}
	itemCheckUseSelectorFire(ev, item.name)
	return not not ev.success, ev
end

local itemUseSelectorFire = EntitySelector.new(event.Roulette_itemUse, {
	"use",
	"ai",
	"cursor",
	"next",
	"effect",
	"sound",
	"delete",
}).fire

event.Roulette_itemUse.add("gamblerFreeze", {
	filter = "Roulette_itemUseSetGamblerFreeze",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	RouletteGambler.freeze(ev.target, ev.item.Roulette_itemUseSetGamblerFreeze.turns, ev.user)
end)

event.Roulette_itemUse.add("gamblerShield", {
	filter = "Roulette_itemUseSetGamblerShield",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local turns = ev.item.Roulette_itemUseSetGamblerShield.turns

	if RouletteGambler.isHostile(ev.target, ev.user) == false and RouletteUtility.isGamblerBehind(ev.target, ev.user) then
		turns = turns + ev.item.Roulette_itemUseSetGamblerShield.allyBuff
	end

	RouletteGambler.shield(ev.target, turns)
end)

event.Roulette_itemUse.add("gamblerFreezeAll", {
	filter = "Roulette_itemUseSetGamblersFreeze",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local judge = RouletteJudge.getJudgeFromGamblerEntity(ev.user)
	if judge then
		local turns = ev.item.Roulette_itemUseSetGamblersFreeze.turns
		RouletteGambler.freeze(ev.target, turns, ev.user)
		for _, entity in ipairs(RouletteGambler.getAllies(ev.target, true)) do
			RouletteGambler.freeze(entity, turns, ev.user)
		end
	end
end)

event.Roulette_itemUse.add("heal", {
	filter = "Roulette_itemUseHeal",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	if ev.target.health then
		local prevHealth = ev.target.health.health
		ev.heal = Health.heal {
			entity = ev.target,
			healer = ev.item,
			health = ev.item.Roulette_itemUseHeal.health,
		}
		ev.overheal = ev.item.Roulette_itemUseHeal.health - (ev.target.health.health - prevHealth)
	end
end)

event.Roulette_itemUse.add("damage", {
	filter = "Roulette_itemUseDamageUser",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	Damage.inflict {
		victim = ev.user,
		damage = ev.item.Roulette_itemUseDamageUser.damage,
		type = ev.item.Roulette_itemUseDamageUser.type,
	}
end)

event.Roulette_itemUse.add("damageLater", {
	filter = "Roulette_itemUseConditionalDamageLater",
	order = "use",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_itemUse
	local component = ev.item.Roulette_itemUseConditionalDamageLater
	if component.active then
		component.active = false

		local damage = component.damage - (tonumber(ev.overheal) or 0)
		if damage > 0 then
			Damage.inflict {
				victim = ev.target,
				type = component.type,
				damage = damage,
				--- @diagnostic disable-next-line: assign-type-mismatch
				killerName = ev.item.friendlyName and ev.item.friendlyName.name or ev.item.name,
			}
		end
	end
end)

event.Roulette_itemUse.add("steal", {
	filter = { "Roulette_itemUseSteal", "position" },
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	if ev.target.Roulette_itemUseSteal or not ev.target.position then
		Object.delete(ev.target)
	elseif ev.target.Roulette_stealable then
		Move.absolute(ev.target, ev.item.position.x, ev.item.position.y, Move.getMoveType(ev.target))

		if ev.target.Roulette_selectable then
			ev.target.Roulette_selectable.belonging = ev.user.id
		end
	end
end)

event.Roulette_itemUse.add("skipTurn", {
	filter = "Roulette_itemUseSkipTurn",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	if ev.skipTurn == nil then
		ev.skipTurn = true
	end
end)

event.Roulette_itemUse.add("userHopInPlace", {
	filter = "Roulette_itemUseUserHop",
	order = "effect",
}, function(ev) --- @param ev Event.Roulette_itemUse
	Character.hopInPlace(ev.user)
end)

event.Roulette_itemUse.add("sound", {
	filter = "Roulette_itemUseSound",
	order = "sound",
}, function(ev) --- @param ev Event.Roulette_itemUse
	Sound.playFromEntity(ev.item.Roulette_itemUseSound.sound, ev.item)
end)

event.Roulette_itemUse.add("voice", {
	filter = "Roulette_itemUseVocalize",
	order = "sound",
}, function(ev) --- @param ev Event.Roulette_itemUse
	if ev.user.voiceSpellCasterPrefix then
		local group = ev.user.voiceSpellCasterPrefix.prefix .. ev.item.Roulette_itemUseVocalize.suffix
		if not SoundGroups.isValid(group) then
			group = ev.user.voiceSpellCasterPrefix.fallback
		end
		Voice.play(ev.user, group)
	end
end)

event.Roulette_itemUse.add("delete", {
	filter = "!Roulette_itemUseNoDeletion",
	order = "delete",
}, function(ev) --- @param ev Event.Roulette_itemUse
	Object.lazyDelete(ev.item)
end)

--- @param user Entity
--- @param item Entity @The `item` entity doesn't have to have `item` component.
--- @param target Entity
--- @return Event.Roulette_itemUse? ev
function RouletteItem.use(user, item, target)
	if RouletteItem.checkUse(user, item, target) then
		--- @class Event.Roulette_itemUse.TellBullet
		--- @field bullet RouletteGun.Bullet?
		--- @field bulletName string?
		--- @field bulletIndex integer
		--- @field index integer

		--- @class Event.Roulette_itemUse.TransmuteBullet
		--- @field bullet RouletteGun.Bullet @Supposed to be a certaintified bullet
		--- @field index integer

		--- @class Event.Roulette_itemUse
		--- @field user Entity
		--- @field item Entity
		--- @field target Entity
		--- @field skipTurn? boolean
		--- @field nextRound? boolean @If gun has no shells after shooting, it set this value to true.
		--- @field tellBullet? Event.Roulette_itemUse.TellBullet
		--- @field transmuteBullets? Event.Roulette_itemUse.TransmuteBullet[]
		--- @field removeGunBulletPos? integer
		--- @field heal? Event.ObjectHeal
		--- @field clone? Entity
		--- @field overheal? integer
		local ev = {
			user = user,
			item = item,
			target = target,
		}
		itemUseSelectorFire(ev, item.name)
		return ev
	end
end

local itemGenerationWeightSelectorFire = EntitySelector.new(event.Roulette_itemGenerationWeight, {
	"default",
	"override",
}).fire

event.Roulette_itemGenerationWeight.add("gamblersRequired", {
	filter = "Roulette_itemGenGamblersRequired",
	order = "override",
}, function(ev) --- @param ev Event.Roulette_itemGenerationWeight
	if ev.judgeEntity.Roulette_judge and #ev.judgeEntity.Roulette_judge.gamblers >= ev.prototype.Roulette_itemGenGamblersRequired.minimum then
		ev.weight = ev.prototype.Roulette_itemGenGamblersRequired.weightOverride
	end
end)

event.Roulette_itemGenerationWeight.add("roundLimit", {
	filter = "Roulette_itemGenRoundLimit",
	order = "override",
}, function(ev) --- @param ev Event.Roulette_itemGenerationWeight
	local round = ev.judgeEntity.Roulette_judge and ev.judgeEntity.Roulette_judge.round
	if round then
		local component = ev.prototype.Roulette_itemGenRoundLimit
		if (component.minimum ~= 0 and round < component.minimum) or (component.maximum ~= 0 and round > component.maximum) then
			ev.weight = component.weightOverride
		end
	end
end)

local itemGenerationWeightPostProcessSelectorFire = ObjectSelector.new("Roulette_itemGenerationWeightPostProcess", {
	"ban",
	"more",
	"override",
}).fire

event.objectRoulette_itemGenerationWeightPostProcess.add("override", {
	filter = "Roulette_gamblerOverrideItemWeights",
	order = "override",
}, function(ev)
	local weight = tonumber(ev.entity.Roulette_gamblerOverrideItemWeights.mapping[ev.prototype.name])
	if weight then
		ev.weight = weight
	end
end)

--- @param prototype Entity
--- @param judgeEntity Entity
--- @param gamblerEntity Entity
--- @return number weight
--- @return Event.Roulette_itemGenerationWeight ev
function RouletteItem.itemGenerationWeight(prototype, judgeEntity, gamblerEntity)
	--- @class Event.Roulette_itemGenerationWeight
	--- @field weight number
	--- @field prototype Entity
	--- @field judgeEntity Entity
	local ev = {
		weight = 0,
		prototype = prototype,
		judgeEntity = judgeEntity,
		gamblerEntity = gamblerEntity,
	}
	itemGenerationWeightSelectorFire(ev, prototype.name)
	if ev.gamblerEntity then
		ev.entity = ev.gamblerEntity
		itemGenerationWeightPostProcessSelectorFire(ev, ev.gamblerEntity)
	end
	return (type(ev.weight) == "number" and ev.weight > 0) and ev.weight or 0, ev
end

event.Roulette_itemGenerationWeight.add("default", {
	filter = "Roulette_itemPool",
	order = "default",
}, function(ev)
	ev.weight = ev.prototype.Roulette_itemPool.weight
end)

IsPlacingItemsSet = Snapshot.levelVariable {}

function RouletteItem.isJudgePlacingItems(judgeEntity)
	return not not IsPlacingItemsSet[judgeEntity.id]
end

PlaceItemDelayed = Delay.new(function(entity, parameter)
	if parameter.type then
		--- @diagnostic disable-next-line: missing-fields
		local itemEntity = Object.spawn(parameter.type, entity.position.x, entity.position.y, {
			Roulette_visibilityHideItemHintLabel = { hide = true },
			Roulette_visibilityHideItemStackQuantityLabel = { hide = true },
		})

		Move.absolute(itemEntity, parameter.x, parameter.y, Move.getMoveType(itemEntity))

		if itemEntity.Roulette_selectable then
			itemEntity.Roulette_selectable.belonging = parameter.owner
		end
	end

	if parameter.endPlacing then
		IsPlacingItemsSet[parameter.endPlacing] = nil
	end
end)

event.Roulette_sequenceJudgeNextRound2.add("allocateItems", {
	filter = { "Roulette_judgeAllocItems", "position", "random" },
	order = "item",
}, function(ev) ---@param ev Event.Roulette_sequenceJudgeNextRound
	local judge = ev.entity.Roulette_judge
	local alloc = ev.entity.Roulette_judgeAllocItems

	local baseAmount = alloc.itemCounts[judge.round] or alloc.itemCounts[#alloc.itemCounts]
	if type(baseAmount) == "table" and type(baseAmount[1]) == "number" and type(baseAmount[2]) == "number" then
		baseAmount = RNG.range(baseAmount[1], baseAmount[2], ev.entity)
	elseif type(baseAmount) ~= "number" then
		return
	end
	--- @cast baseAmount integer

	local itemGenOwnerGambler
	local generateChoice = {
		requiredComponents = { "Roulette_item", "!Roulette_itemExcludedFromAllocator" },
		filter = function() return true end,
		chanceFunction = function(e)
			return RouletteItem.itemGenerationWeight(e, ev.entity, itemGenOwnerGambler)
		end,
		markSeen = false,
		seenCounts = ev, -- it does nothing.
	}
	local seed = RNG.getDungeonSeed()

	local function placeItemsPerTeam(entities, gamblerTeam)
		entities = Utilities.removeIf(Utilities.arrayCopy(entities), function(entity)
			return entity.Roulette_gambler.team ~= gamblerTeam
		end)

		local tileIndices = {}
		for _, gamblerEntity in ipairs(entities) do
			local i = 0
			for offsetX, offsetY in RouletteUtility.iterateOffsetsInRange(gamblerEntity.Roulette_gambler.placementRange) do
				tileIndices[#tileIndices + 1] = {
					Tile.reduceCoordinates(gamblerEntity.position.x + offsetX, gamblerEntity.position.y + offsetY),
					i,
					gamblerEntity,
					RNG.int(1e6, ev.entity),
					#tileIndices,
				}
				i = i + 1
			end
		end
		local availableTiles = {}
		for _, entry in ipairs(Utilities.sort(tileIndices, function(l, r)
			if l[2] ~= r[2] then
				return l[2] < r[2]
			elseif l[3].Roulette_gambler.initiative ~= r[3].Roulette_gambler.initiative then
				return l[3].Roulette_gambler.initiative > r[3].Roulette_gambler.initiative
			elseif RouletteUtility.priority(l[3]) ~= RouletteUtility.priority(r[3]) then
				return RouletteUtility.priority(l[3]) > RouletteUtility.priority(r[3])
			elseif l[4] ~= r[4] then
				return l[4] < r[4]
			else
				return l[5] < r[5]
			end
		end)) do
			local tileX, tileY = Tile.unwrapCoordinates(entry[1])
			if not Collision.check(tileX, tileY, alloc.placementMask) then
				table.insert(availableTiles, { tileX, tileY, entry[3] })
			end
		end

		local amount = math.min(baseAmount, #availableTiles) * math.floor((RouletteUtility.countPlayerNumberFromGamblerIDs(judge.gamblers) + 1) / 2)
		for i = 1, amount do
			local entry = availableTiles[i]
			if not entry then
				break
			end

			local gamblerEntity = entry[3]
			itemGenOwnerGambler = gamblerEntity

			alloc.generationIndex = alloc.generationIndex + 1
			generateChoice.seed = Random.noise3(alloc.generationIndex, ev.entity.id, seed, 2 ^ 53 - 1)

			IsPlacingItemsSet[ev.entity.id] = true
			PlaceItemDelayed(ev.entity, {
				type = EntityGeneration.choice(generateChoice),
				x = entry[1],
				y = entry[2],
				owner = gamblerEntity.id,
				endPlacing = (i == amount) and ev.entity.id,
			}, i / 3)
		end
	end

	--- @param index integer
	--- @param id Entity.ID gambler entity id
	--- @param x integer gambler entity position x
	--- @param y integer gambler entity position y
	--- @param component Component.Roulette_gambler
	local function placeItemsPerGambler(index, id, x, y, component)
		local amount = math.floor(baseAmount * component.itemDistributionMultiplier + .5)
		if judge.round == 1 then
			amount = amount + alloc.bonus * (index - 1)
		end

		local tileIndices = {}
		for offsetX, offsetY in RouletteUtility.iterateOffsetsInRange(component.placementRange) do
			tileIndices[#tileIndices + 1] = Tile.reduceCoordinates(x + offsetX, y + offsetY)
		end
		local availableTiles = {}
		for _, tileIndex in ipairs(RNG.shuffle(tileIndices, ev.entity)) do
			local tileX, tileY = Tile.unwrapCoordinates(tileIndex)
			if not Collision.check(tileX, tileY, alloc.placementMask) then
				table.insert(availableTiles, { tileX, tileY })
			end
		end

		amount = math.min(amount, #availableTiles)
		for i = 1, amount do
			alloc.generationIndex = alloc.generationIndex + 1
			generateChoice.seed = Random.noise3(alloc.generationIndex, ev.entity.id, seed, 2 ^ 53 - 1)

			IsPlacingItemsSet[ev.entity.id] = true
			PlaceItemDelayed(ev.entity, {
				type = EntityGeneration.choice(generateChoice),
				x = availableTiles[i][1],
				y = availableTiles[i][2],
				owner = id,
				endPlacing = (i == amount) and ev.entity.id,
			}, i / 3)
		end
	end

	if alloc.teamBased then
		local entities = Utilities.removeIf(RouletteUtility.getEntitiesFromIDs(judge.gamblers), function(entity)
			return not (entity.Roulette_gambler and entity.position) or not not entity.Roulette_gamblerNoItemAllocation
		end)
		for _, gamblerTeam in ipairs(Utilities.sort(RouletteUtility.entitiesGamblerTeamList(entities))) do
			placeItemsPerTeam(entities, gamblerTeam)
		end
	else
		for index, entityID in ipairs(judge.gamblers) do
			local gamblerEntity = getEntityByID(entityID)
			if gamblerEntity and gamblerEntity.Roulette_gambler and gamblerEntity.position and not gamblerEntity.Roulette_gamblerNoItemAllocation then
				itemGenOwnerGambler = gamblerEntity
				placeItemsPerGambler(index, gamblerEntity.id, gamblerEntity.position.x, gamblerEntity.position.y, gamblerEntity.Roulette_gambler)
			end
		end
	end
end)

RouletteItem.ChannelConditionalDamage = RNG.Channel.extend "Roulette_ItemConditionalDamage"

event.objectSpawn.add("itemUseConditionalDamageLaterRandomActivation", {
	filter = "Roulette_itemUseConditionalDamageLater",
	order = "facing",
}, function(ev)
	local component = ev.entity.Roulette_itemUseConditionalDamageLater
	component.active = RNG.roll(component.chance, RouletteItem.ChannelConditionalDamage)
end)

event.objectTryCollectItem.add("selectableItemBanPickup", {
	filter = "Roulette_selectable",
	order = "override",
}, function(ev) --- @param ev Event.ObjectTryCollectItem
	if ev.entity.Roulette_selectable.belonging ~= 0 then
		ev.result = ItemPickup.Result.FAILURE
	end
end)

return RouletteItem
