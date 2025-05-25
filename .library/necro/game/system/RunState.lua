--- @meta

local RunState = {}

--- @alias RunState table<RunState.Attribute,any>

RunState.Attribute = {
	LEPRECHAUN_SPAWNED = "leprechaunSpawned",
	SHOPKEEPER_DEAD = "shopkeeperDead",
	SHOPKEEPER_GHOST_DEPTH = "shopkeeperGhostDepth",
	SHOPKEEPER_GHOST_FLOOR = "shopkeeperGhostLevel",
	WIN_COUNT = "winCount",
	MULTI_CHARARACTER_NEXT = "multiCharNext",
	MULTI_CHARARACTER_CHOICES = "multiCharChoices",
	SHRINE_DARKNESS = "darknessShrineActive",
	SHRINE_SPACE = "spaceShrineActive",
	SHRINE_WAR = "warShrineActive",
	SHRINE_BOSS = "bossShrineActive",
	ITEM_ACTIVE_RING_WAR = "warRingActive",
	ITEM_ACTIVE_RING_PEACE = "peaceRingActive",
	BONUS_CHEST_RED = "addChestRed",
	BONUS_CHEST_BLACK = "addChestBlack",
	BONUS_CHEST_PURPLE = "addChestWhite",
	GENERATED_LOCKED_SHOP = "lockedShopPlaced",
	GENERATED_VAULT = "secretRockRoomPlaced",
	GENERATED_URN = "urnPlaced",
}

function RunState.makeInitial(characters, mode, prevState) end

function RunState.updateForLevelTransition(state) end

function RunState.modifyState(stateChange) end

function RunState.getState() end

function RunState.get(key) end

function RunState.set(key, value) end

function RunState.reset(initialCharacters) end

return RunState
