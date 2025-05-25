--- @meta

local CurrencyComponents = {}

--- Tracks this entity’s gold.
--- @class Component.goldCounter
--- @field amount integer # `= 0` Protected field! Do not modify directly, use `Currency.set` instead.

--- Tracks this entity’s diamonds.
--- @class Component.diamondCounter
--- @field amount integer # `= 0` Protected field! Do not modify directly, use `Currency.set` instead.

--- Causes this entity to drop gold when it dies.
--- @class Component.dropCurrencyOnDeath
--- @field currencyType string # `= currency.Type.GOLD` 
--- @field amount integer # `= 0` 

--- Specific to the Leprechaun.
--- @class Component.dropCurrencyOnMove
--- @field currencyType string # `= currency.Type.GOLD` 
--- @field amount integer # `= 0` 
--- @field limit integer # `= 0` 
--- @field castAfterLimit string # `= ""` 

--- Specific to the Leprechaun.
--- @class Component.conditionalCurrencyDrop
--- @field currencyType string # `= currency.Type.GOLD` 
--- @field amount integer # `= 0` 

--- Makes it easier for this entity to avoid gold, via several minor gameplay changes:
--- 
--- * Causes Earth Spell to delete gold
--- * Disables gold drop from the Leprechaun
--- * Disables gold collection during dashes
--- * Disables gold doubling from Crown of Greed
--- @class Component.goldHater

--- Forces enemies killed by this entity to drop at least some amount of gold.
--- This applies even to enemies without `dropCurrencyOnDeath`, but it doesn’t apply
--- to enemies that don’t give CURRENCY credit (see `Kill.Credit`).
--- @class Component.minimumCurrencyDrop
--- @field currencyType string # `= currency.Type.GOLD` 
--- @field minimum integer # `= 0` 

--- Makes this a currency item. Currency items don’t stay in the holder’s inventory:
--- they increase the holder’s currency counter on pickup, then get deleted.
--- @class Component.itemCurrency
--- @field currencyType string # `= currency.Type.GOLD` 

--- Makes this item eligible to be spawned by `Currency.create`.
--- @class Component.itemCurrencyConvertible

--- Causes the holder to collect all nearby gold when moving.
--- @class Component.itemAutoCollectCurrencyOnMove
--- @field currencyType string # `= currency.Type.GOLD` 
--- @field singlePlayerSquareDistance integer # `= 1000000` Maximum inclusive square distance at which gold is collected in single-player
--- @field multiPlayerSquareDistance integer # `= 1000000` Maximum inclusive square distance at which gold is collected in multi-player

--- Multiplies the prices the holder needs to pay.
--- @class Component.itemPurchasePriceMultiplier
--- @field multiplier number # `= 1` 

--- Multiplies the gold gained by the holder when selling items.
--- @class Component.itemSellPriceMultiplier
--- @field multiplier number # `= 1` 

--- Specific to the Coupon.
--- @class Component.itemConsumeOnPurchase

--- Multiplies the gold gained by the holder when picking up gold.
--- @class Component.itemCurrencyPickupMultiplier
--- @field currencyType string # `= currency.Type.GOLD` 
--- @field multiplier number # `= 1` 

--- Increases gold dropped by enemies killed by the holder.
--- @class Component.itemIncreaseCurrencyDrops
--- @field currencyType string # `= currency.Type.GOLD` 
--- @field amount integer # `= 0` 
--- @field applyMultiplier boolean # `= false` 
--- @field minimum integer # `= 0` Unlike `minimumCurrencyDrop`, this minimum does *not* apply to enemies without `dropCurrencyOnDeath`.

--- Causes the holder to lose some gold every beat.
--- @class Component.itemCurrencyDrain
--- @field currencyType string # `= currency.Type.GOLD` 
--- @field currencyPerTurn integer # `= 0` 

--- Changes this item’s label and pickup flyaway to indicate stack size.
--- @class Component.itemCurrencyLabel
--- @field suffix localizedString # `= 0` 
--- @field minimumQuantity integer # `= 0` 

--- @class Entity
--- @field goldCounter Component.goldCounter
--- @field diamondCounter Component.diamondCounter
--- @field dropCurrencyOnDeath Component.dropCurrencyOnDeath
--- @field dropCurrencyOnMove Component.dropCurrencyOnMove
--- @field conditionalCurrencyDrop Component.conditionalCurrencyDrop
--- @field goldHater Component.goldHater
--- @field minimumCurrencyDrop Component.minimumCurrencyDrop
--- @field itemCurrency Component.itemCurrency
--- @field itemCurrencyConvertible Component.itemCurrencyConvertible
--- @field itemAutoCollectCurrencyOnMove Component.itemAutoCollectCurrencyOnMove
--- @field itemPurchasePriceMultiplier Component.itemPurchasePriceMultiplier
--- @field itemSellPriceMultiplier Component.itemSellPriceMultiplier
--- @field itemConsumeOnPurchase Component.itemConsumeOnPurchase
--- @field itemCurrencyPickupMultiplier Component.itemCurrencyPickupMultiplier
--- @field itemIncreaseCurrencyDrops Component.itemIncreaseCurrencyDrops
--- @field itemCurrencyDrain Component.itemCurrencyDrain
--- @field itemCurrencyLabel Component.itemCurrencyLabel

return CurrencyComponents
