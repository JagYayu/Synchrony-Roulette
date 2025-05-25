--- @meta

local TileDamage = {}

TileDamage.IdleResult = {
	--- Produce a warning sound without dealing damage and increase the idle counter. This is the default result.
	PENDING = 0,
	--- Do nothing. This result is applied by protective items.
	SUPPRESSED = 1,
	--- Idle counter has exceeded threshold; damage is inflicted.
	DAMAGE = 2,
}

return TileDamage
