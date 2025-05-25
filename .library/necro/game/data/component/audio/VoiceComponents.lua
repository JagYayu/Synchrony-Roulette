--- @meta

local VoiceComponents = {}

--- Plays a voiceline when this entity spawns.
--- @class Component.voiceSpawn
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity does its innate attack.
--- Can be suppressed by setting `ev.silent` in `objectCheckMove`.
--- @class Component.voiceAttack
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity takes non-lethal damage.
--- Can be suppressed by setting `ev.silentHit` or `ev.silentHitVoice` in `objectTakeDamage`.
--- @class Component.voiceHit
--- @field sound string # `= ""` 
--- @field minimumDamage integer # `= 0` 

--- Plays a voiceline when this entity shields damage.
--- @class Component.voiceHitShield
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity takes non-lethal damage with the `VOICE_SQUISH` flag.
--- @class Component.voiceSquish
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity dies.
--- Can be suppressed by setting `ev.silent` in `objectDeath`.
--- @class Component.voiceDeath
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity is revealed for the first time.
--- @class Component.voiceReveal
--- @field sound string # `= ""` 
--- @field done boolean # `= false` 

--- Plays a voiceline when this entity is aggroed for the first time.
--- @class Component.voiceAggro
--- @field sound string # `= ""` 
--- @field done boolean # `= false` 

--- Plays a voiceline when this entity is provoked.
--- @class Component.voiceProvoke
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity digs.
--- @class Component.voiceDig
--- @field sound string # `= ""` 
--- @field playOnFail boolean # `= true` If false, the voiceline doesn’t play for failed digs.

--- Plays a voiceline when this entity grabs something.
--- @class Component.voiceGrab
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity takes non-lethal damage while grabbing something.
--- @class Component.voiceGrabHit
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity is grabbed.
--- @class Component.voiceGrabbed
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity does a move with the `VOCALIZE` flag (wind spells set this flag).
--- @class Component.voiceWind
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity becomes confused.
--- @class Component.voiceConfused
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity attacks with a melee weapon, depending on its `hitChain`.
--- Can be suppressed by setting ev.silentAttack in `objectDirection`.
--- @class Component.voiceMeleeAttack
--- @field sounds table # Maps number of consecutive hits => sound to play. If the number of consecutive hits exceeds the number of sounds, it loops around.

--- Plays a voiceline when this entity attacks with a ranged weapon, depending on its `hitChain`.
--- Can be suppressed by setting ev.silentAttack in `objectDirection`.
--- @class Component.voiceRangedAttack
--- @field sounds table # Maps number of consecutive hits => sound to play. If the number of consecutive hits exceeds the number of sounds, it loops around.

--- Plays a voiceline when this entity starts charging.
--- @class Component.voiceChargeStart
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity ends charging.
--- Can be suppressed by setting ev.silent in `objectEndCharge`.
--- @class Component.voiceChargeStop
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity starts sliding.
--- @class Component.voiceSlideStart
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity stops being stunned.
--- @class Component.voiceWakeUp
--- @field sound string # `= ""` 
--- @field active boolean # `= true` 

--- Plays a voiceline when this entity steps on hot coals.
--- @class Component.voiceHotTileStep
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity is healed.
--- Can be suppressed by setting ev.silent in `objectHeal`.
--- @class Component.voiceHeal
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity becomes shrunk.
--- @class Component.voiceShrink
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity stops being shrunk.
--- @class Component.voiceUnshrink
--- @field sound string # `= ""` 
--- @field delay number # `= -0.2` 

--- Plays a voiceline when this entity takes a trapdoor.
--- @class Component.voiceDescend
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity gets teleported.
--- @class Component.voiceTeleport
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity reveals a secret chest.
--- @class Component.voiceNotice
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity reveals a secret chest.
--- @class Component.voiceUnstasis
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity’s beat delay is 0 after it acts.
--- @class Component.voiceTell
--- @field sound string # `= ""` 

--- Plays a voiceline in several situations:
--- 
--- * When locked stairs become unlocked
--- * When a boss fight ends
--- * When an arena or shriner fight ends
--- * When this entity opens an NPC cage
--- @class Component.voiceStairsUnlock
--- @field sound string # `= ""` 

--- Spell component. Makes the caster play a given voiceline.
--- @class Component.voiceSpellcast
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity gets close to a `greetable` entity for the first time.
--- @class Component.voiceGreeting
--- @field sound string # `= ""` 

--- See `voiceGreeting`.
--- @class Component.greetable
--- @field greeted boolean # `= false` 

