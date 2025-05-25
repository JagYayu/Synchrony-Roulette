local RouletteCommonEntities = {}

local Currency = require "necro.game.item.Currency"
local CustomEntities = require "necro.game.data.CustomEntities"
local Move = require "necro.game.system.Move"

function RouletteCommonEntities.makeGambler(entity)
	entity.Roulette_gambler = {}
	entity.Roulette_gamblerBeginTurnHop = {}
	entity.Roulette_gamblerColor = {}
	entity.Roulette_gamblerCursor = {}
	entity.Roulette_gamblerFreezeParticle = {}
	entity.Roulette_gamblerStatusFreeze = {}
	entity.Roulette_gamblerStatusShield = {}
	entity.Roulette_gamblerStatusSilence = {}
	entity.Roulette_gamblerTextBeginTurn = {}
	entity.Roulette_gamblerTextEndTurn = {}
	entity.Roulette_gamblerVibrateEffect = {}
	entity.Roulette_selectable = {}
	entity.Roulette_textOverlay = {}
end

event.entitySchemaLoadEntity.add("gambler", "overrides", function(ev)
	local e = ev.entity
	if e.playableCharacter then
		RouletteCommonEntities.makeGambler(e)

		e.Roulette_gamblerBagRingSwapLimit = {}
		e.Roulette_gamblerDisengage = {}
		e.Roulette_gamblerLuck = {}
		e.Roulette_gamblerNecromancyRevivable = {}
		e.Roulette_gamblerStatusShrink = {}
	end
end)

event.entitySchemaLoadEntity.add("smartCursorTarget", "overrides", function(ev)
	if ev.entity.itemCurrency and (ev.entity.itemCurrency.currencyType == nil or ev.entity.itemCurrency.currencyType == Currency.Type.GOLD) then
		ev.entity.Roulette_smartCursorTarget = {}
	end
end)

--- @diagnostic disable: assign-type-mismatch, missing-fields

CustomEntities.register {
	name = "Roulette_Cursor",

	Roulette_cursor = {},
	Roulette_cursorCollectGold = {},
	Roulette_cursorFlyaway = {},
	Roulette_cursorInteract = {},
	Roulette_cursorSlotLabel = {},
	Roulette_cursorSound = {},

	movable = { moveType = Move.Type.SLIDE },
	position = {},
	positionalSprite = { offsetY = 12 },
	rowOrder = { z = -24 },
	sprite = { texture = "mods/Roulette/gfx/cursor.png" },
	tween = { duration = .097 },
	visibility = {},
}

return RouletteCommonEntities
