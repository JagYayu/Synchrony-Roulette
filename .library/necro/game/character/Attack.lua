--- @meta

local Attack = {}

Attack.Flag = {
	--- Entities without attackability flags cannot be targeted by any kind of attack.
	NONE = 0,
	--- Bitwise combination of all possible flags. Can be used to remove all attackability flags from an entity.
	ALL = -1,
	--- Attack execution flag.
	--- Most attacks set this flag. It is also set while detecting targets directly adjacent to the player.
	--- Most characters and crates use this flag.
	DEFAULT = 1,
	--- [nodoc] Deprecated alias of DEFAULT
	DIRECT = 1,
	--- Weapon attack check flag.
	--- This flag is set while detecting targets in range of a player's weapon attack.
	--- Most characters use this flag, whereas crates omit it.
	CHARACTER = 2,
	--- [nodoc] Deprecated alias of CHARACTER
	INDIRECT = 2,
	--- Provocative attack flag.
	--- All non-weapon attacks (except Holy Water and Lunging), weapon throws and gun-type ranged weapons set this flag.
	--- Friendly NPCs such as shopkeepers use this flag if they have not yet been hit.
	PROVOKE = 4,
	--- Incorporeal attack flag.
	--- The only attack to set this flag is the Dagger of Phasing.
	--- "Hidden" entities such as phased-out ghosts, underground moles and sleeping mimics use this flag.
	PHASING = 8,
	--- Explosion collateral damage flag.
	--- Only explosions set this flag.
	--- Shrines and unactivated mimics use this flag.
	EXPLOSIVE = 16,
	--- Undead vulnerability flag.
	--- Only Holy Water and Scroll of Need's damage effects set this flag.
	--- All enemies, excluding NPCs (even after being hit), use this flag.
	UNDEAD = 32,
	--- Trap trigger flag.
	--- Most ground traps set this flag.
	--- All grounded lightweight entities use this flag.
	TRAP = 64,
	--- Kick vulnerability flag.
	--- Eli's innate kick sets this flag.
	--- Lit bombs use this flag.
	KICK = 128,
	--- Earthquake vulnerability flag.
	--- Only set by earthquake scroll and DR’s hammer.
	--- By default used by grounded enemies, with some exceptions (like CR)
	EARTHQUAKE = 256,
	--- Pain vulnerability flag.
	--- Boots of pain set this flag.
	--- Non-gargoyle cratelikes use this flag.
	PAIN = 512,
	--- Set by player-controlled entities.
	--- Lobby triggers use this flag.
	PLAYER_CONTROLLED = 1024,
	--- Attacks with this flag will target entities of the same team.
	--- Certain spells, miniboss trampling attacks and Ogre club smashes set this flag.
	--- This is a special flag handled separately, it should never be set in the attackability field.
	IGNORE_TEAM = 1073741824,
}

Attack.FlagGroup = {
	--- Combination of attack flags that affects all enemies. Typically used for spells (Freeze, Earth, etc.)
	SPELL = 13,
}

function Attack.isAttackable(attacker, target, flags) end

function Attack.updateAttackability(entity) end

function Attack.applyAttackabilityComponent(ev, component) end

function Attack.getAttackableEntitiesOnTile(attacker, x, y, flags) end

function Attack.firstAttackableEntityOnTile(attacker, x, y, flags) end

function Attack.hasAttackableEntitiesOnTile(attacker, x, y, flags) end

--- Causes the specified entity to attempt to perform an attack in the specified direction.
--- Returns the attack’s result (action.Result value or nil)
function Attack.perform(entity, direction) end

--- Attack all attackable entities on a tile.
--- `options` is a table with fields:
--- 
--- * targets: list of attack targets (default: all attackable entities on the tile)
--- * noSwipe: boolean, if true omit the attack swipe
--- * damageMultiplier: number, multiplies damage dealt (default: 1)
function Attack.performInnateAttackAt(attacker, x, y, options) end

--- Attack a specific entity. Using Attack.performInnateAttackAt instead is recommended.
function Attack.performInnateAttack(attacker, victim, noSwipe, damageMultiplier) end

return Attack
