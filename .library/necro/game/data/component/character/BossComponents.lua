--- @meta

local BossComponents = {}

--- Marks this entity as a boss. Boss fights end when all boss entities are dead.
--- @class Component.boss
--- @field type integer # `= 0` 
--- @field defeated boolean # `= false` 

--- Deletes all entities with `despawnOnBossFightEnd` when the boss fight ends. Requires `boss` to work correctly.
--- @class Component.bossDeleteEnemiesOnDeath

--- Marks this entity as a boss add. No effect on its own, but see `provokeOnAddsDeath`.
--- @class Component.bossAdd

--- Provokes this entity when there are no other `bossAdd` entities on its team.
--- @class Component.provokeOnAddsDeath
--- @field active boolean # `= false` 
--- @field delay integer # `= 0` 

--- Plays a voiceline on boss fight start.
--- @class Component.voiceBossFightStart
--- @field sound string # `= ""` 

--- Teleports this entity to the boss room if it is in the pre-boss room when the boss fight starts.
--- @class Component.teleportOnBossFightStart

--- Deletes this entity if it is in the pre-boss room when the boss fight starts.
--- @class Component.despawnOnBossFightStart
--- @field active boolean # `= true` Deprecated. If false, this component has no effect.

--- Deletes this entity on boss fight end if the last boss killed had `bossDeleteEnemiesOnDeath`.
--- @class Component.despawnOnBossFightEnd
--- @field active boolean # `= true` Deprecated. If false, this component has no effect.

--- Deletes this entity on a pacifist boss clear if it's blocking the exit path.
--- @class Component.depsawnOnBossFightPacifistEnd
--- @field active boolean # `= true` When false, this component has no effect.

--- Causes this entity to get a light-emitting attachment while in a boss fight.
--- @class Component.bossLight

--- Prevents this entity from acting until the boss fight starts.
--- @class Component.preBossFreeze
--- @field active boolean # `= false` When false, this component has no effect.

--- Specific to KC.
--- @class Component.kingCongaShield

--- Specific to KC.
--- @class Component.kingCongaTeleport
--- @field hadThrone boolean # `= false` 

--- Provokes this entity when any `grooveChainTriggerProvocationOnDrop` entity misses a beat.
--- @class Component.provokeOnMissedBeat

--- Provokes all `provokeOnMissedBeat` entities when this entity misses a beat.
--- @class Component.grooveChainTriggerProvocationOnDrop

--- Teleports this entity if the tile it’s on is changed to a floor.
--- @class Component.teleportOnWallRemoval

--- Specific to KC.
--- @class Component.throneSitter

--- Specific to KC.
--- @class Component.congaAnimation
--- @field frames table # 
--- @field fraction number # `= 0` 

--- Specific to KC zombies.
--- @class Component.congaLine
--- @field next Entity.ID # 
--- @field prev Entity.ID # 

--- Specific to KC yellow zombies.
--- @class Component.congaLineActivator

--- Specific to KC’s throne.
--- @class Component.kingCongaThrone

--- Changes this entity’s AI between two different AI types, depending on the distance to its target.
--- @class Component.aiCatlike
--- @field threshold integer # `= 4` Maximum inclusive L2 distance at which the `close` AI is used. Beyond this distance, the `far` AI is used instead.
--- @field close Ai.Type # `= ai.Type.FLEE` 
--- @field far Ai.Type # `= ai.Type.SEEK_BIASED` 

--- Specific to DM.
--- @class Component.deathMetalHitTriggers
--- @field phase1 string # `= ""` 
--- @field phase2 string # `= ""` 
--- @field phase3 string # `= ""` 
--- @field phase4 string # `= ""` 
--- @field phase2Threshold integer # `= 0` 
--- @field phase3Threshold integer # `= 0` 
--- @field phase4Threshold integer # `= 0` 
--- @field cooldownAfterHit integer # `= 0` 

--- Specific to DM.
--- @class Component.deathMetalSpawn
--- @field types table # Maps zone number => list of lists of entity types. One of the lists is picked at random, then one enemy is spawned for each type in it.
--- @field minDistances table # Maps zone number => **exclusive** minimum L2 distance between spawn and target.
--- @field maxDistances table # Maps zone number => **exclusive** maximum L2 distance between spawn and target.

