--- @meta

local Weapon = {}

--- @class Weapon.Pattern.Offset
--- @field [1] integer X offset
--- @field [2] integer Y offset

--- @class Weapon.Pattern.Tile
--- @field offset? Weapon.Pattern.Offset Relative offset between the attacker and the target tile
--- @field clearance? Weapon.Pattern.Offset[] List of tiles that must be non-solid for this tile to be targeted
--- @field targetFlags? Attack.Flag Bitmask of attack flags for deciding whether to attack at all
--- @field attackFlags? Attack.Flag Bitmask of attack flags for deciding whether an ongoing attack should hit this tile
--- @field damageMultiplier? number Multiplier to apply to the weapon's base damage for this tile
--- @field direction? Action.Direction Relative attack direction, assuming a right-oriented attack
--- @field knockback? integer Number of tiles to knock back targets on this tile
--- @field damageType? Damage.Flag Damage type to apply when targeting this tile
--- @field multiHit? boolean If true, allows further entities to be hit past any targets on this tile

return Weapon