--- Plays a voiceline each beat when a hostile entity is adjacent to this entity.
--- @class Component.voiceEnemyProximity
--- @field sound string # `= ""` 

--- Plays a voiceline when an `enemy` entity dies near this entity.
--- @class Component.voiceEnemyDeath
--- @field sound string # `= ""` 

--- Plays a voiceline when this entity casts a spell with `voiceSpellTypeSuffix`.
--- @class Component.voiceSpellCasterPrefix
--- @field prefix string # `= ""` The name of the voiceline to play is obtained by concatenating this caster-specific prefix with the spell-specific suffix.
--- @field fallback string # `= ""` Default voiceline, used when (prefix + suffix) isn’t a valid sound name.

--- Spell component. See `voiceSpellCasterPrefix`.
--- @class Component.voiceSpellTypeSuffix
--- @field suffix string # `= ""` 

--- Changes the volume of this entity’s voice.
--- @class Component.vocalizationVolumeMultiplier
--- @field volume number # `= 1` 

--- Changes the pitch of this entity’s voice.
--- @class Component.vocalizationPitchMultiplier
--- @field pitch number # `= 1` 

--- Changes the pitch of this entity’s voice while it is giant.
--- @class Component.vocalizationGigantismPitchMultiplier
--- @field pitch number # `= 0.8` 

--- Changes the pitch of this entity’s voice while it is shrunk.
--- @class Component.vocalizationDwarfismPitchMultiplier
--- @field pitch number # `= 1.25` 

--- Randomly selects alternative variations for certain voice lines
--- @class Component.vocalizationRandomAlternatives
--- @field mapping table # Maps sound group names to tables with `target` (sound group name) and `chance` (0.0 - 1.0) fields

--- Mutes/attenuates all vocalizations unless this entity's caster is focused
--- @class Component.vocalizationCheckCasterFocus
--- @field volume number # `= 0` 

--- @class Entity
--- @field voiceSpawn Component.voiceSpawn
--- @field voiceAttack Component.voiceAttack
--- @field voiceHit Component.voiceHit
--- @field voiceHitShield Component.voiceHitShield
--- @field voiceSquish Component.voiceSquish
--- @field voiceDeath Component.voiceDeath
--- @field voiceReveal Component.voiceReveal
--- @field voiceAggro Component.voiceAggro
--- @field voiceProvoke Component.voiceProvoke
--- @field voiceDig Component.voiceDig
--- @field voiceGrab Component.voiceGrab
--- @field voiceGrabHit Component.voiceGrabHit
--- @field voiceGrabbed Component.voiceGrabbed
--- @field voiceWind Component.voiceWind
--- @field voiceConfused Component.voiceConfused
--- @field voiceMeleeAttack Component.voiceMeleeAttack
--- @field voiceRangedAttack Component.voiceRangedAttack
--- @field voiceChargeStart Component.voiceChargeStart
--- @field voiceChargeStop Component.voiceChargeStop
--- @field voiceSlideStart Component.voiceSlideStart
--- @field voiceWakeUp Component.voiceWakeUp
--- @field voiceHotTileStep Component.voiceHotTileStep
--- @field voiceHeal Component.voiceHeal
--- @field voiceShrink Component.voiceShrink
--- @field voiceUnshrink Component.voiceUnshrink
--- @field voiceDescend Component.voiceDescend
--- @field voiceTeleport Component.voiceTeleport
--- @field voiceNotice Component.voiceNotice
--- @field voiceUnstasis Component.voiceUnstasis
--- @field voiceTell Component.voiceTell
--- @field voiceStairsUnlock Component.voiceStairsUnlock
--- @field voiceSpellcast Component.voiceSpellcast
--- @field voiceGreeting Component.voiceGreeting
--- @field greetable Component.greetable
--- @field voiceEnemyProximity Component.voiceEnemyProximity
--- @field voiceEnemyDeath Component.voiceEnemyDeath
--- @field voiceSpellCasterPrefix Component.voiceSpellCasterPrefix
--- @field voiceSpellTypeSuffix Component.voiceSpellTypeSuffix
--- @field vocalizationVolumeMultiplier Component.vocalizationVolumeMultiplier
--- @field vocalizationPitchMultiplier Component.vocalizationPitchMultiplier
--- @field vocalizationGigantismPitchMultiplier Component.vocalizationGigantismPitchMultiplier
--- @field vocalizationDwarfismPitchMultiplier Component.vocalizationDwarfismPitchMultiplier
--- @field vocalizationRandomAlternatives Component.vocalizationRandomAlternatives
--- @field vocalizationCheckCasterFocus Component.vocalizationCheckCasterFocus

return VoiceComponents
