--- @meta

local Kill = {}

Kill.Credit = {
	CURRENCY = 1,
	GROOVE_CHAIN = 2,
	SPELL_COOLDOWN = 4,
	REGENERATION = 8,
	DAMAGE_COUNTDOWN = 16,
	INVINCIBILITY = 32,
	DASH = 64,
	ITEM_DROP = 128,
	SOUL = 256,
}

function Kill.disableCredit(entity, mask) end

function Kill.getKillerName(entity) end

return Kill
