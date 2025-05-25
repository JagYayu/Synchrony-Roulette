--- @meta

local ObjectEvents = {}

--- @class ObjectEvent
--- @field entity Entity The entity on which this event is being fired

--- @class HolderEvent : ObjectEvent
--- @field holder Entity The entity holding the item on which this event is being fired

--- Fired whenever an object is created
--- @class Event.ObjectSpawn : ObjectEvent
--- @field x integer X position at which to spawn the object
--- @field y integer Y position at which to spawn the object
--- @field attributes? Entity table containing additional values for component/field initialization

--- Fired when an object is trying to perform a directional action (attack, dig, move)
--- @class Event.ObjectDirection : ObjectEvent
--- @field action Action.Direction the attempted directional action
--- @field direction Action.Direction convenience alias for action
--- @field x integer X coordinate of the expected destination
--- @field y integer Y coordinate of the expected destination
--- @field dx integer horizontal offset of the attempted action
--- @field dy integer vertical offset of the attempted action
--- @field result Action.Result the result of the action (enforces action ordering)

--- Fired when an object is trying to perform a non-directional action (idle, spell, bomb...)
--- @class Event.ObjectSpecialAction : ObjectEvent
--- @field action Action.Special the attempted special action
--- @field x integer position of the entity as the action started
--- @field y integer position of the entity as the action started
--- @field dx integer always 0
--- @field dy integer always 0
--- @field result Action.Result the result of the action

--- Fired after an object acts, for both directional and special actions
--- @class Event.ObjectMoveResult : ObjectEvent
--- @field action Action.Direction the attempted directional action
--- @field direction Action.Direction convenience alias for action
--- @field x integer X coordinate of the expected destination
--- @field y integer Y coordinate of the expected destination
--- @field dx integer horizontal offset of the attempted action
--- @field dy integer vertical offset of the attempted action
--- @field result Action.Result the result of the action (enforces action ordering)

--- @class Event.ObjectCheckAttack.Tile
--- @field [1] integer X position of the tile being attacked
--- @field [2] integer Y position of the tile being attacked
--- @field [3] Weapon.Pattern.Tile Pattern tile info from the weapon

--- @class Event.ObjectCheckAttack.Throw
--- @field x integer X position at which the thrown weapon lands
--- @field y integer Y position at which the thrown weapon lands
--- @field weapon Entity The weapon being thrown
--- @field moveType Move.Type Flags to move the thrown weapon with

--- @class Event.ObjectCheckAttack.Result
--- @field targets Damage.Parameters[] list of entities to deal damage to
--- @field tiles Event.ObjectCheckAttack.Tile[] list of attacked tiles, each one in {x, y, tileData} format
--- @field swipes table list of swipes to spawn
--- @field dx integer horizontal movement to apply to the attacker (dash attack or recoil)
--- @field dy integer vertical movement to apply to the attacker (dash attack or recoil)
--- @field moveType Move.Flag move type for the attacker's movement
--- @field throw? Event.ObjectCheckAttack.Throw Contains throw-related data, if applicable to this attack

--- Fired when the wielder of a weapon attempts to attack, deciding whether/how the attack should be performed
--- @class Event.ObjectCheckAttack : ObjectEvent
--- @field direction Action.Direction the direction of the attack
--- @field suppressed boolean if true, all effects are nullified
--- @field result table containing attack targets
--- @field electricityQueue? Wire.QueueEntry[] Stores the list of targets to be hit by an electric arc
--- @field wireLevel? integer Stores the attacker's charge level for electric attacks

--- Fired when the wielder of a weapon attempts to attack, deciding whether/how the attack should be performed
--- @class Event.ObjectPerformAttack : Event.ObjectCheckAttack
--- @field prevX integer X position where the attack started from
--- @field prevY integer Y position where the attack started from

--- Fired when an object is about to move to a different position
--- @class Event.ObjectCheckMove : ObjectEvent
--- @field moveType Move.Flag bitmask of flags determining which preconditions to check for the move
--- @field result Action.Result: result parameter indicating whether the movement can be performed
--- @field x integer the X position the object is trying to move to
--- @field y integer the Y position the object is trying to move to
--- @field prevX integer the X position prior to the move
--- @field prevY integer the Y position prior to the move

