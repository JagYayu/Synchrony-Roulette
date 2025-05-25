--- @meta

local EnemySubstitutions = {}

EnemySubstitutions.Type = {
	SHRINE_WAR = 1,
	ITEM_PEACE = 2,
	DOWNGRADE_BATS = 3,
	NO_BLADEMASTERS = 4,
	ARIA = 5,
	TEMPO = 6,
	Sync_NO_ORCS = 7,
}

function EnemySubstitutions.pickUpgrade(objectType, upgradeType) end

--- Adds a substitution for the specified enemy type definition.
--- Must be called at schema load time, typically within `event.entitySchemaLoadEnemy` or similar.
--- @param entity Entity Entity prototype at schema load time
--- @param substitutionType EnemySubstitutions.Type The type of substitution to apply
--- @param target Entity.Type Entity type name to substitute this enemy by
function EnemySubstitutions.add(entity, substitutionType, target) end

--- Performs all applicable substitution on an enemy that is about to spawn.
--- Such substitutions can include Ring of Peace, Shrine of War, and character-specific enemy pool replacements.
--- @param enemyType Entity.Type Enemy type being spawned
--- @return Entity.Type substitute The resulting enemy type after applying all substitutions
function EnemySubstitutions.apply(enemyType) end

--- [nodoc] 2.59-accuracy sadness
function EnemySubstitutions.applyButSkipPeace(enemyType) end

return EnemySubstitutions
