--- MAY NOT USE
local RouletteCoinMultiplier = {}

local max = math.max

do
	local function get(list, index)
		local len = #list
		return index > len and list[len] or list[index] or list[1] or 1
	end

	function RouletteCoinMultiplier.getMultiplier(entity)
		local coin = entity.Roulette_coinMultiplier
		return coin and max(1, get(coin.trickMultipliers, coin.trick), get(coin.trickMultipliers, coin.trick)) or 1
	end
end

return RouletteCoinMultiplier
