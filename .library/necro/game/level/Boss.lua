--- @meta

local Boss = {}

Boss.Type = {
	NONE = 0,
	KING_CONGA = 1,
	DEATH_METAL = 2,
	DEEP_BLUES = 3,
	CORAL_RIFF = 4,
	DEAD_RINGER = 5,
	NECRODANCER = 6,
	NECRODANCER_2 = 7,
	GOLDEN_LUTE = 8,
	FORTISSIMOLE = 9,
	FRANKENSTEINWAY = 10,
	CONDUCTOR = 11,
}

function Boss.startFight() end

function Boss.isFinalBoss() end

function Boss.prepareEnemy(entity, caster) end

function Boss.summon(objectType, x, y, attributes, caster) end

function Boss.summonNearby(params) end

function Boss.getNearestBoss(x, y) end

function Boss.isPreBossFreezeActive() end

function Boss.isPending() end

function Boss.isDead() end

function Boss.isFlawless() end

function Boss.setFlawless(flawless) end

function Boss.removePillars() end

function Boss.getTopBorderY() end

return Boss
