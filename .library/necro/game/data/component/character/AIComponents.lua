--- @meta

local AIComponents = {}

--- Lets this entity be controlled by the AI.
--- @class Component.ai
--- @field active boolean # `= true` 
--- @field id Ai.Type # `= ai.Type.IDLE` 
--- @field directions table # Ordered list of directions this entity’s AI is allowed to pick from. Directions that appear earlier in the list are preferred.
--- @field collision Collision.Type # `= collision.Group.WEAPON_CLEARANCE` This entity’s AI will try to avoid moves that would cause a collision with this mask.

--- Can temporarily override this entity’s AI.
--- @class Component.aiOverride
--- @field id integer # `= 0` The AI to use while the override is active.
--- @field active boolean # `= false` Whether the override is currently active.

--- @class Component.aiAttackWhenPossible

--- Required for AI type `SEEK_BIASED`.
--- @class Component.aiBasicSeek
--- @field vertical number # `= 0` 

--- Overrides this entity’s movement to use harpy movement logic.
--- @class Component.aiFlyingSeek

--- Required for AI type `PATTERN`.
--- @class Component.aiPattern
--- @field moves table # 
--- @field index integer # `= 1` 

--- Changes this entity’s initial `aiPattern.index` to avoid bumping into walls.
--- @class Component.aiPatternInitialIndex

--- Changes this entity’s AI collision logic depending on its team.
--- By default, player-team AIs avoid moving into players, and enemy-team AIs avoid moving into enemies.
--- @class Component.aiTeamCollision
--- @field mapping table # Maps teamID => collision mask to avoid while in that team

--- Lets this entity be feared.
--- While feared, its normal AI is ignored and it flees instead.
--- @class Component.fearable
--- @field feared boolean # `= false` 

--- Overrides this entity’s dig strength while it is feared.
--- @class Component.fearableDigStrength
--- @field strength Dig.Strength # `= dig.Strength.NONE` 

--- Lets this entity be charmed.
--- (Note: this is the legacy charm, see `Sync_charmable` for the Synchrony charm.)
--- @class Component.charmable
--- @field active boolean # `= false` 

--- Causes this entity to start charging when aligned with its target.
--- @class Component.chargeTarget
--- @field maxDistance integer # `= 0` Inclusive maximum L∞ distance between this entity and its target for a charge.

--- Specific to bats.
--- @class Component.aiMoveOnFallbackCollision

--- @class Entity
--- @field ai Component.ai
--- @field aiOverride Component.aiOverride
--- @field aiAttackWhenPossible Component.aiAttackWhenPossible
--- @field aiBasicSeek Component.aiBasicSeek
--- @field aiFlyingSeek Component.aiFlyingSeek
--- @field aiPattern Component.aiPattern
--- @field aiPatternInitialIndex Component.aiPatternInitialIndex
--- @field aiTeamCollision Component.aiTeamCollision
--- @field fearable Component.fearable
--- @field fearableDigStrength Component.fearableDigStrength
--- @field charmable Component.charmable
--- @field chargeTarget Component.chargeTarget
--- @field aiMoveOnFallbackCollision Component.aiMoveOnFallbackCollision

return AIComponents
