local RouletteGambler = require "Roulette.Gambler"
local RouletteGun = require "Roulette.Gun"
local RouletteRogue = require "Roulette.Rogue"
local RouletteRogueItem = {}
local RouletteRogueJudge = require "Roulette.RogueJudge"
local RouletteUIBag = require "Roulette.render.UIBag"
local RouletteUtility = require "Roulette.Utility"

local Action = require "necro.game.system.Action"
local Character = require "necro.game.character.Character"
local Currency = require "necro.game.item.Currency"
local Damage = require "necro.game.system.Damage"
local ECS = require "system.game.Entities"
local Flyaway = require "necro.game.system.Flyaway"
local Health = require "necro.game.character.Health"
local Inventory = require "necro.game.item.Inventory"
local ItemSlot = require "necro.game.item.ItemSlot"
local MoveAnimations = require "necro.render.level.MoveAnimations"
local Object = require "necro.game.object.Object"
local ObjectClone = require "necro.game.object.ObjectClone"
local Particle = require "necro.game.system.Particle"
local Shield = require "necro.game.system.Shield"
local Sound = require "necro.audio.Sound"
local Spell = require "necro.game.spell.Spell"
local TextPool = require "necro.config.i18n.TextPool"
local Utilities = require "system.utils.Utilities"

--#region Rogue Items