--- Fired when an object's position changes
--- @class Event.ObjectMove : ObjectEvent
--- @field moveType Move.Flag bitfield of flags determining the movement's behavior
--- @field result Action.Result always action.Result.MOVE
--- @field x integer contains the X position the object is moving to
--- @field y integer contains the Y position the object is moving to
--- @field partial? boolean true if the move was shortened by a collision
--- @field prevX integer contains the X position prior to the move
--- @field prevY integer contains the Y position prior to the move
--- @field tileInfo Tile.Info contains the tile information table of the tile at the object's new position

--- Fired when an object is telefragged
--- @class Event.ObjectTelefrag : ObjectEvent
--- @field attacker Entity the entity causing the telefrag
--- @field suppressed boolean if true, telefrag effects are nullified

--- Fired when an object capable of digging moves into a wall
--- @class Event.ObjectDig : ObjectEvent
--- @field x integer contains the X position of the tile being dug
--- @field y integer contains the Y position of the tile being dug
--- @field strength Dig.Strength strength of the dig
--- @field shovel boolean true if this dig is using a shovel
--- @field radius integer the distance within which tiles should be broken
--- @field success boolean result parameter containing whether the dig was successful or not
--- @field tileInfo Tile.Info tile information table of the tile being dug
--- @field silentVoice boolean suppresses the dig success voiceline
--- @field silentFail boolean suppresses the dig failure sound effect
--- @field noSwipe boolean suppresses the "shovel" swipe when digging a tile
--- @field multiHit boolean cracks tiles instead of destroying them immediately, requiring multiple hits
--- @field noHighResistance boolean suppresses "high resistance" event handlers for this event
--- @field resistance Dig.Strength dig resistance of the tile being dug (nil for undiggable tiles)

--- Fired when the dig strength of an object needs to be recomputed
--- @class Event.ObjectComputeDigStrength : Event.ObjectDig

--- Fired when a player-controlled object is about to perform an action, locally or in-turn
--- @class Event.ObjectCheckAbility : ObjectEvent
--- @field action Action.Special The action being performed
--- @field args any Action parameters
--- @field flags Ability.Flag Bitmask of ability flags
--- @field client boolean If set, this event is being run locally on the client side and should not alter game state

--- Fired when an object's facing direction changes
--- @class Event.ObjectFacing : ObjectEvent
--- @field direction? Action.Direction new gameplay facing direction. If nil, direction is unchanged.
--- @field visualDirection? Action.Direction new visual facing direction. If nil, direction is unchanged.

--- Fired when an object's groove chain increases or decreases
--- @class Event.ObjectGrooveChain : ObjectEvent
--- @field type GrooveChain.Type The type of groove chain event
--- @field multiplier? integer new coin multiplier
--- @field killCount? integer new kill count

--- Fired when an object is trying to pick up an item from the ground
--- @class Event.ObjectTryCollectItem : ObjectEvent
--- @field item Entity the item entity to be picked up
--- @field silent boolean if true, no sound effect will be played when the item is successfully picked up
--- @field count integer 0 for the preAI pickup, N for the Nth postAI pickup
--- @field result ItemPickup.Result the result of the item collection event
--- @field ignoreBans? boolean If true, item bans and slot drop bans are ignored when determining success
--- @field forwardedResult? ItemPickup.Result Original result if the item pickup was forwarded to another entity
--- @field collector? Entity Optional item that is responsible for this item collection event (e.g. Ring of Gold)

--- Fired when an object's currency amount increases or decreases
--- @class Event.ObjectCurrency : ObjectEvent
--- @field currency Currency.Type the type of currency gained or lost
--- @field difference integer the amount of currency to be added/subtracted
--- @field oldAmount integer the amount of currency the object has prior to the transaction
--- @field item Entity? reference to the currency item being added, nil if this isn't a currency pickup
--- @field flyaway boolean if true, a flyaway is created upon collection (default for item collection)

--- Fired when an object's soul is linked to another
--- @class Event.ObjectSoulLink : ObjectEvent
--- @field target Entity

--- Fired when an existing soul link is broken
--- @class Event.ObjectSoulLinkBreak : ObjectEvent
--- @field target Entity

--- Fired when an entity travels to another location via a rune
--- @class Event.ObjectTravel : ObjectEvent
--- @field x integer target X coordinate
--- @field y integer target Y coordinate
--- @field trap Entity the travel rune entity responsible for the movement
--- @field result Action.Result the result of the movement

