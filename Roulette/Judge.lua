local RouletteDelayEvents = require "Roulette.DelayEvents"
local RouletteJudge = {}
local RouletteUtility = require "Roulette.Utility"

local Action = require "necro.game.system.Action"
local ECS = require "system.game.Entities"
local EntitySelector = require "system.events.EntitySelector"
local Enum = require "system.utils.Enum"
local Health = require "necro.game.character.Health"
local Move = require "necro.game.system.Move"
local Object = require "necro.game.object.Object"
local RNG = require "necro.game.system.RNG"
local Utilities = require "system.utils.Utilities"

local getEntityByID = ECS.getEntityByID

RouletteJudge.Flag = Enum.bitmask {
	Started = 1,
	NextTurn = 2,
	NextRound = 3,
}

local JudgeFlagStarted = RouletteJudge.Flag.Started
local JudgeFlagNextTurn = RouletteJudge.Flag.NextTurn
local JudgeFlagNextRound = RouletteJudge.Flag.NextRound
local JudgeFlagCheck = RouletteJudge.Flag.check
local JudgeFlagMask = RouletteJudge.Flag.mask
local JudgeFlagUnmask = RouletteJudge.Flag.unmask

--- @param judge Component.Roulette_judge
function RouletteJudge.hasStarted(judge)
	return JudgeFlagCheck(judge.flags, JudgeFlagStarted)
end

--- @param judge Component.Roulette_judge
function RouletteJudge.isProcessingNextTurn(judge)
	return JudgeFlagCheck(judge.flags, JudgeFlagNextTurn)
end

--- @param judge Component.Roulette_judge
function RouletteJudge.isProcessingNextRound(judge)
	return JudgeFlagCheck(judge.flags, JudgeFlagNextRound)
end

--- @param gamblerEntity Entity
--- @return Entity?
function RouletteJudge.getFromGamblerEntity(gamblerEntity)
	if gamblerEntity.Roulette_gambler then
		local judgeEntity = getEntityByID(gamblerEntity.Roulette_gambler.judge)
		if judgeEntity and judgeEntity.Roulette_judge then
			return judgeEntity
		end
	end
end

local getFromGamblerEntity = RouletteJudge.getFromGamblerEntity

--- @param entity Entity
--- @return Component.Roulette_judge?
function RouletteJudge.getJudgeFromGamblerEntity(entity)
	local judgeEntity = getFromGamblerEntity(entity)
	if judgeEntity then
		return judgeEntity.Roulette_judge
	end
end

--#region Next Turn

local sequenceJudgeNextTurnSend = RouletteDelayEvents.register("Roulette_sequenceJudgeNextTurn", {
	"beginFlag",
	"turn",
	"endTurn",
	"ai",
	"nextGambler",
	"beginTurn",
	"text",
	"endFlag",
}, { -- 2.0s
	2,
}, {
	---@param entity Entity
	---@param parameter DelayEvent.SequenceJudgeNextTurnParameter
	---@return Event.Roulette_sequenceJudgeNextTurn
	eventBuilder = function(entity, parameter)
		--- @class DelayEvent.SequenceJudgeNextTurnParameter : DelayEvent.Parameter
		--- @field gamblerTurnSkipped true?
		--- @field nextTurn nil @Field `nextTurn` does nothing and idk why I put it before xD

		--- @class Event.Roulette_sequenceJudgeNextTurn
		--- @field entity Entity
		--- @field component Component.Roulette_judge
		--- @field parameter DelayEvent.SequenceJudgeNextTurnParameter?
		local ev = {
			entity = entity,
			component = entity.Roulette_judge,
			parameter = parameter,
		}
		return ev
	end,
	-- Since `event.Roulette_judgeNextTurn` was used before, which has no delay and executes instantly. We make it as an alias for compatibility.
	eventTypeAlias = { event.Roulette_judgeNextTurn },
	flags = { unique = true },
})

--- @param ev Event.Roulette_sequenceJudgeNextTurn
event.Roulette_sequenceJudgeNextTurn.add("maskFlagNextTurn", "beginFlag", function(ev)
	ev.component.flags = JudgeFlagMask(ev.component.flags, RouletteJudge.Flag.NextTurn)
end)

event.Roulette_judgeNextTurn.add("addTurn", "turn", function(ev)
	ev.component.turn = ev.component.turn + 1
end)

