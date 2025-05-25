--- @meta

local Damage = {}

--- @class Damage.Parameters
--- @field victim Entity Entity to deal damage to (required)
--- @field attacker? Entity Entity dealing damage (will be credited if the damage is fatal)
--- @field entity? Entity Alias for `attacker`
--- @field type? Damage.Type Bitmask of damage flags (defaults to `damage.Type.PHYSICAL`)
--- @field damage integer Amount of damage to inflict
--- @field direction? Action.Direction Direction of the damage (used for directional shields and knockback)
--- @field knockback? integer Number of tiles to knock back the victim
--- @field weapon? Entity Weapon, spell, familiar or bomb using which damage was inflicted (nil for innate attacks)
--- @field silentHit? boolean If set, silences the victim's damage sounds
--- @field silentHitVoice? boolean If set, silences the victim's hit voice
--- @field killerName? string Overrides the "Killed by" text on the run summary screen
--- @field penetration? Damage.Penetration Deprecated legacy field for compatibility with old mods

--- Bitwise flags that can be combined and passed when dealing damage, affecting how the event is handled by the victim.
--- @enum Damage.Flag
Damage.Flag = {
	--- Inflicted by piercing damage sources.
	--- Ignores armors and shields.
	BYPASS_ARMOR = 1,
	--- Inflicted by phasing damage sources.
	--- Ignores player invincibility frames, stasis and similar invincibility mechanics.
	BYPASS_INVINCIBILITY = 2,
	--- Inflicted by Vow of Poverty.
	--- When lethal, ignores some on-death effects, such as the Potion.
	BYPASS_DEATH_TRIGGERS = 4,
	--- Inflicted by most weapon-based attacks.
	--- Damage is increased by damage-ups (e.g. Ring of Might), and can trigger auxiliary effects (e.g. Frost).
	STRENGTH_BASED = 8,
	--- Inflicted by bombs and other explosives.
	--- Damage is increased by bomb upgrades (Grenade Charm, Ring of Mana), and prevented by Blast Helm.
	EXPLOSIVE = 16,
	--- Inflicted by most weapon-based attacks.
	--- Can be parried.
	PARRYABLE = 32,
	--- Inflicted by Blood Magic, Blood Price Tags, Blood Shovel, Blood Drum, Pain items, and certain shrines.
	--- Preserves groove chain, preserves fragile items, doesn't trigger Shrine of Pain, ignores multipliers.
	SELF_DAMAGE = 64,
	--- Inflicted by spells, explosions, and the Golden Lute.
	--- Deals no damage to grabbed entities.
	IGNORE_GRABBED = 128,
	--- Inflicted by Spike Traps.
	--- Is prevented by lead boots.
	TRAP = 256,
	--- Inflicted by Hot Coal tiles and Lava.
	--- Prevented by Explorer's Boots and Winged Boots.
	TERRAIN = 512,
	--- Inflicted by Shovemonsters when squishing their victim.
	--- Causes the damaged entity to use an alternate hit voice line.
	VOICE_SQUISH = 1024,
	--- Inflicted by the Golden Lute.
	--- Can damage the NecroDancer.
	GOLDEN_LUTE = 2048,
	--- Inflicted by the Earthquake Scroll and by Dead Ringer's hammer.
	--- Can activate Dead Ringer's gong.
	EARTHQUAKE = 4096,
	--- Inflicted by enemy splash attacks (Mushrooms, Yetis).
	--- Cannot damage Mary's sheep.
	IGNORE_SHEEP = 8192,
	--- Inflicted by Vow of Poverty.
	--- Ignores the immunity effect granted to players going down the exit stairs.
	BYPASS_IMMUNITY = 16384,
	--- Inflicted by electric arcs.
	--- Depletes the Conductor's batteries.
	ELECTRIC = 32768,
	--- Inflicted by explosions and fireballs.
	--- Melts ice and activates Shrine of Fire.
	FIRE = 65536,
	--- Inflicted by possessors when ejecting from their host.
	--- Does not credit the attacker for kills.
	NO_CREDIT = 131072,
}

--- Deprecated
Damage.Penetration = {
	--- Deprecated
	NONE = 0,
	--- Deprecated
	PIERCING = 1,
	--- Deprecated
	PHASING = 2,
	--- Deprecated
	TRUE = 3,
}

--- Defines bitwise combinations of several damage flags for convenience.
--- @alias Damage.Type Damage.Flag
Damage.Type = {
	--- Damage dealt by weapons or normal enemy attacks.
	PHYSICAL = 40,
	--- Piercing damage (Crossbow, Rifle, Blunderbuss, Frost Dagger, Ring of Piercing)
	PIERCING = 1,
	--- Phasing damage (Dagger of Phasing, Earth Spell, Telefrags)
	PHASING = 3,
	--- Damage dealt by explosions (bombs, Pixies, Goblin Bombers)
	EXPLOSIVE = 65680,
	--- Blood damage (blood magic, blood shop, equipping pain items)
	BLOOD = 67,
	--- Self-damage that doesn't bypass invincibility frames (Aria's missed beats)
	SELF_DAMAGE = 65,
	--- Unpreventable damage resulting in an instant death (Vow of Poverty, Cowardice)
	SELF_DESTRUCT = 16455,
	--- [nodoc] (renaming this to "self-destruct")
	SUICIDE = 16455,
	--- Magic damage (Fireball, Pulse, Need)
	MAGIC = 128,
	--- Weapon-like damage that doesn't benefit from damage-ups (Golden Lute, Boots of Pain)
	INDIRECT = 32,
	--- Damage dealt by a floor trap (spike trap)
	TRAP = 256,
	--- Damage from unconventional sources (Boots of Lunging, trampling minibosses)
	SPECIAL = 0,
	--- Damage from being shoved against a wall
	SQUISHY = 1024,
	--- Damage dealt by earthquakes
	EARTHQUAKE = 4103,
}

--- Inflicts damage to an entity, and returns whether the damage event was successful (not suppressed)
--- @param parameters Damage.Parameters Parameters for the damage infliction event
--- @return boolean success True if damage was dealt, false if the hit was suppressed
function Damage.inflict(parameters) end

--- Returns the amount of damage an entity would inflict if it were to attack with its currently held weapon.
--- Takes all damage-increasing items into account.
--- @param entity Entity
--- @return integer damage Amount of damage this entity inflicts on attacks
function Damage.getBaseDamage(entity) end

function Damage.knockback(entity, direction, distance, moveType, beatDelay) end

return Damage