--- Fired when an object such as a Shrine or a Chest is interacted with
--- @class Event.ObjectInteract : ObjectEvent
--- @field interactor Entity the object performing the interaction
--- @field result Action.Result the result of the interaction

--- Fired when an object enters any player's field of view for the first time
--- @class Event.ObjectReveal : ObjectEvent

--- Fired when an object's controlling player changes
--- @class Event.ObjectControllerChanged : ObjectEvent
--- @field playerID? Player.ID ID of the player now controlling the object (nil when relinquishing control of an object)

--- Fired when an object's attackability needs to be recomputed
--- @class Event.ObjectUpdateAttackability : ObjectEvent
--- @field flags Attack.Flag bitmask of flags describing the entity's targetability by specific attacks

--- Fired when an object's collision masks needs to be recomputed
--- @class Event.ObjectUpdateCollision : ObjectEvent
--- @field mask Collision.Type currently computed value for the object's collision.mask
--- @field checkOnMove Collision.Type currently computed value for the object's collisionCheckOnMove.mask
--- @field checkOnTeleport Collision.Type currently computed value for the object's collisionCheckOnTeleport.mask
--- @field checkOnAttack Collision.Type currently computed value for the object's collisionCheckOnAttack.mask

--- Fired when an object's tangibility needs to be recomputed
--- @class Event.ObjectUpdateTangibility : ObjectEvent
--- @field tangible boolean currently computed value for the object's gameObject.tangible

--- Fired when an object's targetability needs to be recomputed
--- @class Event.ObjectUpdateTargetability : ObjectEvent
--- @field targetable boolean Currently computed value for the object's `targetable.active`

--- Fired when an object's base damage (not including damage ups) needs to be computed, such as for Monkey grabs
--- @class Event.ObjectComputeDamage : ObjectEvent
--- @field damage integer the base damage this entity can deal

--- Fired when an object deals damage to another object (event filter is based on damage dealer)
--- @class Event.ObjectDealDamage : ObjectEvent
--- @field victim Entity the entity receiving damage
--- @field damage integer the amount of damage dealt
--- @field killerName? string string to be displayed in the post-death "killed by" screen
--- @field killer? Entity entity to credit the kill to, if differing from the attacker
--- @field type Damage.Type determines the damage type (weapon, explosive, lute, etc.)
--- @field direction Action.Direction direction of the damage event
--- @field knockback? integer amount of tiles to move the damage receiver in the direction of the attack
--- @field weapon? Entity Weapon, spell, familiar or bomb using which damage was inflicted (nil for innate attacks)
--- @field silentHit? boolean if true, hit sounds don't play
--- @field suppressed? boolean if true, damage effects are nullified (invulnerability)

--- Fired when an object takes damage from another object (event filter is based on damage receiver)
--- *Note*: code that sets `ev.suppressed = true` is expected to also set `ev.damage = 0`.
--- @class Event.ObjectTakeDamage : Event.ObjectDealDamage
--- @field attacker? Entity the entity dealing damage (may be nil)
--- @field survived? boolean if true, the entity survived the hit
--- @field armored? boolean if true, an armor reduced the amount of damage dealt by this event
--- @field shielded? boolean if true, a shield reduced the amount of damage dealt by this event
--- @field remainingDamage integer amount of damage that has not yet been subtracted from the entity's health

--- Fired when an object takes earthquake damage.
--- @class Event.ObjectEarthquake : ObjectEvent
--- @field attacker? Entity the entity that initiated the earthquake
--- @field survived? boolean if true, the entity survived the hit
--- @field damage integer the amount of damage dealt
--- @field remainingDamage integer amount of damage that has been taken by the entity's health components so far

--- Fired when an object takes knockback.
--- @class Event.ObjectKnockback : ObjectEvent
--- @field direction Action.Direction the direction into which the object is being knocked
--- @field distance integer the number of tiles to knock the entity away
--- @field moveType Move.Type the move type to apply when knocking back the entity
--- @field beatDelay? integer the number of beats to add to the entity's beatDelay
--- @field suppressed? boolean if set to true, the knockback event has no effect

--- Fired when an object parries an incoming attack
--- @class Event.ObjectParry : Event.ObjectTakeDamage

--- Fired when an item applies its damage immunity effect
--- *Note*: listeners for this event should always be registered on the `object` prefix instead of `holder`
--- @class Event.ObjectApplyDamageImmunity : Event.ObjectTakeDamage

