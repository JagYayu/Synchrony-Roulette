--- @meta

local CharacterComponents = {}

--- Makes it possible for this entity to perform actions.
--- @class Component.character
--- @field canAct boolean # `= false` Whether this entity is allowed to perform actions this turn.
--- @field hasActed boolean # `= false` Whether this entity has performed an action this turn.
--- @field action integer # `= 0` Most recently performed action by this entity

--- Allows this entity to be player-controlled, using player input to determine the actions it performs.
--- @class Component.controllable
--- @field playerID integer # `= 0` Player ID of the player currently controlling this entity. Protected field! Do not modify directly, use `Player.setControlledEntity` instead.

--- See `Focus.Flag`.
--- @class Component.focusable
--- @field flags integer # `= 0` Computed field. Should only be modified from inside an `updateFocusedEntities` handler.

--- Ignores some player inputs while this entity is player-controlled.
--- @class Component.actionFilter
--- @field ignoreActions table # Set of ignored actions. The default is to ignore diagonal directions.

--- Remaps some player inputs to different actions while this entity is player-controlled.
--- @class Component.actionRemap
--- @field map table # Maps input action => performed action. The default remapping swaps items/bombs to free up the diagonal keys

--- Changes controller handling for this entity, making it easier to input diagonal directions.
--- @class Component.inputContextLayerDiagonal

--- Adds this entity to the lobby’s character selection room.
--- @class Component.playableCharacter
--- @field pendingPlayerID integer # `= 0` 
--- @field lobbyOrder number # `= 0` 

--- Disallows selecting this character, but retains it for skin selection
--- @class Component.playableCharacterNonSelectable

--- @class Component.lowPercent
--- @field allowedItems table # 
--- @field killerName localizedString # `= "Low percent"` 

--- Marks this entity as an enemy.
--- @class Component.enemy

--- Determines the order in which AI-controlled entities act.
--- @class Component.priority
--- @field value integer # `= 0` 

--- Makes boss fights start when this entity moves inside the boss room.
--- @class Component.bossFighter

--- Forces this entity to idle once at the start of each floor.
--- @class Component.idleOnLevelStart

--- Causes bombs placed by this entity to teleport enemies instead of dealing damage to them.
--- @class Component.teleportingBombs
--- @field teleportFlags Attack.Flag # `= attack.Flag.CHARACTER` Victims that are attackable by these flags are teleported.
--- @field suppressComponent string # `= "enemy"` Victims that have this component are not dealt damage.

--- Prevents this entity from dealing damage by using Need Scroll.
--- @class Component.noNeedDamage

--- Marks this entity as monkey-like (for `itemFreezeMonkeyLikes`).
--- @class Component.monkeyLike

--- Ensures this entity always has an attachment of the given type.
--- @class Component.characterWithAttachment
--- @field attachmentType string # `= ""` 
--- @field attachmentID Entity.ID # 

--- Used for leaderboard submissions. Irrelevant on modded characters, since mods disable leaderboards anyway.
--- @class Component.leaderboardCharacterID
--- @field id integer # `= 0` 

--- Makes this entity physically occupy multiple tiles, instead of just one.
--- @class Component.multiTile
--- @field offsets table # List of {x, y} offsets from this entity’s "main" tile that are also considered occupied.

--- Inflicts damage to this entity if it goes too long without resetting the damage countdown.
--- @class Component.damageCountdown
--- @field damage integer # `= 0` 
--- @field type Damage.Flag # `= damage.Type.SUICIDE` 
--- @field countdownReset integer # `= 0` 
--- @field killerName localizedString # `= 0` 
--- @field countdown integer # `= 0` 

--- Attacking this entity resets `damageCountdown` on the attacker.
--- @class Component.damageCountdownResetWhenAttacked

--- Makes this entity move when it performs directional actions.
--- @class Component.movable
--- @field moveType Move.Flag # `= move.Type.NORMAL` 

--- Tracks whether this entity has moved this turn.
--- @class Component.hasMoved
--- @field value boolean # `= true` 

--- Modifies the distance this entity travels when it performs directional actions.
--- @class Component.amplifiedMovement
--- @field distance integer # `= 0` 

--- Changes how this entity moves when it performs directional actions.
--- @class Component.remappedMovement
--- @field map table # Maps direction => {x, y} movement offset.

--- Inflicts damage to this entity whenever it moves while having an item toggled off.
--- @class Component.takeDamageOnUntoggledMovement
--- @field damage integer # `= 1` 
--- @field type Damage.Flag # `= damage.Type.BLOOD` 
--- @field killerName localizedString # `= 0` 

--- When this entity casts a spell, determine all targets before executing the effects of the spell.
--- (By default, spell targets are determined tile by tile, so if a target gets knocked back to another
--- tile within the spell’s area of effect, it can get hit again by the same spell.)
--- @class Component.precomputeSpellTargets

--- Makes this entity cast spells when performing certain actions.
--- @class Component.innateSpellcasts
--- @field mapping table # Maps action => spell entry. Each spell entry can be either the spell’s name as a string, or a table with fields:  * spell: the spell’s name * direction: the direction in which the spell is cast

--- When this entity is killed by parryable damage, teleports some entities from the victim’s tile
--- to the attacker’s tile, and teleport the attacker to the victim’s tile.
--- @class Component.swapEntitiesOnDeath
--- @field component string # `= "item"` Only entities on the victim’s tile that have this component are teleported.
--- @field sound string # `= "teleport"` 
--- @field flyaway localizedString # `= "Teleported!"` 

--- Converts this entity to the given type when it casts a spell with `spellcastTransform`.
--- @class Component.transformable
--- @field targetType string # `= ""` 

--- Inflicts blood damage to this entity when it casts a spell with `spellcastTransform`.
--- @class Component.transformableBloodCost
--- @field damage integer # `= 0` 
--- @field killerName localizedString # `= "Blood Magic (Transform)"` 

--- @class Entity
--- @field character Component.character
--- @field controllable Component.controllable
--- @field focusable Component.focusable
--- @field actionFilter Component.actionFilter
--- @field actionRemap Component.actionRemap
--- @field inputContextLayerDiagonal Component.inputContextLayerDiagonal
--- @field playableCharacter Component.playableCharacter
--- @field playableCharacterNonSelectable Component.playableCharacterNonSelectable
--- @field lowPercent Component.lowPercent
--- @field enemy Component.enemy
--- @field priority Component.priority
--- @field bossFighter Component.bossFighter
--- @field idleOnLevelStart Component.idleOnLevelStart
--- @field teleportingBombs Component.teleportingBombs
--- @field noNeedDamage Component.noNeedDamage
--- @field monkeyLike Component.monkeyLike
--- @field characterWithAttachment Component.characterWithAttachment
--- @field leaderboardCharacterID Component.leaderboardCharacterID
--- @field multiTile Component.multiTile
--- @field damageCountdown Component.damageCountdown
--- @field damageCountdownResetWhenAttacked Component.damageCountdownResetWhenAttacked
--- @field movable Component.movable
--- @field hasMoved Component.hasMoved
--- @field amplifiedMovement Component.amplifiedMovement
--- @field remappedMovement Component.remappedMovement
--- @field takeDamageOnUntoggledMovement Component.takeDamageOnUntoggledMovement
--- @field precomputeSpellTargets Component.precomputeSpellTargets
--- @field innateSpellcasts Component.innateSpellcasts
--- @field swapEntitiesOnDeath Component.swapEntitiesOnDeath
--- @field transformable Component.transformable
--- @field transformableBloodCost Component.transformableBloodCost

return CharacterComponents
