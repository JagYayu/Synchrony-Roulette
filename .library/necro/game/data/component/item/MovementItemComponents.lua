--- @meta

local MovementItemComponents = {}

--- Multiplies the distance travelled when the holder voluntarily moves.
--- @class Component.itemMoveAmplifier
--- @field distance integer # `= 1` 
--- @field collisionMask Collision.Type, collision.mask(collision.Type.WALL # `= collision.Type.ORB)` 

--- Deals damage to enemies when the holder moves.
--- @class Component.itemInflictDamageOnMove
--- @field attackFlags Attack.Flag # `= attack.Flag.DEFAULT` 
--- @field knockbackFlags Attack.Flag # `= attack.Flag.DEFAULT` 
--- @field damage integer # `= 1` 
--- @field type Damage.Flag # `= damage.Type.INDIRECT` 
--- @field knockback integer # `= 0` 
--- @field maxDistance integer # `= 3` 
--- @field inhibitOnDwarfism boolean # `= false` 
--- @field inhibitOnSlide boolean # `= false` 
--- @field inhibitInsideWalls boolean # `= false` 
--- @field flyaway localizedString # `= 0` 

--- Specific to the Golden Lute.
--- @class Component.itemInflictDamageOnMoveLate
--- @field directions table # 
--- @field attackFlags Attack.Flag # `= attack.Flag.CHARACTER` 
--- @field damage integer # `= 1` 
--- @field type Damage.Flag # `= damage.Type.INDIRECT` 

--- Makes the holder move forward when killing an enemy during a weapon attack.
--- This requires the killed enemy to grant `DASH` credit (see `Kill.Credit`).
--- @class Component.itemDashOnKill
--- @field moveType Move.Flag # `= move.Type.NORMAL` 
--- @field active boolean # `= false` 

--- Makes the holder move forward when digging a wall.
--- @class Component.itemDashOnDig
--- @field moveType Move.Flag # `= move.Type.NORMAL` 
--- @field minimumDigStrength Dig.Strength # `= dig.Strength.EARTH` 
--- @field active boolean # `= false` 

--- Makes the holder immune to ice slides.
--- @class Component.itemSlideImmunity

--- Changes the movement animation used by the holder.
--- @class Component.itemForceSlidingTween

--- Prevents move sounds from playing for the holder’s movements.
--- @class Component.itemDisableMoveSound

--- @class Entity
--- @field itemMoveAmplifier Component.itemMoveAmplifier
--- @field itemInflictDamageOnMove Component.itemInflictDamageOnMove
--- @field itemInflictDamageOnMoveLate Component.itemInflictDamageOnMoveLate
--- @field itemDashOnKill Component.itemDashOnKill
--- @field itemDashOnDig Component.itemDashOnDig
--- @field itemSlideImmunity Component.itemSlideImmunity
--- @field itemForceSlidingTween Component.itemForceSlidingTween
--- @field itemDisableMoveSound Component.itemDisableMoveSound

return MovementItemComponents