--- Fired when an object gains health or maximum health
--- @class Event.ObjectHeal : ObjectEvent
--- @field healer? Entity the entity granting health to the target (may be nil)
--- @field health? integer the amount of health added
--- @field maxHealth? integer the amount of maximum health added
--- @field invincibility? integer number of invincibility frames granted upon healing (defaults to 1; use 0 for no invincibility)
--- @field silent? boolean if true, healing visual effects and sounds are suppressed
--- @field allowOverheal? boolean if true, increasing the health past the current maximum will add heart containers
--- @field attemptedOverheal? boolean if true, this heal attempted increasing the health past the current maximum
--- @field excess? integer if the health limit is exceeded, this parameter is set to the amount of maximum health lost to the limit

--- Fired whenever an entity's health bar is updated, influencing how the entity's health bar should be rendered
--- @class Event.ObjectGetHealthBar : ObjectEvent
--- @field hearts Health.Heart[] the list of heart types to display for this entity

--- Fired when a provokable object is provoked or unprovoked
--- @class Event.ObjectProvoke : ObjectEvent
--- @field attacker? Entity entity that caused the provocation
--- @field direction? Action.Direction direction of the hit (for provokeOnHit only)

--- Fired when an object enters or leaves stasis
--- @class Event.ObjectStasis : ObjectEvent
--- @field active boolean true when entering stasis, false when leaving stasis

--- Fired when an object tries grabs another object (event filter is based on the object receiving the grab)
--- @class Event.ObjectCheckGrab : ObjectEvent
--- @field grabber Entity the object performing the grab
--- @field success? boolean if true, the grab check is successful and the object will be grabbed

--- Fired when an object grabs another object (event filter is based on the object performing the grab)
--- @class Event.ObjectGrab : ObjectEvent
--- @field victim Entity the entity being grabbed

--- Fired when an object releases its grab of another object (including if the grabbed entity despawns)
--- @class Event.ObjectUngrab : ObjectEvent
--- @field victim Entity the entity being released

--- Fired when an object starts sliding
--- @class Event.ObjectBeginSlide : ObjectEvent
--- @field suppressed? boolean if true, the event is cancelled and the slide will not begin

--- Fired when an object stops sliding
--- @class Event.ObjectEndSlide : ObjectEvent

--- Fired when an object starts charging
--- @class Event.ObjectBeginCharge : ObjectEvent

--- Fired when an object stops charging
--- @class Event.ObjectEndCharge : ObjectEvent
--- @field silent? boolean if true, no sound is played for this charge end event

--- Fired when an object is frozen
--- @class Event.ObjectFreeze : ObjectEvent
--- @field turns? integer number of turns to add to the entity's freeze duration
--- @field type Freeze.Type: the type of freeze to inflict (affects the attachment sprite)

--- Fired when an object thaws
--- @class Event.ObjectUnfreeze : ObjectEvent

--- Fired when an object becomes confused
--- @class Event.ObjectConfuse : ObjectEvent
--- @field turns? integer number of turns the entity is confused (nil if the entity is confused indefinitely)

--- Fired when an object ceases to be confused
--- @class Event.ObjectUnconfuse : ObjectEvent

--- Fired when an object is "tickled", causing it to drop its gold and items and granting kill credit to the attacker
--- @class Event.ObjectTickle : ObjectEvent
--- @field attacker Entity the entity performing the tickle

--- Fired when an object sinks into a liquid tile
--- @class Event.ObjectSink : ObjectEvent
--- @field x integer X position of the liquid tile
--- @field y integer Y position of the liquid tile
--- @field tileInfo Tile.Info tileInfo table of the liquid tile
--- @field liquid table table containing information about the liquid tile
--- @field suppressed? boolean if true, the event is cancelled and the object will not sink

--- Fired when an object frees itself from a liquid tile
--- @class Event.ObjectUnsink : ObjectEvent
--- @field x integer X position of the liquid tile
--- @field y integer Y position of the liquid tile
--- @field tileInfo Tile.Info tileInfo table of the liquid tile
--- @field liquid table table containing information about the liquid tile
--- @field immunity? boolean true if the object has unsink immunity

--- Fired when an object's wire level needs to be recomputed
--- @class Event.ObjectUpdateWireLevel : ObjectEvent
--- @field level integer the new wire level