event.Roulette_itemCheckUse.add("onEnemy", {
	filter = { "Roulette_itemUseOnEnemy", "!Roulette_itemUseDuplicate" },
	order = "target",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if not ev.success and ev.target.Roulette_enemy then
		ev.success = true
	end
end)

--- @param target Entity
--- @return Entity? judgeEntity @return judge entity associated with target entity.
function RouletteRogueItem.isEnemyDuplicatable(target)
	local judgeEntity = target.Roulette_gambler and ECS.getEntityByID(target.Roulette_gambler.judge)
	if judgeEntity then
		local canMidJoin = RouletteRogueJudge.canMidJoin(judgeEntity, target.name)
		return canMidJoin and judgeEntity or nil
	end
end

event.Roulette_itemCheckUse.add("onEnemyDuplicatable", {
	filter = { "Roulette_itemUseOnEnemy", "Roulette_itemUseDuplicate" },
	order = "target",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if not ev.success and ev.target.Roulette_enemy and RouletteRogueItem.isEnemyDuplicatable(ev.target) then
		ev.success = true
	end
end)

event.Roulette_itemCheckUse.add("onItem", {
	filter = "Roulette_itemUseOnItem",
	order = "target",
}, function(ev) --- @param ev Event.Roulette_itemCheckUse
	if not ev.success and ev.target.Roulette_item then
		ev.success = true
	end
end)

event.Roulette_itemCheckUse.add("conditionBurnGun", {
	filter = "Roulette_itemUseBurnGun",
	order = "conditional",
}, function(ev)
	if ev.success then
		local gunEntity = RouletteGun.getFromGamblerEntity(ev.user)
		if not (gunEntity and gunEntity.Roulette_gunStatusBurnt) then
			ev.success = false
		end
	end
end)

event.Roulette_itemUse.add("burnGun", {
	filter = "Roulette_itemUseBurnGun",
	order = "use",
}, function(ev) ---@param ev Event.Roulette_itemUse
	local gunEntity = RouletteGun.getFromGamblerEntity(ev.user)
	if gunEntity and gunEntity.Roulette_gunStatusBurnt then
		RouletteGun.burn(gunEntity, ev.item.Roulette_itemUseBurnGun.multiplier)
	end
end)

event.Roulette_itemUse.add("castSpell", {
	filter = "Roulette_itemUseCastSpellOnTarget",
	order = "use",
}, function(ev)
	local position = ev.target.position
	if position then
		local cast = ev.item.Roulette_itemUseCastSpellOnTarget
		Spell.castAt(ev.user, cast.spell, position.x, position.y, cast.direction, cast.params)
	end
end)

event.Roulette_itemCheckUse.add("conditionCharmGambler", {
	filter = "Roulette_itemUseCharmGambler",
	order = "conditional",
}, function(ev)
	if ev.success and not ev.target.Roulette_gamblerCharmable then
		ev.success = false
	end
end)

event.Roulette_itemUse.add("charmGambler", {
	filter = "Roulette_itemUseCharmGambler",
	order = "use",
}, function(ev)
	RouletteGambler.charm(ev.target, ev.user, ev.item.Roulette_itemUseCharmGambler.turns)
end)

event.Roulette_itemUse.add("convertBullets", {
	filter = "Roulette_itemUseConvertBullets",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local gun = RouletteGun.getGunFromGamblerEntity(ev.user)
	if gun then
		local bullet = RouletteGun.getBulletCertaintifiedType(ev.item.Roulette_itemUseConvertBullets.bullet)
		ev.transmuteBullets = {}
		for i in ipairs(gun.bullets) do
			gun.bullets[i] = bullet
			ev.transmuteBullets[#ev.transmuteBullets + 1] = { index = i, bullet = bullet }
		end
	end
end)

event.Roulette_itemUse.add("convertLastBullet", {
	filter = "Roulette_itemUseConvertLastBullet",
	order = "use",
}, function(ev)
	local gun = RouletteGun.getGunFromGamblerEntity(ev.user)
	if gun then
		local bullet = RouletteGun.getBulletCertaintifiedType(ev.item.Roulette_itemUseConvertLastBullet.bullet)
		for i = #gun.bullets, 1, -1 do
			local targetBullet = RouletteGun.getBulletCertaintifiedType(gun.bullets[i])
			if bullet ~= targetBullet then
				gun.bullets[i] = bullet
				ev.transmuteBullets = ev.transmuteBullets or {}
				ev.transmuteBullets[#ev.transmuteBullets + 1] = { index = i, bullet = bullet }

				break
			end

			RouletteGun.certaintifyBullet(gun.bullets, i)
		end
	end
end)

--- @param entity Entity
--- @param initialPosition Component.position?
function RouletteRogueItem.duplicate(entity, initialPosition)
	initialPosition = initialPosition and { x = initialPosition.x, y = initialPosition.y } or RouletteUtility.emptyTable

	if entity.Roulette_item then
		--- @diagnostic disable-next-line: missing-fields
		local clone = Object.clone(entity, { position = initialPosition })
		if entity.position then
			MoveAnimations.play(clone, MoveAnimations.Type.HOP, entity.position.x, entity.position.y)
		end
		return clone
	elseif entity.Roulette_gambler then
		local judgeEntity = ECS.getEntityByID(entity.Roulette_gambler.judge)
		if judgeEntity then
			--- @diagnostic disable
			local clone = Object.clone(entity, { position = initialPosition })
			--- @diagnostic enable
			RouletteRogueJudge.midJoin(judgeEntity, clone)
			return clone
		end
	end
end

for component, fields in pairs {
	Roulette_aiGamblerRogue = { "opponent", "memoryBullets" },
	Roulette_gambler = { "initiative", "team", "turn", "turnDelay", "extraActions", "judge", "cursor" },
} do
	for _, field in ipairs(fields) do
		ObjectClone.registerFieldReset(component, field)
	end
end

event.Roulette_itemUse.add("duplicate", {
	filter = "Roulette_itemUseDuplicate",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	local clone = RouletteRogueItem.duplicate(ev.target, ev.item.position)
	if clone then
		Flyaway.create {
			entity = ev.item,
			text = TextPool.get "mod.Roulette.duplicate",
		}
		if clone.Roulette_item and not clone.Roulette_enemy then
			clone.Roulette_selectable.belonging = ev.user.id
		end
	end
	ev.clone = clone
end)

event.Roulette_itemUse.add("extraActions", {
	filter = "Roulette_itemUseAddGamblerExtraActions",
	order = "use",
}, function(ev) --- @param ev Event.Roulette_itemUse
	if ev.user.Roulette_gambler then
		local extraActions = ev.item.Roulette_itemUseAddGamblerExtraActions
		ev.user.Roulette_gambler.extraActions = ev.user.Roulette_gambler.extraActions + extraActions.value
		Flyaway.create {
			entity = ev.user,
			text = extraActions.flyaway:format(ev.user.Roulette_gambler.extraActions),
		}
	end
end)

event.Roulette_itemCheckUse.add("conditionSilenceGambler", {
	filter = "Roulette_itemUseSetGamblerSilence",
	order = "conditional",
}, function(ev)
	if ev.success and not ev.target.Roulette_gamblerStatusSilence then
		ev.success = false
	end
end)

event.Roulette_itemUse.add("silenceGambler", {
	filter = "Roulette_itemUseSetGamblerSilence",
	order = "use",
	sequence = .5,
}, function(ev) --- @param ev Event.Roulette_itemUse
	RouletteGambler.silence(ev.target, ev.item.Roulette_itemUseSetGamblerSilence.turns)
end)

--#endregion

--#region Equipments

--- Get equipped gambler ring with specific component
--- @param holder Entity
--- @param ... string
--- @return Entity?
function RouletteRogueItem.getEquippedItem(holder, ...)
	for entity in ECS.entitiesWithComponents { "item", ... } do
		if entity.item.holder == holder.id and entity.item.equipped then
			return entity
		end
	end
end

function RouletteRogueItem.equipRing(holder, item)
	if not item.Roulette_ring then
		return
	end

	for entity in ECS.entitiesWithComponents { "Roulette_ring", "item" } do
		if entity.id ~= item.id and entity.item.holder == holder.id then
			Inventory.unequip(entity, holder)
		end
	end

	item.item.equipped = true

	if holder.inventory and holder.position then
		for _, id in ipairs(holder.inventory.itemSlots[ItemSlot.Type.RING]) do
			local ring = ECS.getEntityByID(id)
			if ring then
				if ring.Roulette_ring then
					Utilities.arrayRemove(holder.inventory.itemSlots[ItemSlot.Type.RING], ring.id)
				else
					Inventory.drop(ring, holder.position.x, holder.position.y)
				end
			end
		end

		holder.inventory.itemSlots[ItemSlot.Type.RING] = { item.id }
	end
end

event.inventoryEquipItem.add("rogueModeEquipRing", {
	filter = "Roulette_ring",
	order = "equip",
	sequence = 1,
}, function(ev)
	if RouletteRogue.isModeActive() then
		RouletteRogueItem.equipRing(ev.holder, ev.item)
	end
end)

event.inventoryUnequipItem.add("unequipRing", {
	filter = "Roulette_ring",
	order = "unequip",
	sequence = 1,
}, function(ev)
	-- ev.item.Roulette_ring.equipped = false
end)

event.Roulette_holderGamblerStartGame.add("itemCharge", {
	filter = "Roulette_itemCharge",
	order = "charge",
}, function(ev)
	RouletteUtility.resetField(ev.item, "Roulette_itemCharge", "charged")
end)

event.Roulette_holderGamblerEndGame.add("itemDischarge", {
	filter = "Roulette_itemCharge",
	order = "discharge",
}, function(ev)
	ev.item.Roulette_itemCharge.charged = 0
end)

event.Roulette_sequenceJudgeNextRound1.add("itemRecharge", "item", function(ev) --- @param ev Event.Roulette_sequenceJudgeNextRound
	for _, gamblerID in ipairs(ev.component.gamblers) do
		local gamblerEntity = ECS.getEntityByID(gamblerID)
		if gamblerEntity and gamblerEntity.inventory then
			for _, item in ipairs(Inventory.getItems(gamblerEntity)) do
				if item.Roulette_itemCharge and item.Roulette_itemCharge.rechargePerRound then
					RouletteUtility.resetField(item, "Roulette_itemCharge", "charged")
				end
			end
		end
	end
end)

--#region Armors

event.holderTakeDamage.add("armor", {
	filter = { "Roulette_itemArmor", "Roulette_itemCharge" },
	order = "armor",
}, function(ev)
	local charge = ev.entity.Roulette_itemCharge
	local armored = ev.damage > 1 and charge.charged > 0 and Shield.applyToEvent(ev.entity.Roulette_itemArmor, ev)
	if armored then
		charge.charged = charge.charged - 1
		ev.armored = true
	end
end)

event.holderTakeDamage.add("armorProtective", {
	filter = { "Roulette_itemArmorProtective", "Roulette_itemCharge" },
	order = "health",
	sequence = -21,
}, function(ev)
	if not ev.suppressed then
		local charge = ev.entity.Roulette_itemCharge
		if charge.charged > 0 then
			local remainingDamage = ev.remainingDamage or ev.damage
			ev.remainingDamage = math.max(0, remainingDamage - charge.charged)
			charge.charged = math.max(0, charge.charged - remainingDamage)
		end
	end
end)

--#endregion

--#region CharmFood

event.Roulette_itemUse.add("charmFoodOverHealExtraAction", {
	filter = "Roulette_itemTagFood",
	order = "use",
	sequence = 71,
}, function(ev) --- @param ev Event.Roulette_itemUse
	if ev.heal and ev.heal.attemptedOverheal then
		local item = RouletteRogueItem.getEquippedItem(ev.user, "Roulette_itemCharmFood")
		if item and item.Roulette_itemCharge.charged > 0 then
			item.Roulette_itemCharge.charged = item.Roulette_itemCharge.charged - 1
			ev.user.Roulette_gambler.extraActions = ev.user.Roulette_gambler.extraActions + 1
			Flyaway.create {
				entity = ev.user,
				text = item.Roulette_itemCharmFood.flyaway:format(ev.user.Roulette_gambler.extraActions),
			}
		end
	end
end)

event.holderHeal.override("checkGluttony", function(func, ev)
	if ev.entity.Roulette_itemCharmFood and RouletteRogue.isModeActive() then
		if ev.healer and ev.healer.consumableFood and ev.attemptedOverheal and not ev.allowOverheal then
			ev.allowOverheal = true
		end
	else
		func(ev)
	end
end)

event.holderRoulette_itemGenerationWeightPostProcess.add("moreHealthItems", {
	filter = "Roulette_itemGamblerMoreHealthItems",
	order = "more",
}, function(ev) --- @param ev Event.Roulette_itemGenerationWeight
	if ev.prototype.Roulette_itemTagHeal then
		ev.weight = ev.weight * 2
	end
end)

--#endregion

--#region CharmFrost

event.Roulette_sequenceGunShot2.add("charmFrostUser", {
	order = "counterAttack",
	sequence = 100,
}, function(ev) --- @param ev Event.Roulette_sequenceGunShot
	if ev.parameter.success and ev.target and ev.user and ev.target.id ~= ev.user.id and ev.user.Roulette_gamblerStatusFreeze then
		local item = RouletteRogueItem.getEquippedItem(ev.target, "Roulette_itemCharmFrost")
		if item and item.Roulette_itemCharge.charged > 0 then
			item.Roulette_itemCharge.charged = item.Roulette_itemCharge.charged - 1
			RouletteGambler.freeze(ev.user, 2, ev.target)
			Sound.playFromEntity("spellFreeze", ev.user)
		end
	end
end)

event.holderTakeDamage.override("applyDamageImmunityLast", function(func, ev)
	if ev.entity.Roulette_itemCharmFrost and ev.entity.item then
		local holder = ECS.getEntityByID(ev.entity.item.holder)
		if holder and holder.Roulette_gambler and RouletteGambler.isGambling(holder.Roulette_gambler) then
			return
		end
	end

	func(ev)
end)

--#endregion

--#region CharmInfernal

event.holderTakeDamage.add("itemHalveFireDamageForGambler", {
	filter = "Roulette_itemHalveFireDamage",
	order = "armor",
	sequence = -10,
}, function(ev)
	if not ev.suppressed and ev.damage > 0 and (not ev.entity.item or ev.entity.item.equipped)
		and Damage.Flag.check(ev.type, Damage.Flag.FIRE)
		and ev.holder.Roulette_gambler and RouletteGambler.isGambling(ev.holder.Roulette_gambler)
	then
		ev.damage = math.ceil(ev.damage / 2)
	end
end)

--#endregion

--#region CharmLuck/RingLuck

event.holderRoulette_gamblerUpdateLuck.add("itemAddGamblerLuck", {
	filter = "Roulette_itemAddGamblerLuck",
	order = "item",
}, function(ev) --- @param ev Event.Roulette_gamblerUpdateLuck
	ev.chance = ev.chance + ev.entity.Roulette_itemAddGamblerLuck.chance
end)

--#endregion

--#region CharmRisk

RouletteGun.damageEventRegister("itemGamblerDamageUpLowHealth", {
	filter = "Roulette_gun",
	order = "item",
}, {
	filter = "Roulette_gun",
	order = "baseIncrease",
	sequence = 3,
}, function(ev)
	local gamblerEntity = ECS.getEntityByID(ev.entity.Roulette_gun.gambler)
	local item = gamblerEntity and (not gamblerEntity.health or gamblerEntity.health.health <= 1)
		and RouletteRogueItem.getEquippedItem(gamblerEntity, "Roulette_itemGamblerDamageUpLowHealth")
	if item then
		ev.damage = ev.damage + item.Roulette_itemGamblerDamageUpLowHealth.damage
	end
end)

event.turn.add("riskCharmOverrideConditionalDamage", {
	order = "nextTurnEffect",
	sequence = 1,
}, function()
	if RouletteRogue.isModeActive() then
		for entity in ECS.entitiesWithComponents { "Roulette_itemCharmRisk", "itemConditionalDamageIncrease" } do
			entity.itemConditionalDamageIncrease.remainingTurns = 0
		end
	end
end)

--#endregion

--#region CharmStrength

RouletteGun.damageEventRegister("itemGamblerDamageUpFirstRound", {
	filter = "Roulette_gun",
	order = "item",
}, {
	filter = "Roulette_gun",
	order = "baseIncrease",
	sequence = 3,
}, function(ev)
	local gamblerEntity = ECS.getEntityByID(ev.entity.Roulette_gun.gambler)
	local item = gamblerEntity and RouletteRogueItem.getEquippedItem(gamblerEntity, "Roulette_itemGamblerDamageUpFirstRound")
	if item and item.Roulette_itemCharge.charged > 0 then
		ev.damage = ev.damage + item.Roulette_itemGamblerDamageUpFirstRound.damage
	end
end)

event.Roulette_sequenceJudgeNextRound1.add("itemGamblerDamageUpFirstRoundDischarge", {
	order = "item",
	sequence = 1,
}, function(ev) --- @param ev Event.Roulette_sequenceJudgeNextRound
	if ev.component.round < 2 then
		return
	end

	for _, gamblerID in ipairs(ev.component.gamblers) do
		local gamblerEntity = ECS.getEntityByID(gamblerID)
		if gamblerEntity and gamblerEntity.inventory then
			for _, item in ipairs(Inventory.getItems(gamblerEntity)) do
				if item.Roulette_itemGamblerDamageUpFirstRound and item.Roulette_itemCharge then
					item.Roulette_itemCharge.charged = item.Roulette_itemCharge.charged - 1
				end
			end
		end
	end
end)

--#endregion

--#region RingCourage

event.Roulette_sequenceGunShot2.add("itemGamblerSuicideProtection", {
	order = "shot",
	sequence = -1,
}, function(ev)
	if ev.user and ev.target and ev.user.id == ev.target.id
		and not RouletteGambler.isShielding(ev.user)
		and RouletteGun.isLiveBullet(ev.parameter.bullet)
	then
		local item = RouletteRogueItem.getEquippedItem(ev.user, "Roulette_itemGamblerSuicideProtection")
		if item and item.Roulette_itemCharge and item.Roulette_itemCharge.charged > 0 then
			item.Roulette_itemCharge.charged = item.Roulette_itemCharge.charged - 1
			ev.parameter.continue = true

			Flyaway.create {
				text = item.Roulette_itemGamblerSuicideProtection.flyaway,
				entity = ev.user,
			}
			Sound.playFromEntity(item.Roulette_itemGamblerSuicideProtection.sound, ev.user)
			RouletteGambler.shield(ev.user, .5)
		end
	end
end)

--#endregion

--#region RingFreeze

event.holderRoulette_gamblerFreeze.add("itemFreezeResistance", {
	filter = { "Roulette_itemGamblerImmuneFreezing", "item" },
	order = "immunity",
}, function(ev)
	if ev.entity.item.equipped then
		ev.turns = 0
	end
end)

--#endregion

--#region RingPain

--- @param ev Event.Roulette_gamblerBeginTurn
event.Roulette_gamblerBeginTurn.add("itemAddExtraActions", "item", function(ev)
	for _, item in ipairs(Inventory.getItems(ev.entity)) do
		if (not item.item or item.item.equipped) and item.Roulette_itemAddGamblerExtraActions then
			ev.component.extraActions = ev.component.extraActions + item.Roulette_itemAddGamblerExtraActions.extraActions
		end
	end
end)

event.Roulette_gamblerEndTurn.add("itemDamageHolder", {
	filter = "health",
	order = "item",
}, function(ev)
	for _, item in ipairs(Inventory.getItems(ev.entity)) do
		local comp = item.Roulette_itemGamblerEndTurnDamage

		if comp and (not item.item or item.item.equipped) and ev.entity.health.health >= item.Roulette_itemGamblerEndTurnDamage.requiredHealth then
			Flyaway.create {
				text = comp.flyaway,
				entity = ev.entity,
			}
			Sound.playFromEntity(comp.sound, ev.entity)
			Damage.inflict {
				damage = comp.damage,
				victim = ev.entity,
				type = comp.type,
				attacker = item,
				entity = item,
			}
		end
	end
end)

--#endregion

--#region RingPeace

event.holderRoulette_itemGenerationWeightPostProcess.add("moreDamageUpItems", {
	filter = "Roulette_itemGamblerMoreDamageUpItems",
	order = "more",
}, function(ev) --- @param ev Event.Roulette_itemGenerationWeight
	if ev.prototype.Roulette_itemTagOffensive then
		ev.weight = ev.weight * 2
	end
end)

--#endregion

--#region RingPiercing

event.objectDealDamage.add("gunPiercingFromGamblerItem", {
	filter = "Roulette_gun",
	order = "penetration",
}, function(ev)
	local entity = ECS.getEntityByID(ev.entity.Roulette_gun.gambler)
	if entity and RouletteRogueItem.getEquippedItem(entity, "Roulette_itemPiercing") then
		ev.type = Damage.Flag.mask(ev.type, Damage.Flag.BYPASS_ARMOR)
	end
end)

event.objectTakeDamage.add("lowHealthInstantDeathOnReceivePiercingDamage", {
	filter = { "Roulette_gamblerLowHealthDeathOnTakePiercingDamage", "health" },
	order = "healthConvert",
	sequence = 1,
}, function(ev)
	if ev.entity.health.health == 1 and Damage.Flag.check(ev.type, Damage.Type.PIERCING) and RouletteGambler.isGambling(ev.entity.Roulette_gambler) then
		Object.kill(ev.entity, ev.attacker, nil, ev.type)
	end
end)

--#endregion

--#region RingProtection

local function needProtection(health, damage, _)
	return not health or health.health <= damage
end

event.Roulette_sequenceGunShot2.add("itemGamblerProtection", {
	order = "shot",
	sequence = -2,
}, function(ev)
	local holder = ev.target
	if holder
		and RouletteGun.isLiveBullet(ev.parameter.bullet)
		and not RouletteGambler.isShielding(holder)
		and needProtection(holder.health, RouletteGun.calculateDamage(ev.entity))
	then
		local item = RouletteRogueItem.getEquippedItem(holder, "Roulette_itemGamblerProtection")
		if item and item.Roulette_itemCharge.charged > 0 then
			item.Roulette_itemCharge.charged = item.Roulette_itemCharge.charged - 1

			Flyaway.create {
				text = item.Roulette_itemGamblerProtection.flyaway,
				entity = holder,
			}
			RouletteGambler.shield(holder, .5)

			if holder.health then
				holder.health.health = 1
			end
		end
	end
end)

--#endregion

--#region RingRegeneration

event.Roulette_sequenceGunShot2.add("itemGamblerHealOnKillHostile", {
	order = "shot",
	sequence = 1,
}, function(ev)
	if ev.user and ev.target and not Character.isAlive(ev.target) then
		local item = RouletteRogueItem.getEquippedItem(ev.user, "Roulette_itemGamblerHealOnKill")
		if item and item.Roulette_itemCharge.charged > 0
			and not (item.Roulette_itemGamblerHealOnKill.mustBeHostile and not RouletteGambler.isHostile(ev.user, ev.target, true))
		then
			Health.heal {
				entity = ev.user,
				health = item.Roulette_itemGamblerHealOnKill.health,
			}
		end
	end
end)

--#endregion

--#region RingShield

event.Roulette_sequenceGunShot2.add("itemGamblerShielding", {
	order = "shot",
	sequence = 2,
}, function(ev)
	if ev.target then
		local item = RouletteRogueItem.getEquippedItem(ev.target, "Roulette_itemGamblerShielding")
		if item and item.Roulette_itemCharge.charged > 0 then
			item.Roulette_itemCharge.charged = item.Roulette_itemCharge.charged - 1
			RouletteGambler.shield(ev.target, item.Roulette_itemGamblerShielding.turns)
		end
	end
end)

event.holderTakeDamage.override("applyDamageImmunityFirst", function(func, ev)
	if ev.entity.Roulette_itemGamblerShielding and ev.entity.item then
		local holder = ECS.getEntityByID(ev.entity.item.holder)
		if holder and holder.Roulette_gambler and RouletteGambler.isGambling(holder.Roulette_gambler) then
			return
		end
	end

	func(ev)
end)

--#endregion

--#region RingWar

event.holderRoulette_itemGenerationWeightPostProcess.add("banDamageUpItems", {
	filter = "Roulette_itemGamblerBanDamageUpItems",
	order = "ban",
}, function(ev) --- @param ev Event.Roulette_itemGenerationWeight
	if ev.prototype.Roulette_itemTagOffensive then
		ev.weight = 0
	end
end)

event.objectTakeDamage.add("gunSuppressingDamageFromGamblerItem", {
	filter = "beatDelay",
	order = "spellLate",
}, function(ev)
	local entity = ev.attacker and ev.attacker.Roulette_gun and ECS.getEntityByID(ev.attacker.Roulette_gun.gambler)
	if entity and RouletteRogueItem.getEquippedItem(entity, "Roulette_itemGamblerSuppressingDamage") then
		ev.entity.beatDelay.counter = ev.entity.beatDelay.counter + 1
	end
end)

--#endregion

--#endregion

--#region Spell

event.itemActivate.add("setGamblerDisengage", {
	filter = "Roulette_itemUseSetGamblerDisengage",
	order = "combo",
}, function(ev)
	if ev.result == Action.Result.ITEM and ev.holder and ev.holder.Roulette_gamblerDisengage then
		local comp = ev.item.Roulette_itemUseSetGamblerDisengage

		local function set()
			local val = ev.holder.Roulette_gamblerDisengage[comp.field]
			if val then
				Flyaway.create { text = comp.flyawayActivated, entity = ev.holder }
				Sound.playFromEntity(comp.soundFail, ev.holder)
			elseif not comp.activation then
				return true
			elseif Currency.get(ev.holder, Currency.Type.GOLD) < comp.gold then
				Flyaway.create { text = comp.flyawayPoor, entity = ev.holder }
				Sound.playFromEntity(comp.soundFail, ev.holder)
			else
				Currency.subtract(ev.holder, Currency.Type.GOLD, comp.gold)
				Flyaway.create { text = comp.flyawaySuccess, entity = ev.holder, delay = 1.5, duration = 3.5 }
				Sound.playFromEntity(comp.soundActivated, ev.holder)

				ev.holder.Roulette_gamblerDisengage[comp.field] = true
				comp.activation = false
			end
		end

		local success, fail = pcall(set)
		if not success or fail then
			Flyaway.create { text = comp.flyawayInactive, entity = ev.holder }
			Sound.playFromEntity(comp.soundFail, ev.holder)
		end
	end
end)

event.Roulette_gamblerBeginTurn.add("activateDisengageSpells", {
	filter = { "Roulette_gamblerDisengage", "inventory" },
	order = "item",
}, function(ev)
	for _, entity in ipairs(Inventory.getItems(ev.entity)) do
		if entity.Roulette_itemUseSetGamblerDisengage then
			entity.Roulette_itemUseSetGamblerDisengage.activation = true
		end
	end
end)

event.Roulette_gamblerEndTurn.add("deactivateDisengageSpells", {
	filter = { "Roulette_gamblerDisengage", "inventory" },
	order = "item",
}, function(ev)
	for _, entity in ipairs(Inventory.getItems(ev.entity)) do
		if entity.Roulette_itemUseSetGamblerDisengage then
			entity.Roulette_itemUseSetGamblerDisengage.activation = false
		end
	end
end)

--#endregion

return RouletteRogueItem