--- @param ev Event.Roulette_sequenceJudgeNextTurn
event.Roulette_judgeNextTurn.add("gamblerNextGamblerIndex", "nextGambler", function(ev)
	if ev.component.gamblerIndex >= #ev.component.gamblers then
		ev.component.gamblerIndex = 1
	else
		ev.component.gamblerIndex = ev.component.gamblerIndex + 1
	end
end)

--- @param ev Event.Roulette_sequenceJudgeNextTurn
event.Roulette_sequenceJudgeNextTurn.add("unmaskFlagNextTurn", "endFlag", function(ev)
	ev.component.flags = JudgeFlagUnmask(ev.component.flags, RouletteJudge.Flag.NextTurn)
end)

--- @param judgeEntity Entity
--- @param parameter DelayEvent.SequenceJudgeNextTurnParameter?
function RouletteJudge.nextTurn(judgeEntity, parameter)
	if judgeEntity.Roulette_judge and not RouletteJudge.isProcessingNextTurn(judgeEntity.Roulette_judge) then
		local gunEntity = getEntityByID(judgeEntity.Roulette_judge.gun)
		if gunEntity and gunEntity.Roulette_gun and not gunEntity.Roulette_gun.bullets[1] then
			--- @cast parameter DelayEvent.SequenceJudgeNextTurnParameter
			RouletteJudge.nextRound(judgeEntity, parameter)
		else
			sequenceJudgeNextTurnSend(judgeEntity, parameter)
		end
	end
end

event.turn.add("processJudgeNextTurns", "nextTurnEffect", function(ev)
	if not ev.Roulette_gamblersTurn then
		return
	end

	for judgeEntity, gamblerEntities in pairs(ev.Roulette_gamblersTurn) do
		local flag = not (RouletteJudge.isProcessingNextTurn(judgeEntity.Roulette_judge) or RouletteJudge.isProcessingNextRound(judgeEntity.Roulette_judge))

		if flag then
			for _, gamblerID in ipairs(judgeEntity.Roulette_judge.gamblers) do
				local gamblerEntity = ECS.getEntityByID(gamblerID)
				if gamblerEntity and gamblerEntity.Roulette_gambler and gamblerEntity.Roulette_gambler.turn then
					flag = false
					break
				end
			end
		end

		if flag then
			RouletteJudge.nextTurn(judgeEntity)
		end
	end
end)

--- @param ev Event.Roulette_gamblerBeginTurn
event.Roulette_gamblerBeginTurn.add("nextTurn", "nextTurn", function(ev)
	if ev.suppressed then
		local judgeEntity = getFromGamblerEntity(ev.entity)
		if judgeEntity then
			RouletteJudge.nextTurn(judgeEntity, {
				delayTimeScale = ev.component.skipTurnDelayTimeScale,
				gamblerTurnSkipped = true,
			})
		end
	end
end)

event.Roulette_sequenceJudgeNextRound2.add("initiatorTurn", {
	filter = "Roulette_judgeNewRoundInitiatorTurn",
	order = "initiativeTurn",
}, function(ev) --- @param ev Event.Roulette_sequenceJudgeNextRound
	ev.parameter.nextTurn = false
	ev.component.gamblerIndex = 0
	RouletteJudge.nextTurn(ev.entity)
end)

--- @param ev Event.Roulette_sequenceJudgeNextRound
event.Roulette_sequenceJudgeNextRound2.add("nextTurn", "nextTurn", function(ev)
	if ev.parameter.nextTurn then
		RouletteJudge.nextTurn(ev.entity)
	end
end)

--#endregion

--#region Next Round

--- @param ev Event.Roulette_itemUse
event.Roulette_itemUse.add("nextRoundOrTurn", "next", function(ev)
	if ev.nextRound then
		local judgeEntity = getFromGamblerEntity(ev.user)
		if judgeEntity then
			RouletteJudge.nextRound(judgeEntity, { nextTurn = ev.skipTurn })
		end
	elseif ev.skipTurn then
		local judgeEntity = getFromGamblerEntity(ev.user)
		if judgeEntity then
			RouletteJudge.nextTurn(judgeEntity)
		end
	end
end)

