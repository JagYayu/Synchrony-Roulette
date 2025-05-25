--- @meta

local ProtectiveItemComponents = {}

--- Protects the holder from being shrunk by ooze tiles.
--- @class Component.itemTileShrinkImmunity

--- Protects the holder from hot coals.
--- @class Component.itemTileIdleDamageImmunity

--- Prevents the holder from sinking into liquids at all.
--- @class Component.itemTileSinkImmunity

--- Lets the holder move out of liquids without slowing down.
--- @class Component.itemTileUnsinkImmunity

--- Prevents the holder from gaining wire levels from wire tiles.
--- @class Component.itemTileWireImmunity

--- Modifies the holder’s attackability (see `Attack.Flag`).
--- @class Component.itemAttackableFlags
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- Protects the holder from knockback.
--- @class Component.itemKnockbackImmunity

--- Maximizes the holder’s groove chain whenever it increases.
--- @class Component.itemGrooveChainMaximize

--- Prevents some effects from resetting the holder’s groove chain.
--- @class Component.itemGrooveChainImmunity
--- @field idle boolean # `= false` If true, IDLE actions do not reset the holder’s groove chain.
--- @field action boolean # `= false` If true, IDLE, FAIL, and INVALID actions do not reset the holder’s groove chain.
--- @field full boolean # `= false` If true, nothing resets the holder’s groove chain.

--- Prevents FAIL actions from resettting the holder’s groove chain,
--- with the exception that failing to dig a wall still causes a reset.
--- @class Component.itemGrooveChainFailImmunity
--- @field digFailTurnID integer # `= 0` 

--- Consumes the item and lowers incoming damage when the holder takes a lethal hit.
--- @class Component.itemDeathProtection
--- @field bypassFlags Damage.Flag # `= damage.Flag.BYPASS_DEATH_TRIGGERS` 

--- @class Entity
--- @field itemTileShrinkImmunity Component.itemTileShrinkImmunity
--- @field itemTileIdleDamageImmunity Component.itemTileIdleDamageImmunity
--- @field itemTileSinkImmunity Component.itemTileSinkImmunity
--- @field itemTileUnsinkImmunity Component.itemTileUnsinkImmunity
--- @field itemTileWireImmunity Component.itemTileWireImmunity
--- @field itemAttackableFlags Component.itemAttackableFlags
--- @field itemKnockbackImmunity Component.itemKnockbackImmunity
--- @field itemGrooveChainMaximize Component.itemGrooveChainMaximize
--- @field itemGrooveChainImmunity Component.itemGrooveChainImmunity
--- @field itemGrooveChainFailImmunity Component.itemGrooveChainFailImmunity
--- @field itemDeathProtection Component.itemDeathProtection

return ProtectiveItemComponents
