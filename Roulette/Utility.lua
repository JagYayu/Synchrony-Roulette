local RouletteGambler = require "Roulette.Gambler"
local RouletteJudge = require "Roulette.Judge"
local RouletteUtility = {}

local Character = require "necro.game.character.Character"
local CurrentLevel = require "necro.game.level.CurrentLevel"
local ECS = require "system.game.Entities"
local Input = require "system.game.Input"
local Render = require "necro.render.Render"
local StringHash = require "system.utils.StringHash"
local TransformationMatrix = require "system.gfx.TransformationMatrix"
local Utilities = require "system.utils.Utilities"

local TILE_SIZE = 24
local abs = math.abs
local acos = math.acos
local bxor = bit.bxor
local clamp = Utilities.clamp
local getEntityByID = ECS.getEntityByID
local floor = math.floor
local max = math.max
local min = math.min
local sqrt = math.sqrt
local stringByte = string.byte

--- @generic T
--- @param tbl T[]
--- @param value T
--- @return integer
function RouletteUtility.arrayCount(tbl, value)
	local count = 0

	for _, v in ipairs(tbl) do
		count = count + (v == value and 1 or 0)
	end

	return count
end

--- @generic T
--- @param tbl T[]
--- @param func fun(value: T, index: integer): boolean?
--- @return integer
function RouletteUtility.arrayCountIf(tbl, func)
	local count = 0

	for i, v in ipairs(tbl) do
		count = count + (func(v, i) and 1 or 0)
	end

	return count
end

--- @generic T
--- @param tbl T[]
--- @param value any?
--- @param end_ integer?
--- @param begin_ integer?
--- @return T[]
function RouletteUtility.arrayFill(tbl, value, end_, begin_)
	for i = begin_ or 1, end_ or #tbl do
		tbl[i] = value
	end

	return tbl
end

function RouletteUtility.condition(cond, trueVal, falseVal)
	if cond ~= nil then
		return trueVal
	else
		return falseVal
	end
end

function RouletteUtility.countPlayerNumberFromGamblerIDs(gamblerIDs)
	local count = 0

	for _, id in ipairs(gamblerIDs) do
		local entity = ECS.getEntityByID(id)
		count = count + (entity and entity.controllable and entity.controllable.playerID ~= 0 and 1 or 0)
	end

	return count
end