--- Adjusts this entity’s spawn cap depending on the zone.
--- @class Component.zoneSpawnCaps
--- @field caps table # Maps zone number => spawn cap

--- Specific to DB and DB rooks.
--- @class Component.castler
--- @field look table # 
--- @field move table # 
--- @field active boolean # `= true` 

--- Specific to DB pawns.
--- @class Component.amplifyFirstMove
--- @field distance integer # `= 2` 
--- @field active boolean # `= true` 

--- Specific to DB pawns.
--- @class Component.promote
--- @field targetType string # `= ""` 

--- Specific to DB.
--- @class Component.deepBluesTeleport

--- Teleports the spell’s targets to a given row.
--- @class Component.spellcastTeleportToRow
--- @field y integer # `= 0` 

--- Specific to DB pawns.
--- @class Component.pawnRules

--- Provokes this entity after a given number of beats.
--- @class Component.provokeOnBeatCounter
--- @field beat integer # `= 0` 
--- @field delay integer # `= 0` 

--- Converts this entity to a different type when any boss is provoked.
--- @class Component.convertOnBossProvoke
--- @field targetType string # `= ""` 

--- Specific to CR decorative tentacles.
--- @class Component.visibleOnBossProvoke

--- Specific to CR tentacles.
--- @class Component.tentacleFacing

--- Specific to CR tentacles.
--- @class Component.tentacleTeleport
--- @field type integer # `= 0` 

--- Specific to CR tentacles.
--- @class Component.tentacleSpawnDecorative
--- @field type string # `= ""` 

--- Like spellcastParticles, but the particles are placed on the cast tile instead of the caster.
--- @class Component.spellcastParticlesOrigin
--- @field component string # `= "particleSink"` 

--- Specific to CR.
--- @class Component.tentacleMaster
--- @field active boolean # `= true` 
--- @field teleports table # 

--- Specific to FM.
--- @class Component.audienceCapturer

--- Allows this entity to be part of FM’s audience.
--- While part of the audience, this entity cannot act normally.
--- @class Component.captiveAudience
--- @field active boolean # `= false` 

--- Animation that plays while this entity is part of FM’s audience.
--- @class Component.captiveAudienceAnimation
--- @field hola boolean # `= false` 
--- @field frames table # 
--- @field variants table # 

--- Specific to FM.
--- @class Component.fortissimoleSpawn

--- Specific to FM.
--- @class Component.fortissimoleAI

--- Specific to FM.
--- @class Component.delayOffWallMoves

--- Specific to FM.
--- @class Component.fortissimoleJump

--- Specific to FM.
--- @class Component.fortissimoleBurrowing
--- @field pendingBurrow boolean # `= false` 
--- @field pendingUnburrow boolean # `= false` 

--- Specific to DR.
--- @class Component.deadRinger
--- @field currentBell integer # `= 0` 
--- @field isRinging boolean # `= false` 
--- @field voiceWindup string # `= "deadRingerWindup"` 
--- @field soundWindup string # `= "deadRingerWindup2"` 
--- @field voiceStrikeBell string # `= "deadRingerHammer"` 

--- Specific to DR bells.
--- @class Component.deadRingerBell
--- @field num integer # `= 1` 
--- @field rung boolean # `= false` 
--- @field targeted boolean # `= false` 
--- @field cooldown integer # `= 10` 
--- @field remainingTurns integer # `= 0` 
--- @field minibosses table # 
--- @field sounds table # 

--- Rings any bell this entity runs into while charging.
--- @class Component.chargeRingBells
--- @field destroyBell boolean # `= false` If true, the bell is destroyed after being rung.

--- Makes this entity target bells instead of anything else.
--- @class Component.targetBell

--- Makes this entity’s AI aim towards some point near its target, instead of directly towards its target.
--- @class Component.targetOffset
--- @field dx integer # `= 0` 
--- @field dy integer # `= 0` 