--- Fired when an object becomes gigantic
--- @class Event.ObjectGrow : ObjectEvent
--- @field turns? integer number of turns until the object reverts to normal size (nil if the entity remains gigantic indefinitely)
--- @field suppressed? boolean if true, the event is cancelled and the object will not grow

--- Fired when an object reverts to normal size after being gigantic
--- @class Event.ObjectUngrow : ObjectEvent
--- @field suppressed? boolean if true, the event is cancelled and the object will not reset its size

--- Fired when an object becomes tiny
--- @class Event.ObjectShrink : ObjectEvent
--- @field turns? integer number of turns until the object reverts to normal size (nil if the entity remains tiny indefinitely)
--- @field suppressed? boolean if true, the event is cancelled and the object will not shrink

--- @class Event.ObjectShrinkEffects : ObjectEvent

--- Fired when an object reverts to normal size after being tiny
--- @class Event.ObjectUnshrink : ObjectEvent
--- @field suppressed? boolean if true, the event is cancelled and the object will not reset its size

--- @class Event.ObjectUnshrinkEffects : ObjectEvent

--- Fired when an object needs to recompute its visual scale
--- @class Event.ObjectUpdateScale : ObjectEvent
--- @field scale number the object's scale factor (default 1)

--- Fired when an object needs to recompute its visual hover effect
--- @class Event.ObjectUpdateHover : ObjectEvent
--- @field active boolean set to true to activate the hover effect
--- @field instant? boolean if true, skips the gradual animation for toggling the hover effect

--- Fired when an object is drawn stand-alone. This event is not fired for in-world rendering!
--- @class Event.ObjectPreview : ObjectEvent
--- @field draw fun(args:VertexBuffer.DrawArgs) Callback function for rendering a visual primitive
--- @field drawText fun(args:VertexBuffer.DrawTextArgs) Callback function for rendering text

--- Fired while an object is standing on an idle-damage-dealing (hot) tile
--- @class Event.ObjectHotTileStep : ObjectEvent
--- @field x integer X position of the hot tile
--- @field y integer Y position of the hot tile
--- @field idleInfo table table containing tile-specific idle damage information
--- @field result TileDamage.IdleResult result of the tile step event

--- Fired when the tile under an object is changed. By the time this function is called, the tile has already changed
--- @class Event.ObjectTileChange : ObjectEvent
--- @field tileType Tile.ID the new type of the tile at the object's position
--- @field tileInfo Tile.Info information table for tileType

--- Fired when the song has ended for all tangible player-controlled entities
--- @class Event.ObjectSongEnd : ObjectEvent

--- Fired when a temporary rhythm-changing effect affecting the object ends
--- @class Event.ObjectResetBeatmap : ObjectEvent

--- Fired when an object begins descending (via trapdoor or stairs)
--- @class Event.ObjectDescentBegin : ObjectEvent
--- @field type Descent.Type the type of descent being performed
--- @field duration number the descent's duration until the entity vanishes (in timer units)
--- @field damageImmunity? boolean if true, the entity is fully immune to all types of damage during the descent
--- @field grooveChainImmunity? boolean if true, the entity is immune to all types of groove chain loss during the descent
--- @field modifyAttackableFlags? boolean if true, the entity will apply an attackability flag modifier during the descent
--- @field modifyCollisionMask? boolean if true, the entity will apply a collision mask modifier during the descent
--- @field disableInteractions? boolean if true, the entity cannot be interacted with during the descent
--- @field ambush? boolean if true, the entity will be surrounded by stair-locking minibosses left alive on the floor
--- @field overlay? Overlay.Attributes the type of screen overlay to render during the descent, if the entity is focused
--- @field animation? boolean if true, plays an animation of the entity dropping down
--- @field musicFadeDelay? number the delay after which the music starts fading out
--- @field musicFadeDuration? number the duration for which the music fades out
--- @field silent? boolean if true, suppresses the descent sound and voice line

--- Fired when an object has finished descending (via trapdoor or stairs)
--- @class Event.ObjectDescentEnd : Event.ObjectDescentBegin

--- Fired when any object arrives at the start of a floor after having descended via a trapdoor or stairs
--- @class Event.ObjectDescentArrive : ObjectEvent
--- @field ascent? boolean if true, the entity is ascending back to the current floor instead of descending to the next floor