-- Considering adding `Roulette_sequenceGamblerNextRound`, `Roulette_sequenceCursorNextRound` etc? this is a mess
local sequenceJudgeNextRoundSend = RouletteDelayEvents.register("Roulette_sequenceJudgeNextRound", {
	"beginFlag",
	"round",
	"gun",
	"item",
	"apparition",
	"status",
	"stasis",
	"heal",
	"initiativeTurn",
	"nextTurn",
	"cursor",
	"ai",
	"flyaway",
	"endFlag",
}, {
	1.5, -- gun & stasis.
	2, -- item & nextTurn.
}, {
	--- @param entity Entity
	--- @param parameter DelayEvent.SequenceJudgeNextRoundParameter
	--- @return Event.Roulette_sequenceJudgeNextRound
	eventBuilder = function(entity, parameter)
		--- @class DelayEvent.SequenceJudgeNextRoundParameter : DelayEvent.SequenceJudgeNextTurnParameter
		--- @field nextTurn boolean?

		--- @class Event.Roulette_sequenceJudgeNextRound
		--- @field entity Entity
		--- @field component Component.Roulette_judge
		--- @field parameter { nextTurn: boolean }
		local ev = {
			entity = entity,
			component = entity.Roulette_judge,
			parameter = parameter,
		}
		return ev
	end,
	flags = { unique = true },
})

event.Roulette_sequenceJudgeNextRound.add("maskFlagNextRound", "beginFlag", function(ev)
	ev.component.flags = JudgeFlagMask(ev.component.flags, RouletteJudge.Flag.NextRound)
end)

event.Roulette_sequenceJudgeNextRound.add("addRound", "round", function(ev)
	ev.component.round = ev.component.round + 1
end)

event.Roulette_sequenceJudgeNextRound2.add("unmaskFlagNextRound", "endFlag", function(ev)
	ev.component.flags = JudgeFlagUnmask(ev.component.flags, RouletteJudge.Flag.NextRound)
end)

--- @param entity Entity @The judge entity.
--- @param parameter DelayEvent.SequenceJudgeNextRoundParameter
function RouletteJudge.nextRound(entity, parameter)
	if entity.Roulette_judge and not RouletteJudge.isProcessingNextRound(entity.Roulette_judge) then
		sequenceJudgeNextRoundSend(entity, parameter)
	end
end

event.Roulette_judgeStartGame.add("startRound", "round", function(ev)
	ev.component.round = 0

	RouletteJudge.nextRound(ev.entity, { nextTurn = true })
end)

local function handlerJudgeNextTurnOnGamblerDeath(ev)
	if not ev.entity.Roulette_gambler.turn then
		return
	end

	local judgeEntity = ECS.getEntityByID(ev.entity.Roulette_gambler.judge)
	if judgeEntity then
		RouletteJudge.nextTurn(judgeEntity)
	end
end

event.objectDeath.add("judgeNextTurn", {
	filter = { "Roulette_gambler", "respawn" },
	order = "runState",
}, handlerJudgeNextTurnOnGamblerDeath)

event.objectDespawn.add("judgeNextTurn", {
	filter = { "Roulette_gambler", "respawn" },
	order = "disengage",
}, handlerJudgeNextTurnOnGamblerDeath)

--- @param ev Event.Roulette_sequenceGunShot
event.Roulette_sequenceGunShot5.add("judgeNextRoundOrTurn", "next", function(ev)
	if ev.parameter.continue or not ev.user then
		return
	elseif not ev.user.Roulette_gambler then
		error(("Entity %s#%d does not have component `Roulette_gambler` and it was not supposed to be missing!\
\tDid you convert this entity to another invalid gambler entity type during the match?"):format(ev.user.name, ev.user.id))
	end

	local judgeEntity = ev.user.Roulette_gambler and getEntityByID(ev.user.Roulette_gambler.judge)
	if judgeEntity then
		if #ev.component.bullets == 0 then
			RouletteJudge.nextRound(judgeEntity, {
				nextTurn = ev.parameter.success or (ev.target and ev.user.id ~= ev.target.id)
			})
		else
			RouletteJudge.nextTurn(judgeEntity)
		end
	end
end)

--#endregion

--#region Start Game

local judgeStartGameSelectorFire = EntitySelector.new(event.Roulette_judgeStartGame, {
	"reset",
	"tiles",
	"bot",
	"move",
	"gambler",
	"gun",
	"round",
	"sound",
}).fire

--- @param ev Event.Roulette_judgeStartGame
event.Roulette_judgeStartGame.add("resetFields", "reset", function(ev)
	ev.component.flags = JudgeFlagMask(ev.component.flags, RouletteJudge.Flag.Started)
	ev.component.gamblerIndex = 0
end)