--- Specific to DR. Requires having DR’s hammer equipped to work correctly.
--- @class Component.supercharge
--- @field active boolean # `= false` 

--- Specific to DR’s hammer.
--- @class Component.weaponThrowHolder
--- @field distance integer # `= 100` 

--- When this entity dies, kill all bosses in the level.
--- @class Component.killBossOnDeath

--- Changes this entity’s sprite while it is charging.
--- @class Component.chargeSprite
--- @field texture string # `= ""` 
--- @field width integer # `= 24` 
--- @field height integer # `= 24` 
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 

--- Specific to DR.
--- @class Component.bellRingingSprite
--- @field texture string # `= ""` 
--- @field width integer # `= 24` 
--- @field height integer # `= 24` 
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 

--- Specific to DR.
--- @class Component.bellRingingAnimation
--- @field frames table # 

--- Specific to DR bells.
--- @class Component.bellAnimation
--- @field frames table # 
--- @field variants table # Variant key is `true` when the bell is being targeted by DR

--- Specific to ND.
--- @class Component.necrodancer
--- @field lastAction integer # `= 0` 
--- @field cooldown integer # `= 0` 
--- @field shieldBypassFlags Damage.Flag # `= damage.Flag.GOLDEN_LUTE` 
--- @field shieldTeleportFlags Damage.Flag # `= damage.Flag.EXPLOSIVE` 
--- @field interval integer # `= 0` 
--- @field summonOnHit table # 

--- Specific to ND.
--- @class Component.aiNecrodancer

--- Prevents any use of rhythm-suppressing items while this entity is alive.
--- @class Component.suppressIgnoreRhythm

--- Prevents this entity from being killed by a `spellcastClearObstacles` spell.
--- Optionally makes this entity cast a spell when it resists a spell this way.
--- @class Component.resistClearObstacles
--- @field spell string # `= ""` 

--- Converts this entity to a different type when entering the ND1 boss fight.
--- @class Component.dancerConvert
--- @field targetType string # `= ""` 

--- Specific to ND’s spells.
--- @class Component.spellcastReanimate

--- Specific to ND’s spells.
--- @class Component.spellcastRise
--- @field types table # 

--- Specific to ND buttons.
--- @class Component.buttonTrap
--- @field group integer # `= -1` 

--- Changes all voicelines played by this entity to be non-spatialized (heard equally strongly from anywhere).
--- @class Component.omnipresentVoice

--- Displays subtitles when this entity plays some voicelines.
--- @class Component.subtitled
--- @field map table # Maps sound group => subtitle text
--- @field baseDuration number # `= 2` 
--- @field durationPerCharacter number # `= 0.05` 

--- On the ND1 fight, prevents FAIL actions from resetting this entity’s groove chain.
--- @class Component.grooveChainStoryBossImmunity

--- Plays a voiceline when the last player dies.
--- @class Component.voiceTaunt
--- @field sound string # `= ""` 

--- Plays a voiceline when the golden lute is picked up.
--- @class Component.voiceLutePickup
--- @field sound string # `= ""` 

--- Specific to the ND1 boss fight.
--- @class Component.itemGoldenLute
--- @field gimme boolean # `= false` 

--- This entity copies all actions performed by its parent player.
--- @class Component.dad
--- @field playerID integer # `= 0` 

--- Specific to the ND1 boss fight.
--- @class Component.attackCancel

--- Sets the spell’s direction based on the caster’s target’s position relative to the caster.
--- @class Component.spellcastTowardsTarget

--- Specific to ND2.
--- @class Component.nd2Phase2
--- @field summonTypes table # List of types of entities spawned when entering phase 2.
--- @field interval integer # `= 12` 
--- @field cooldown integer # `= 11` 

--- Specific to the ND2 boss fight.
--- @class Component.castTrapWalls
--- @field interval integer # `= 16` 
--- @field counter integer # `= 0` 

--- Specific to the Golden Lute’s body.
--- @class Component.luteBody
--- @field headType string # `= ""` 
--- @field alternateTexture string # `= "ext/entities/lute_boss_body_magic.png"` 
--- @field forceUp boolean # `= false` 
--- @field headOffsetX integer # `= 1` 
--- @field headOffsetY integer # `= 2` 