function RouletteUtility.entitiesGamblerTeamList(entities)
	local set = {}
	if type(entities[1]) == "table" then
		for _, entity in ipairs(entities) do
			if entity.Roulette_gambler then
				set[entity.Roulette_gambler.team] = true
			end
		end
	elseif type(entities[1]) == "number" then
		for _, entityID in ipairs(entities) do
			local entity = ECS.getEntityByID(entityID)
			if entity and entity.Roulette_gambler then
				set[entity.Roulette_gambler.team] = true
			end
		end
	end

	local list = {}
	for id in pairs(set) do
		list[#list + 1] = id
	end
	return list
end

--- @param gamblers Entity.ID[] | Entity[]
--- @return boolean
function RouletteUtility.entitiesHasMultipleTeam(gamblers)
	local flag

	if type(gamblers[1]) == "table" then
		for _, entity in ipairs(gamblers) do
			if entity.team then
				if flag then
					if entity.team.id ~= flag then
						return true
					end
				else
					flag = entity.team.id
				end
			end
		end
	elseif type(gamblers[1]) == "number" then
		for _, entityID in ipairs(gamblers) do
			local entity = ECS.getEntityByID(entityID)
			if entity and entity.team then
				if flag then
					if entity.team.id ~= flag then
						return true
					end
				else
					flag = entity.team.id
				end
			end
		end
	end

	return false
end

--- @param gamblers Entity.ID[] | Entity[]
--- @return integer
function RouletteUtility.gamblersRealTeamCount(gamblers)
	local set = {}
	local count = 0

	if type(gamblers[1]) == "table" then
		for _, entity in ipairs(gamblers) do --- @cast entity Entity
			local team = RouletteGambler.getTemporaryTeam(entity)
			if not set[team] then
				set[team] = true
				count = count + 1
			end
		end
	elseif type(gamblers[1]) == "number" then
		for _, entityID in ipairs(gamblers) do
			local entity = ECS.getEntityByID(entityID)
			local team = entity and RouletteGambler.getTemporaryTeam(entity)
			if team and not set[team] then
				set[team] = true
				count = count + 1
			end
		end
	end

	return count
end

--- @param entityIDs Entity.ID[]
--- @return Entity[]
function RouletteUtility.getEntitiesFromIDs(entityIDs)
	local entities = Utilities.newTable(#entityIDs, 0)
	for _, entityID in ipairs(entityIDs) do
		entities[#entities + 1] = getEntityByID(entityID)
	end
	return entities
end

--- @param entities Entity[]
--- @return Entity[]
function RouletteUtility.getEntityIDFromEntities(entities)
	local entityIDs = Utilities.newTable(#entities, 0)
	for _, entity in ipairs(entities) do
		entityIDs[#entityIDs + 1] = entity.id
	end
	return entityIDs
end

function RouletteUtility.getTilePositionUnderMouse()
	return RouletteUtility.screen2tile(Input.mouseX(), Input.mouseY())
end

do
	local encodeSeed = 0
	local encodeStringCharListCache = {}
	local encodeStringChars = {
		".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ",", ",", ",",
		"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "?", "?", "?",
		"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
		"N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
		"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
		"n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z",
	}

	function RouletteUtility.encodeString(str)
		local hash = bxor(StringHash.hash32(str), encodeSeed)
		for i = 1, #str do
			encodeStringCharListCache[i] = encodeStringChars[(stringByte(str, i) * hash) % #encodeStringChars + 1]
		end

		str = table.concat(encodeStringCharListCache)
		Utilities.clearTable(encodeStringCharListCache)
		return str
	end

	event.gameStateLevel.add("encodeStringSeed", "resetLevelVariables", function()
		encodeSeed = tonumber(CurrentLevel.getSeed()) or 0
	end)
end

--- @type function
RouletteUtility.emptyFunction = function() end

RouletteUtility.emptyTable = setmetatable({}, {
	__index = function()
	end,
	__newindex = function()
	end,
})

--- Check if entity1 is behind entity2 in gambler queue
--- @param entity1 Entity
--- @param entity2 Entity
--- @return boolean?
function RouletteUtility.isGamblerBehind(entity1, entity2)
	local judgeEntity = RouletteJudge.getFromGamblerEntity(entity1)
	if judgeEntity and entity2.Roulette_gambler and judgeEntity.id == entity2.Roulette_gambler.judge then
		local i1 = Utilities.arrayFind(judgeEntity.Roulette_judge.gamblers, entity1.id)
		local i2 = Utilities.arrayFind(judgeEntity.Roulette_judge.gamblers, entity2.id)
		if i1 and i2 then
			return i1 > i2
		end
	end
end

do
	local range_
	local squareRange_
	local s_
	local x_
	local y_
	local function impl()
		repeat
			if x_ >= range_ then
				if y_ >= range_ then
					return
				else
					y_ = y_ + 1
					x_ = s_
				end
			else
				x_ = x_ + 1
			end
		until x_ * x_ + y_ * y_ <= squareRange_

		return x_, y_
	end

	function RouletteUtility.iterateOffsetsInRange(range)
		if range < 0 then
			return RouletteUtility.emptyFunction
		end

		range_ = range
		squareRange_ = range * range
		s_ = -floor(range)
		y_ = s_
		x_ = s_ - 1
		return impl
	end
end

---@param x number @x position of point
---@param y number @y position of point
---@param x1 number @x position of line component of point 1
---@param y1 number @y position of line component of point 1
---@param x2 number @x position of line component of point 2
---@param y2 number @y position of line component of point 2
---@return number @square distance
function RouletteUtility.pointToLineSquareDistance(x, y, x1, y1, x2, y2)
	local a = y2 - y1
	local b = x1 - x2
	local c = x2 * y1 - x1 * y2
	return abs(a * x + b * y + c) / (a * a + b * b)
end

function RouletteUtility.priority(entity)
	return entity.priority and entity.priority.value or (Character.Priority.BOMB * 2)
end

function RouletteUtility.resetField(entity, component, field)
	entity[component][field] = ECS.getEntityPrototype(entity.name)[component][field]
end

function RouletteUtility.screen2tile(x, y)
	x, y = RouletteUtility.screen2world(x, y)
	return floor(x / TILE_SIZE + .5), floor(y / TILE_SIZE + .5)
end

function RouletteUtility.screen2world(x, y)
	return TransformationMatrix.inverse( --- @diagnostic disable-next-line: undefined-field
		Render.getTransform(Render.Transform.CAMERA)).transformPoint(x, y)
end

function RouletteUtility.sweepIn(factor)
	factor = 1 - factor

	return factor * factor * factor
end

function RouletteUtility.vectorAngle(x1, y1, x2, y2)
	return acos(clamp(-1, (x1 * x2 + y1 * y2) / (sqrt(x1 * x1 + y1 * y1) * sqrt(x2 * x2 + y2 * y2)), 1))
end

return RouletteUtility
