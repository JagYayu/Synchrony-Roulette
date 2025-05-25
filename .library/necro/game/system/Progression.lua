--- @meta

local Progression = {}

Progression.UnlockType = {
	--- Opens the door to a Lobby NPC's room.
	--- Unlocked by opening the NPC's cage in a single-zone run.
	LOBBY_NPC = 1,
	--- Allows an item to spawn in single-zone mode
	--- Unlocked by purchasing the item using diamonds in the lobby.
	ITEM_POOL = 2,
	--- Prevents an item from spawning in single-zone mode.
	--- Unlocked by interacting with the Janitor.
	--- Removed by stepping on the "RESET" tile in the Janitor's room.
	ITEM_POOL_EXCLUSION = 3,
	--- Adds initial equipment to the player's starting inventory for a single run.
	--- Unlocked by purchasing the item from the Diamond Dealer.
	--- Removed after starting a single-zone run.
	ITEM_GRANT_ONCE = 4,
	--- Adds initial equipment to the player's items on every run start.
	--- Unlocked by purchasing permanent upgrades from the Dungeon Master.
	ITEM_GRANT_PERMANENT = 5,
	--- Forces an item to spawn in the chest item pool if it was just freshly unlocked.
	--- Unlocked alongside ITEM_POOL.
	--- Removed when the item was successfully force-spawned.
	ITEM_FORCE_SPAWN = 6,
	--- Opens the staircase leading to this enemy type's training mode.
	--- Unlocked when a regular enemy is defeated for the first time, when the miniboss cost is paid, or when
	--- encountering a story boss for the first time.
	ENEMY_TRAINING = 7,
	--- Opens the staircase for a specific character in the character selection room.
	--- Unlocked by reaching zones or completing runs with specific characters.
	PLAYABLE_CHARACTER = 8,
	--- Removes the "NEW!" label in front of an NPC's room.
	--- Unlocked by entering the NPC's room in the lobby.
	LOBBY_NPC_VISITED = 9,
	--- For weapons, adds a weapon type to the weaponmaster.
	--- For diamond hoards, prevents them from spawning again.
	--- Unlocked by picking up an item.
	ITEM_USED = 10,
	--- Opens the staircase to single-zones depth 2 for a character.
	--- Unlocked by clearing depth 1 with that character.
	DEPTH_2 = 11,
	--- Opens the staircase to single-zones depth 3 for a character.
	--- Unlocked by clearing depth 2 with that character.
	DEPTH_3 = 12,
	--- Opens the staircase to single-zones depth 4 for a character.
	--- Unlocked by clearing depth 3 with that character.
	DEPTH_4 = 13,
	--- Grants an item for training runs.
	--- Unlocked by picking up a training weapon in the lobby.
	ITEM_GRANT_TRAINING = 14,
	--- Allows a specific extra mode to be played.
	--- Unlocked via mode-specific conditions.
	EXTRA_MODE = 15,
}

function Progression.setUnlocked(unlockType, name, unlocked) end

function Progression.lock(unlockType, name) end

function Progression.unlock(unlockType, name) end

function Progression.isUnlocked(unlockType, name) end

function Progression.isLocked(unlockType, name) end

function Progression.isLocallyUnlocked(unlockType, name) end

function Progression.isCharacterUnlocked(name) end

function Progression.isZoneOrderReversed() end

function Progression.getDepthUnlockType(depth) end

function Progression.isZoneUnlocked(zone) end

function Progression.getAllUnlocks(unlockType) end

function Progression.hasAnyUnlock(unlockType) end

function Progression.setUserDiamondCount(count) end

function Progression.getUserDiamondCount() end

function Progression.isPersistable() end

function Progression.setPersistable(persistable) end

function Progression.persist(silent) end

function Progression.isEnabled() end

function Progression.uploadResource() end

function Progression.clearResource() end

function Progression.isTrainingItemGrantActive() end

function Progression.setTrainingItem(item) end

return Progression