event.Roulette_judgeStartGame.add("fillBots", {
	filter = { "Roulette_judgeFillBots", "position" },
	order = "bot",
}, function(ev) --- @param ev Event.Roulette_judgeStartGame
	local botType = ev.entity.Roulette_judgeFillBots.type
	for index, location in ipairs(ev.component.locations) do
		local x = ev.entity.position.x + (tonumber(location[1]) or 0)
		local y = ev.entity.position.y + (tonumber(location[2]) or 0)

		if not ev.component.gamblers[index] then
			--- @diagnostic disable-next-line: missing-fields
			local botGamblerEntity = Object.spawn(botType, x, y, {
				--- @diagnostic disable-next-line: missing-fields
				Roulette_gambler = { judge = ev.entity.id },
			})

			ev.component.gamblers[index] = botGamblerEntity.id
			ev.gamblerEntities[#ev.gamblerEntities + 1] = botGamblerEntity
		end
	end
end)

event.Roulette_judgeStartGame.add("removeNonexistentGamblers", "gambler", function(ev)
	Utilities.removeIf(ev.component.gamblers, function(gamblerID)
		return not ECS.entityExists(gamblerID)
	end)
end)

event.Roulette_judgeStartGame.add("randomizeOrder", {
	filter = { "Roulette_judgeRandomizeGamblerOrders", "random" },
	order = "gambler",
}, function(ev) --- @param ev Event.Roulette_judgeStartGame
	RNG.shuffle(ev.component.gamblers, ev.entity)
end)

event.Roulette_judgeStartGame.add("spawnGun", {
	filter = { "Roulette_judgeGun", "position" },
	order = "gun",
}, function(ev) --- @param ev Event.Roulette_judgeStartGame
	local x = ev.entity.position.x + ev.component.x
	local y = ev.entity.position.y + ev.component.y
	--- @diagnostic disable-next-line: missing-fields
	local success, entity = pcall(Object.spawn, ev.entity.Roulette_judgeGun.type, x, y, {
		--- @diagnostic disable-next-line: missing-fields
		Roulette_gun = { judge = ev.entity.id }
	})
	if success then
		ev.component.gun = entity.id
	end
end)

--- @param judgeEntity Entity
--- @return Event.Roulette_judgeStartGame?
function RouletteJudge.startGame(judgeEntity)
	if judgeEntity.Roulette_judge and not RouletteJudge.hasStarted(judgeEntity.Roulette_judge) then
		--- @class Event.Roulette_judgeStartGame
		--- @field entity Entity
		--- @field component Component.Roulette_judge
		--- @field gamblerEntities Entity[]
		local ev = {
			entity = judgeEntity,
			component = judgeEntity.Roulette_judge,
			gamblerEntities = RouletteUtility.getEntitiesFromIDs(judgeEntity.Roulette_judge.gamblers),
		}
		judgeStartGameSelectorFire(ev, judgeEntity.name)
		return ev
	end
end

--- @param judgeEntity Entity
function RouletteJudge.tryStartGame(judgeEntity)
	if not judgeEntity.Roulette_judge or not judgeEntity.Roulette_judgeAutoStart
		or RouletteJudge.hasStarted(judgeEntity.Roulette_judge)
		or #judgeEntity.Roulette_judge.gamblers < judgeEntity.Roulette_judgeAutoStart.startMinimumGamblers
		or not judgeEntity.position
	then
		return
	end

	for index, gamblerEntity in ipairs(RouletteUtility.getEntitiesFromIDs(judgeEntity.Roulette_judge.gamblers)) do
		local location = judgeEntity.Roulette_judge.locations[index]
		if location and gamblerEntity.position
			and (gamblerEntity.position.x ~= judgeEntity.position.x + location[1] or gamblerEntity.position.y ~= judgeEntity.position.y + location[2])
		then
			return false
		end
	end

	return RouletteJudge.startGame(judgeEntity)
end

event.turn.add("gamblerStartGame", "lobbyLevel", function(ev)
	if ev.globalActivation then
		for entity in ECS.entitiesWithComponents { "Roulette_judge", "Roulette_judgeAutoStart", "position" } do
			RouletteJudge.tryStartGame(entity)
		end
	end
end)

--#endregion

--#region End Game

local judgeEndGameSelectorFire = EntitySelector.new(event.Roulette_judgeEndGame, {
	"winner",
	"gambler",
	"item",
	"gun",
	"flyaway",
	"reset",
	"statistic",
}).fire

--- @param judgeEntity Entity @The judge entity
--- @return Event.Roulette_judgeEndGame?
function RouletteJudge.endGame(judgeEntity)
	if judgeEntity.Roulette_judge and RouletteJudge.hasStarted(judgeEntity.Roulette_judge) then
		local gamblerEntities = RouletteUtility.getEntitiesFromIDs(judgeEntity.Roulette_judge.gamblers)

		--- @class Event.Roulette_judgeEndGame
		--- @field entity Entity
		--- @field component Component.Roulette_judge
		--- @field gamblerEntities Entity[]
		--- @field winner Entity?
		local ev = {
			entity = judgeEntity,
			component = judgeEntity.Roulette_judge,
			gamblerEntities = gamblerEntities,
			winner = #gamblerEntities == 1 and gamblerEntities[1] or nil,
		}
		judgeEndGameSelectorFire(ev, judgeEntity.name)
		return ev
	end
end

event.Roulette_judgeEndGame.add("teleportGamblers", {
	filter = { "Roulette_judgeEndTeleport", "position" },
	order = "gambler",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_judgeEndGame
	for _, gamblerEntity in ipairs(ev.gamblerEntities) do
		Move.absolute(gamblerEntity, ev.entity.position.x, ev.entity.position.y, Move.Type.TELEPORT)
	end
end)

--- @param ev Event.Roulette_judgeEndGame
event.Roulette_judgeEndGame.add("healGamblers", "gambler", function(ev)
	for _, gamblerEntity in ipairs(ev.gamblerEntities) do
		Health.heal {
			entity = gamblerEntity,
			health = 20,
		}
	end
end)

event.Roulette_judgeEndGame.add("deleteGun", "gun", function(ev)
	local gunEntity = getEntityByID(ev.component.gun)
	if gunEntity then
		Object.delete(gunEntity)
	end
end)

--- @param ev Event.Roulette_judgeEndGame
event.Roulette_judgeEndGame.add("resetFields", "reset", function(ev)
	ev.component.gamblerIndex = 0
	ev.component.gamblers = {}
	ev.component.gun = 0
	ev.component.round = 0
	ev.component.turn = 0
	ev.component.flags = JudgeFlagUnmask(ev.component.flags, RouletteJudge.Flag.Started)
end)

event.objectIntangible.add("endGame", {
	filter = "Roulette_judge",
	order = "character",
}, function(ev)
	RouletteJudge.endGame(ev.entity)
end)

RouletteJudge.WinCondition = Enum.immutable {
	LastOneStand = 1,
	TeamWork = 2,
}

function RouletteJudge.checkEndGameCondition(judgeEntity)
	local winCondition = judgeEntity.Roulette_judge.winCondition
	if winCondition == RouletteJudge.WinCondition.LastOneStand then
		return #judgeEntity.Roulette_judge.gamblers == 1
	elseif winCondition == RouletteJudge.WinCondition.TeamWork then
		return not RouletteUtility.entitiesHasMultipleTeam(judgeEntity.Roulette_judge.gamblers)
	else
		return true
	end
end

--- @param judgeEntity Entity
--- @param gamblerEntity Entity
function RouletteJudge.removeGambler(judgeEntity, gamblerEntity)
	local judge = judgeEntity.Roulette_judge
	if not judge then
		return
	end

	local nextTurn = false

	local index = Utilities.arrayFind(judge.gamblers, gamblerEntity.id)
	if index then
		nextTurn = index == judge.gamblerIndex

		if index <= judge.gamblerIndex then
			judge.gamblerIndex = math.max(judge.gamblerIndex - 1, 0)
		end
		table.remove(judge.gamblers, index)
	end
	judge.gamblerIndex = math.min(judge.gamblerIndex, #judge.gamblers)

	if RouletteJudge.checkEndGameCondition(judgeEntity) then
		RouletteJudge.endGame(judgeEntity)
	elseif nextTurn then
		RouletteJudge.nextTurn(judgeEntity)
	end
end

--- Use `RouletteJudge.removeGambler` instead.
--- @deprecated
RouletteJudge.tryRemoveGambler = RouletteJudge.removeGambler

--#endregion

event.objectDeath.add("judgeRemoveGambler", { filter = "Roulette_gambler", order = "runSummary" }, function() end)

return RouletteJudge
