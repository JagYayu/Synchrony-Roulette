--- @meta

local SoundComponents = {}

--- Plays a sound when this entity takes non-lethal damage.
--- Can be suppressed by setting `ev.silentHit` in `objectTakeDamage`.
--- @class Component.soundHit
--- @field sound string # `= "generalHit"` 

--- Plays a sound when this entity dies.
--- Can be suppressed by setting `ev.silent` in `objectDeath`.
--- @class Component.soundDeath
--- @field sound string # `= "generalDeath"` 

--- Plays a sound when this entity moves.
--- @class Component.soundWalk
--- @field sound string # `= ""` 
--- @field playOnKnockback boolean # `= false` If false, the sound doesn’t play for moves with the `FORCED_MOVE` flag.
--- @field important boolean # `= false` 

--- Plays a sound when this entity moves while giant.
--- @class Component.soundWalkGigantism
--- @field sound string # `= ""` 

--- Plays a different sound each time this entity moves.
--- @class Component.soundWalkParity
--- @field sounds table # A list of sound names. Those are played in order, then it loops back to the first one.
--- @field counter integer # `= 1` 

--- Plays a sound when this entity starts charging.
--- @class Component.soundChargeStart
--- @field sound string # `= ""` 

--- Plays a sound when this entity starts sliding.
--- @class Component.soundSlide
--- @field sound string # `= ""` 

--- When this spell is cast, plays a sound.
--- @class Component.soundSpellcast
--- @field sound string # `= "spellGeneral"` 

--- When this spell is cast, plays a sound if a given tile type is among the targeted tiles.
--- @class Component.soundSpellcastTileType
--- @field sound string # `= "iceMelt"` 
--- @field requiredTileType string # `= "Water"` 

--- When this spell is cast, plays the same sound several times.
--- @class Component.soundSpellcastRepeated
--- @field sound string # `= ""` 
--- @field count integer # `= 3` 
--- @field delay number # `= 0.05` 

--- When this spell is cast, plays a sound, ignoring audio filters.
--- @class Component.soundSpellcastUnfiltered
--- @field sound string # `= "spellGeneral"` 

--- Plays a sound when this item is activated.
--- @class Component.soundItemActivate
--- @field sound string # `= ""` 

--- Plays a sound when this item is activated, depending on its `itemComboable` state.
--- @class Component.soundItemActivateCombo
--- @field sounds table # List of sound names. As the combo count increases, those are played in order.
--- @field loop boolean # `= false` Determines which sound to play once the combo count exceeds the length of the sound list. If true, wrap back to the beginning (ABCABC…). If false, keep playing the last sound (ABCCCC…).

--- Plays a sound when this entity shields damage without losing its shield.
--- @class Component.soundHitShield
--- @field sound string # `= ""` 

--- Plays a sound when this entity loses its shield.
--- @class Component.soundShieldBreak
--- @field sound string # `= ""` 

--- Plays a sound before converting from this type to another type.
--- @class Component.soundPreConvert
--- @field sound string # `= ""` 

--- Plays a sound after converting from another type to this type.
--- @class Component.soundPostConvert
--- @field sound string # `= ""` 

--- Plays a sound when this weapon is thrown.
--- @class Component.soundWeaponThrow
--- @field sound string # `= "doThrow"` 

--- Plays a sound when this weapon fires ammo.
--- @class Component.soundWeaponAttackLoaded
--- @field sound string # `= ""` 

--- Plays a sound when this weapon fires its last ammo.
--- Takes priority over `soundWeaponAttackLoaded`.
--- @class Component.soundWeaponAttackLoadedLast
--- @field sound string # `= ""` 

--- Plays a sound when this weapon is used to attack.
--- @class Component.soundWeaponHit
--- @field sound string # `= ""` 

--- Plays a sound when this entity performs a parry.
--- @class Component.soundParry
--- @field sound string # `= ""` 

--- Plays a sound when damage is prevented by this item.
--- @class Component.soundHitSuppressedItem
--- @field sound string # `= ""` 

--- Plays a sound when this item is consumed.
--- @class Component.soundConsumeItem
--- @field sound string # `= ""` 
--- @field soundLast string # `= ""` 

