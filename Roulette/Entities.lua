local RouletteEntities = {}

--- @deprecated use `require "Roulette.data.CommonEntities".makeGambler` instead.
function RouletteEntities.makeGambler(...)
	return require "Roulette.data.CommonEntities".makeGambler(...)
end

--- @deprecated use `require "Roulette.data.LobbyEntities".registerGamblerShrine` instead.
function RouletteEntities.registerGamblerShrine(...)
	return require "Roulette.data.LobbyEntities".registerGamblerShrine(...)
end

return RouletteEntities