--- Fired when an object is about to purchase an entity
--- @class Event.ObjectCheckPurchase : ObjectEvent
--- @field price Entity the price tag of the entity to be purchased
--- @field multiplier number factor to multiply currency-based purchase prices with

--- Fired when an object's team changes
--- @class Event.ObjectTeamChange : ObjectEvent
--- @field teamID Team.Id ID of the new team
--- @field prevTeamID Team.Id ID of the old team

--- Fired when an object kills another object (event filter is based on killer entity)
--- @class Event.ObjectKill : ObjectEvent
--- @field victim Entity the entity being killed
--- @field credit Kill.Credit bitmask determining what rewards the killer gets (blood regeneration, spell cooldowns, etc)
--- @field cooldownMultiplier? number if present, the multiplier used for kill cooldowns
--- @field damageType Damage.Type Type of damage inflicted by the lethal attack

--- Fired when an object's health reaches zero
--- @class Event.ObjectDeath : ObjectEvent
--- @field killer? Entity the entity performing the kill (may be nil)
--- @field killerName? string name of the lethal damage source (may be nil)
--- @field damageType Damage.Type determines the damage type (weapon, explosive, lute, etc.)
--- @field silent? boolean suppress death sound effect
--- @field weapon? Entity Weapon, spell, familiar or bomb using which the final blow was was inflicted
--- @field attacker? Entity the entity who dealt the final blow (differs from killer if kill credit was forwarded)

--- Fired when an object is deleted without dying (end of level, falling down trapdoor)
--- @class Event.ObjectDelete : ObjectEvent

--- Common event after object deletion or death
--- @class Event.ObjectDespawn : ObjectEvent

--- Fired when an object respawns after dying (typically at the start of a new floor)
--- @class Event.ObjectRespawn : ObjectEvent
--- @field healPercent? number fraction of health to restore for the entity
--- @field healFlat? integer absolute amount of health to restore for the entity
--- @field minContainers? integer ensures that the entity has at least this much maximum health upon reviving

--- Fired when an object becomes tangible, including just after spawning
--- @class Event.ObjectTangible : ObjectEvent
--- @field conversion? Entity If this tangibility occurred due to a conversion, contains the target prototype

--- Fired when an object becomes intangible, including just before despawning
--- @class Event.ObjectIntangible : ObjectEvent
--- @field conversion? Entity If this intangibility occurred due to a conversion, contains the target prototype

--- Fired just before an object is converted to a different entity type
--- @class Event.ObjectPreConvert : ObjectEvent
--- @field oldType string type name of the old (current) object type
--- @field newType string type name of the new object type (may be modified to change which entity type to convert to)
--- @field prototype Entity entity prototype of the new object type
--- @field preserve? table<string,boolean> set of component names that shouldn't be reset

--- Fired just after an object is converted to a different entity type
--- @class Event.ObjectPostConvert : ObjectEvent
--- @field oldType string type name of the old object type
--- @field newType string type name of the new (current) object type
--- @field prototype Entity entity prototype of the new (current) object type
--- @field preserve? table<string,boolean> set of component names that shouldn't be reset

--- Fired just after an object has been cloned
--- @class Event.ObjectClone : ObjectEvent
--- @field source Entity source entity being cloned
--- @field attributes? Entity table of component fields to merge into the newly cloned entity
--- @field prototype Entity original prototype of the entity type

--- Fired when computing which entity should be targeted by a character class switch
--- @class Event.ObjectCharacterSwitchInit : ObjectEvent
--- @field target Entity? Entity to perform the switch on. If set to `false`, the conversion is suppressed
--- @field oldType Entity.Type Current character type
--- @field newType Entity.Type Target character type
--- @field oldPrototype Entity Current character prototype entity
--- @field newPrototype Entity Target character prototype entity

--- Fired before a player is about to switch to a different character class
--- @class Event.ObjectCharacterSwitchFrom : ObjectEvent
--- @field oldType Entity.Type Current character type
--- @field newType Entity.Type Target character type
--- @field oldPrototype Entity Current character prototype entity
--- @field newPrototype Entity Target character prototype entity

--- Fired after a player has just switched to a different character class (same parameters as CharacterSwitchFrom)
--- @class Event.ObjectCharacterSwitchTo : Event.ObjectCharacterSwitchFrom

