--- @meta

local Wire = {}

--- @class Wire.QueueEntry
--- @field victim Entity an entity from which the electric arc should start
--- @field x integer saved position of the victim
--- @field y integer saved position of the victim
--- @field distance? integer distance to the victim (defaults to 0)
--- @field direction Action.Direction direction used for swipes and damage on this entity
--- @field dealDamage boolean if true, this entity is dealt electric damage

Wire.Connectivity = {
	[1] = 1,
	[7] = 2,
	[5] = 4,
	[3] = 8,
}

function Wire.computeConnectivity(x, y) end

function Wire.updateWireLevel(entity) end

function Wire.tileFlash(x, y, attacker) end

function Wire.buildElectricityQueue(targets) end

function Wire.handleConductorWires(attacker, electricityQueue) end

--- @param attacker Entity responsible for starting the electric arc
--- @param electricityQueue Wire.QueueEntry[]
--- @param wireLevel integer amount of damage to deal to each victim
function Wire.electricArc(attacker, electricityQueue, wireLevel) end

function Wire.getConnectivity(x, y) end

function Wire.setFrameY(x, y, frameY) end

--- @return table<integer, integer> wireMap
--- @return table<integer, integer> wireVisualMap
--- @return table<integer, integer> wireFrameY
function Wire.getAll() end

return Wire
