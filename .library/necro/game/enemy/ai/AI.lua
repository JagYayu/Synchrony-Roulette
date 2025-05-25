--- @meta

local AI = {}

--- @enum AI.Type
AI.Type = {
	--- - Generic AIs
	--- No movement
	IDLE = 0,
	--- Always move forward (in the current facing direction)
	LINEAR = 1,
	--- Perform a repeating sequence of movements, advancing only on success
	PATTERN = 2,
	--- Move in a random non-blocked direction
	RANDOM = 3,
	--- Maximize L2 distance with the AI target
	FLEE = 4,
	--- Minimize L1 distance with the AI target, prefer moving on ties
	SEEK = 5,
	--- Minimize L1 distance with the AI target, prefer standing still on ties
	SEEK_LAZY = 6,
	--- Move towards the AI target orthogonally, preferring to move along the same axis for as long as possible
	SEEK_BIASED = 7,
	--- - Enemy-specific AIs
	--- Copy movements of the AI target, inverted
	CLONE = 8,
	--- Move towards the AI home tile orthogonally
	GO_HOME = 9,
	--- Move towards the AI target orthogaonally, favoring horizontal and avoiding non-liquids
	LIQUID_SEEK = 10,
	--- Goblin digger AI
	FLEE_DIGGING = 11,
	--- DB AI for phase 1
	DB_PHASE1 = 12,
	--- DR AI for phase 1
	SEEK_L2 = 13,
	Sync_Mannequin = 14,
	CONDUCTOR_PHASE2 = 15,
	CR_PHASE1 = 16,
	DM_PHASE4 = 17,
	PAWN = 18,
	LUTE_BODY = 19,
	LUTE_HEAD = 20,
	ND2_PHASE2 = 21,
}

AI.orthogonals = {
	[4] = 1,
	[2] = 3,
	[1] = 5,
	[3] = 7,
}

AI.diagonals = {
	[2] = 2,
	[4] = 4,
	[3] = 6,
	[1] = 8,
}

AI.allDirections = {
	[7] = 1,
	[6] = 2,
	[4] = 3,
	[1] = 4,
	[2] = 5,
	[3] = 6,
	[5] = 7,
	[8] = 8,
}

--- Aliases for convenience and backwards compatibility
AI.classic = {
}

AI.defaultMovementMap = {
	[4] = { -1, -1 },
	[5] = { -1, 0 },
	[6] = { -1, 1 },
	[3] = { 0, -1 },
	[7] = { 0, 1 },
	[2] = { 1, -1 },
	[1] = { 1, 0 },
	[8] = { 1, 1 },
}

function AI.getChargeDirection(entity, maxDistance, usePrevPos, directions, mask) end

function AI.getCollisionMask(entity) end

--- Try to find an unblocked movement, defaulting to the first move (or IDLE if specified)
function AI.tryMoves(entity, moves, mask, fallbackMask) end

function AI.getAction(entity, target) end

function AI.classic.SEEK_ORTHOGONAL() end

function AI.classic.SEEK_DIAGONAL() end

function AI.classic.SEEK_8WAY() end

function AI.classic.FLEE_8WAY() end

return AI
