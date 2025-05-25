--- Goal-Oriented Action Planner
--- This can file can be safely included by other mods as a necro modding library IN FUTURE.
--- @class Goap
local Goap = {}

--- @alias Goap.Key integer | string

--- @class Goap.Goal
--- @field [1] Goap.Key @id

--- @param id Goap.Key
--- @param states table<Goap.Key, any>
--- @return Goap.Goal
function Goap.goal(id, states)
	return {
		id = id,
		states = states,
	}
end

--- @class Goap.Action

--- @param id Goap.Key
--- @param conditions table<Goap.Key, any>
--- @param satisfies table<Goap.Key, any>
--- @param cost number?
--- @return Goap.Action
function Goap.action(id, satisfies, conditions, cost)
	return {
		id = id,
		satisfies = satisfies,
		conditions = conditions,
		cost = tonumber(cost) or 1,
	}
end

--- @param goals Goap.Goal[] @A list of goal.
--- @param actions Goap.Action[]
--- @param states any
function Goap.plan(goals, actions, states)
	-- TODO
end

return Goap