--- Plays a sound when this price tag is successfully paid.
--- @class Component.soundPriceTagPurchaseSuccess
--- @field sound string # `= "pickupPurchase"` 
--- @field playWhenFree boolean # `= true` 

--- Plays a sound when this price tag fails to be paid.
--- @class Component.soundPriceTagPurchaseFail
--- @field sound string # `= "error"` 

--- Plays a sound when this entity goes down a trapdoor.
--- @class Component.soundDescend
--- @field sound string # `= "trapdoorFall"` 

--- Plays a sound when this trap successfully activates.
--- @class Component.soundTrapActivate
--- @field sound string # `= ""` 

--- Plays a sound when this trap fails to activate.
--- @class Component.soundTrapFail
--- @field sound string # `= "error"` 

--- Plays a sound when this entity is provoked.
--- @class Component.soundProvoke
--- @field sound string # `= ""` 

--- Plays a sound when an interaction with this entity succeeds.
--- @class Component.soundInteract
--- @field sound string # `= ""` 

--- Plays a sound when a focused player successfully interacts with this entity.
--- @class Component.soundInteractFocus
--- @field sound string # `= ""` 

--- Plays a sound when an interaction with this entity fails.
--- @class Component.soundInteractFail
--- @field sound string # `= "error"` 

--- Specific to Hephaestus.
--- @class Component.soundEveryBeat
--- @field sound string # `= ""` 
--- @field beatFraction number # `= 0` 

--- Plays sounds based on this entity’s `damageCountdown`.
--- @class Component.soundDamageCountdown
--- @field sounds table # Maps number of turns left to live => sound.

--- Plays sounds based on this entity’s `grooveChain`.
--- @class Component.soundGrooveChain
--- @field sound string # `= "chainGroove"` Played when the groove chain increases.
--- @field soundDrop string # `= "chainBreak"` Played when the groove chain is reset.

--- @class Entity
--- @field soundHit Component.soundHit
--- @field soundDeath Component.soundDeath
--- @field soundWalk Component.soundWalk
--- @field soundWalkGigantism Component.soundWalkGigantism
--- @field soundWalkParity Component.soundWalkParity
--- @field soundChargeStart Component.soundChargeStart
--- @field soundSlide Component.soundSlide
--- @field soundSpellcast Component.soundSpellcast
--- @field soundSpellcastTileType Component.soundSpellcastTileType
--- @field soundSpellcastRepeated Component.soundSpellcastRepeated
--- @field soundSpellcastUnfiltered Component.soundSpellcastUnfiltered
--- @field soundItemActivate Component.soundItemActivate
--- @field soundItemActivateCombo Component.soundItemActivateCombo
--- @field soundHitShield Component.soundHitShield
--- @field soundShieldBreak Component.soundShieldBreak
--- @field soundPreConvert Component.soundPreConvert
--- @field soundPostConvert Component.soundPostConvert
--- @field soundWeaponThrow Component.soundWeaponThrow
--- @field soundWeaponAttackLoaded Component.soundWeaponAttackLoaded
--- @field soundWeaponAttackLoadedLast Component.soundWeaponAttackLoadedLast
--- @field soundWeaponHit Component.soundWeaponHit
--- @field soundParry Component.soundParry
--- @field soundHitSuppressedItem Component.soundHitSuppressedItem
--- @field soundConsumeItem Component.soundConsumeItem
--- @field soundPriceTagPurchaseSuccess Component.soundPriceTagPurchaseSuccess
--- @field soundPriceTagPurchaseFail Component.soundPriceTagPurchaseFail
--- @field soundDescend Component.soundDescend
--- @field soundTrapActivate Component.soundTrapActivate
--- @field soundTrapFail Component.soundTrapFail
--- @field soundProvoke Component.soundProvoke
--- @field soundInteract Component.soundInteract
--- @field soundInteractFocus Component.soundInteractFocus
--- @field soundInteractFail Component.soundInteractFail
--- @field soundEveryBeat Component.soundEveryBeat
--- @field soundDamageCountdown Component.soundDamageCountdown
--- @field soundGrooveChain Component.soundGrooveChain

return SoundComponents