--- Specific to the Golden Lute’s head.
--- @class Component.luteHead
--- @field neckTexture string # `= ""` 
--- @field outlineTexture string # `= ""` 
--- @field body Entity.ID # 
--- @field flee boolean # `= false` 
--- @field phase integer # `= 0` 
--- @field fireballCooldown integer # `= 0` 

--- Forces this entity to be active while it has a pending action.
--- @class Component.actionDelayActivation

--- If this entity would take lethal damage, instead advance to the next phase (handled by the `nextPhase` event).
--- @class Component.multiPhase
--- @field phaseCount integer # `= 2` Total number of phases.
--- @field phase integer # `= 1` Current phase.

--- Plays a sound on phase change.
--- @class Component.soundPhaseChange
--- @field sounds table # 

--- Spawns something on phase change.
--- @class Component.phaseSpawn
--- @field types table # List of entity types. One of them is picked at random.
--- @field minDistance integer # `= 2` Exclusive minimum L2 distance between spawn and target.
--- @field maxDistance integer # `= 5` Exclusive maximum L2 distance between spawn and target.
--- @field radius integer # `= 4` Inclusive maximum L∞ distance between spawn and target.

--- Changes this entity’s animation frame depending on its current phase (requires `multiPhase`).
--- @class Component.phaseSpriteChange
--- @field frameX integer # `= 0` 
--- @field maxPhase integer # `= 4` 

--- Specific to FSW.
--- @class Component.frankensteinway
--- @field direction integer # `= 0` 
--- @field distance integer # `= 0` 
--- @field fast boolean # `= false` 
--- @field pendingProp Entity.ID # 
--- @field elecPhase integer # `= 2` 
--- @field fastPhase integer # `= 3` 
--- @field sarcoTypes table # 
--- @field tellFrameX integer # `= 9` 
--- @field voiceFast string # `= "frankDash"` 
--- @field soundFast string # `= "frankImpact"` 

--- Specific to FSW.
--- @class Component.frankensteinwayTell
--- @field texture string # `= "ext/entities/floor_pulse_move_warning.png"` 
--- @field offsetX integer # `= -9` 
--- @field offsetY integer # `= -8` 
--- @field offsetZ integer # `= render.SPRITE_DECAL_Z` 

--- Specific to FSW shield bubbles.
--- @class Component.frankensteinwayProp
--- @field target Entity.ID # 
--- @field soundOn string # `= "frankBulbActivate"` 
--- @field soundOff string # `= "frankBulbDeactivate"` 

--- Specific to FSW shield bubbles.
--- @class Component.frankensteinwayPropAnimation
--- @field inactiveFrameX integer # `= 0` 

--- Specific to FSW shield bubbles.
--- @class Component.trapDisableFrankenshield
--- @field prop Entity.ID # 

--- Creates periodic electric attacks in this entity’s `homeArea`.
--- @class Component.electrifyGround
--- @field down boolean # `= false` If true, electrified tiles move from the top to the bottom of the area. Otherwise, electrified tiles are spread across the entire area.
--- @field patterns table # 
--- @field downPeriod integer # `= 4` 
--- @field damage integer # `= 2` 
--- @field attackFlags Attack.Flag # `= attack.Flag.DEFAULT` 
--- @field swipes table # 
--- @field downSwipes table # 
--- @field sounds table # 

--- Prevents this entity from taking damage multiple times on the same turn from the same attacker.
--- This is normally only useful for `multiTile` entities.
--- @class Component.multiHitProtection
--- @field requiredFlags Damage.Flag # `= damage.Flag.STRENGTH_BASED` 
--- @field attackers table # Maps attacker id => turnID where that attacker last dealt damage to this entity.

--- Specific to FSW.
--- @class Component.shieldReflectDamage
--- @field damage integer # `= 1` 
--- @field bypassFlags integer # `= 0` 