--- Fired when the player controlling an object starts spectating (excluding auto-spectate on death)
--- @class Event.ObjectSpectate : ObjectEvent
--- @field playerID Player.ID ID of the player that started spectating
--- @field suppressed? boolean if true, the player is not allowed to begin spectating

--- Fired when the player controlling an object stops spectating
--- @class Event.ObjectUnspectate : ObjectEvent
--- @field playerID Player.ID ID of the player that stopped spectating
--- @field suppressed? boolean if true, the player is not allowed to join the game

--- Fired when a level is ending and all non-persistent entities are to be cleaned up
--- @class Event.ObjectCheckPersistence : ObjectEvent
--- @field persist? boolean if true, this object is spared from being deleted across the level transition
--- @field context Persistence.Context provides information about the reason persistence is being checked

--- Computes the number of enemies to be removed
--- @class Event.ObjectCheckPersistence : ObjectEvent
--- @field count integer Number of enemies to remove according to this player's traits and items

--- Fired when a locally controlled or observed object's perspective is recomputed
--- @class Event.ObjectUpdatePerspective : ObjectEvent
--- @field perspective table<Perspective.Attribute,any> table of perspective attributes (see `Perspective` module)

--- Fired when a locally controlled or observed object's rhythm settings are recomputed
--- @class Event.ObjectUpdateRhythm : ObjectEvent
--- @field ignoreRhythm? boolean if true, the rhythm is ignored entirely and the player may act freely (autoPlay overrides this)
--- @field autoPlay? boolean if true, idle inputs are automatically performed on the beat, rather than at the end of the beat window
--- @field subdivision number? specifies the number of beats each beat should be subdivided into

--- Fired when an equipment-dependent sprite is updated
--- @class Event.ObjectUpdateEquipmentSprite : ObjectEvent
--- @field bodyRow integer the sprite sheet row to display
--- @field headRow integer the sprite sheet row to display

--- Fired when a text label entity needs to recompute the text displayed on it (spawn, change language)
--- @class Event.ObjectUpdateTextLabel : ObjectEvent
--- @field text string the text string to apply to this label entity

--- Fired when an object plays a vocalization sound effect
--- @class Event.ObjectVocalize : ObjectEvent
--- @field soundGroup string the name of the sound group to be played back as a vocalization
--- @field x integer the horizontal position to play the vocalization at
--- @field y integer the vertical position to play the vocalization at
--- @field volume? number the volume to play the vocalization at (default/full volume: 1)
--- @field pitch? number the pitch to play the vocalization at (default: 1)

--- Fired when an object checks for any upgrades to be applied to spells
--- @class Event.ObjectApplySpellUpgrade : ObjectEvent
--- @field spell? string the entity type name of the spell to cast

--- Gets the item corresponding to a given action value
--- @class Event.ObjectGetActionItem : ObjectEvent
--- @field action Action.Special the action for which to retrieve the item
--- @field visual? boolean true if this event is invoked in the context of item slot rendering, false for gameplay
--- @field item? Entity Item that was found within the specified slot, or nil if no item is present
--- @field visualItem? Entity Alternate item whose sprite should be rendered instead of the primary item
--- @field container? Entity Optional item that acts as a "storage" for the result item
--- @field hideKeybinding? boolean If true, the key binding text is not rendered under this slot
--- @field slotImage? string Specifies an alternate image file to render for this item slot's frame

--- Builds the list of items that should appear in an entity's equipment HUD slots
--- @class Event.ObjectGetHUDEquipment : ObjectEvent
--- @field slots table<ItemSlot.Type,string[]> maps slot names to a list of items to appear within that slot
--- @field shared table<string,boolean> set of HUD element names that should be drawn in a shared view instead

--- Builds a list of visual primitives to display in the HUD beat bar, replacing regular (cyan) beat bars
--- @class Event.ObjectGetHUDBeatBars : ObjectEvent
--- @field bars VertexBuffer.DrawArgs[] List of visual primitives for special beat bars (gaps allowed)
--- @field beatmap table the player entity's beatmap object
--- @field scale number HUD scale factor
--- @field minBeat number Beat index from which beat bars should start rendering (for unpause countdown)

function ObjectEvents.fire(eventTypeName, entity, parameter) end

--- Removes any leftover fields from an object event parameter table, allowing it to be stored in snapshot state
--- without causing problems during serialization.
function ObjectEvents.cleanUp(ev) end

return ObjectEvents