--- Modifies this entity’s attackability as long as its shield is active.
--- @class Component.shieldAttackability
--- @field add integer # `= 0` 
--- @field remove integer # `= 0` 

--- Hides this entity’s `extraSprite` while its shield is inactive.
--- @class Component.extraSpriteVisibleWhileShielded

--- While a boss fight is active, locks the camera onto this entity’s `homeArea`.
--- @class Component.cameraLockToHomeArea
--- @field offsetX number # `= 0` 
--- @field offsetY number # `= 0` 
--- @field offsetW number # `= 0` 
--- @field offsetH number # `= 0` 

--- Specific to the Conductor.
--- @class Component.conductor
--- @field phase integer # `= 1` 
--- @field subphase integer # `= 1` 
--- @field counter integer # `= 0` 
--- @field waterBallCounter integer # `= 0` 
--- @field phase1Spawns table # 
--- @field phase2Spawns table # 
--- @field instrumentBreakSounds table # 
--- @field reanimateSounds table # 
--- @field spellWarnSound string # `= "conductorSpellWarning"` 
--- @field spellCastSound string # `= "conductorCastSpell"` 

--- Specific to the Conductor batteries.
--- @class Component.conductorBattery
--- @field id integer # `= 0` 

--- Specific to the Conductor batteries.
--- @class Component.conductorBatterySpriteChange
--- @field frameCount integer # `= 8` 

--- Specific to the Conductor instruments.
--- @class Component.conductorInstrument
--- @field spawnOnDeath table # 
--- @field wires table # 

--- Lets this entity make use of the Conductor wires, and destroy the Conductor instruments.
--- @class Component.conductorWired
--- @field active boolean # `= false` 

--- Specific to ogres.
--- @class Component.clonking
--- @field distance integer # `= 0` 
--- @field active boolean # `= false` 
--- @field direction integer # `= 0` 

--- Specific to metrognomes.
--- @class Component.metrognomeTeleportOnHit

--- @class Entity
--- @field boss Component.boss
--- @field bossDeleteEnemiesOnDeath Component.bossDeleteEnemiesOnDeath
--- @field bossAdd Component.bossAdd
--- @field provokeOnAddsDeath Component.provokeOnAddsDeath
--- @field voiceBossFightStart Component.voiceBossFightStart
--- @field teleportOnBossFightStart Component.teleportOnBossFightStart
--- @field despawnOnBossFightStart Component.despawnOnBossFightStart
--- @field despawnOnBossFightEnd Component.despawnOnBossFightEnd
--- @field depsawnOnBossFightPacifistEnd Component.depsawnOnBossFightPacifistEnd
--- @field bossLight Component.bossLight
--- @field preBossFreeze Component.preBossFreeze
--- @field kingCongaShield Component.kingCongaShield
--- @field kingCongaTeleport Component.kingCongaTeleport
--- @field provokeOnMissedBeat Component.provokeOnMissedBeat
--- @field grooveChainTriggerProvocationOnDrop Component.grooveChainTriggerProvocationOnDrop
--- @field teleportOnWallRemoval Component.teleportOnWallRemoval
--- @field throneSitter Component.throneSitter
--- @field congaAnimation Component.congaAnimation
--- @field congaLine Component.congaLine
--- @field congaLineActivator Component.congaLineActivator
--- @field kingCongaThrone Component.kingCongaThrone
--- @field aiCatlike Component.aiCatlike
--- @field deathMetalHitTriggers Component.deathMetalHitTriggers
--- @field deathMetalSpawn Component.deathMetalSpawn
--- @field zoneSpawnCaps Component.zoneSpawnCaps
--- @field castler Component.castler
--- @field amplifyFirstMove Component.amplifyFirstMove
--- @field promote Component.promote
--- @field deepBluesTeleport Component.deepBluesTeleport
--- @field spellcastTeleportToRow Component.spellcastTeleportToRow
--- @field pawnRules Component.pawnRules
--- @field provokeOnBeatCounter Component.provokeOnBeatCounter
--- @field convertOnBossProvoke Component.convertOnBossProvoke
--- @field visibleOnBossProvoke Component.visibleOnBossProvoke
--- @field tentacleFacing Component.tentacleFacing
--- @field tentacleTeleport Component.tentacleTeleport
--- @field tentacleSpawnDecorative Component.tentacleSpawnDecorative
--- @field spellcastParticlesOrigin Component.spellcastParticlesOrigin
--- @field tentacleMaster Component.tentacleMaster
--- @field audienceCapturer Component.audienceCapturer
--- @field captiveAudience Component.captiveAudience
--- @field captiveAudienceAnimation Component.captiveAudienceAnimation
--- @field fortissimoleSpawn Component.fortissimoleSpawn
--- @field fortissimoleAI Component.fortissimoleAI
--- @field delayOffWallMoves Component.delayOffWallMoves
--- @field fortissimoleJump Component.fortissimoleJump
--- @field fortissimoleBurrowing Component.fortissimoleBurrowing
--- @field deadRinger Component.deadRinger
--- @field deadRingerBell Component.deadRingerBell
--- @field chargeRingBells Component.chargeRingBells
--- @field targetBell Component.targetBell
--- @field targetOffset Component.targetOffset
--- @field supercharge Component.supercharge
--- @field weaponThrowHolder Component.weaponThrowHolder
--- @field killBossOnDeath Component.killBossOnDeath
--- @field chargeSprite Component.chargeSprite
--- @field bellRingingSprite Component.bellRingingSprite
--- @field bellRingingAnimation Component.bellRingingAnimation
--- @field bellAnimation Component.bellAnimation
--- @field necrodancer Component.necrodancer
--- @field aiNecrodancer Component.aiNecrodancer
--- @field suppressIgnoreRhythm Component.suppressIgnoreRhythm
--- @field resistClearObstacles Component.resistClearObstacles
--- @field dancerConvert Component.dancerConvert
--- @field spellcastReanimate Component.spellcastReanimate
--- @field spellcastRise Component.spellcastRise
--- @field buttonTrap Component.buttonTrap
--- @field omnipresentVoice Component.omnipresentVoice
--- @field subtitled Component.subtitled
--- @field grooveChainStoryBossImmunity Component.grooveChainStoryBossImmunity
--- @field voiceTaunt Component.voiceTaunt
--- @field voiceLutePickup Component.voiceLutePickup
--- @field itemGoldenLute Component.itemGoldenLute
--- @field dad Component.dad
--- @field attackCancel Component.attackCancel
--- @field spellcastTowardsTarget Component.spellcastTowardsTarget
--- @field nd2Phase2 Component.nd2Phase2
--- @field castTrapWalls Component.castTrapWalls
--- @field luteBody Component.luteBody
--- @field luteHead Component.luteHead
--- @field actionDelayActivation Component.actionDelayActivation
--- @field multiPhase Component.multiPhase
--- @field soundPhaseChange Component.soundPhaseChange
--- @field phaseSpawn Component.phaseSpawn
--- @field phaseSpriteChange Component.phaseSpriteChange
--- @field frankensteinway Component.frankensteinway
--- @field frankensteinwayTell Component.frankensteinwayTell
--- @field frankensteinwayProp Component.frankensteinwayProp
--- @field frankensteinwayPropAnimation Component.frankensteinwayPropAnimation
--- @field trapDisableFrankenshield Component.trapDisableFrankenshield
--- @field electrifyGround Component.electrifyGround
--- @field multiHitProtection Component.multiHitProtection
--- @field shieldReflectDamage Component.shieldReflectDamage
--- @field shieldAttackability Component.shieldAttackability
--- @field extraSpriteVisibleWhileShielded Component.extraSpriteVisibleWhileShielded
--- @field cameraLockToHomeArea Component.cameraLockToHomeArea
--- @field conductor Component.conductor
--- @field conductorBattery Component.conductorBattery
--- @field conductorBatterySpriteChange Component.conductorBatterySpriteChange
--- @field conductorInstrument Component.conductorInstrument
--- @field conductorWired Component.conductorWired
--- @field clonking Component.clonking
--- @field metrognomeTeleportOnHit Component.metrognomeTeleportOnHit

return BossComponents
