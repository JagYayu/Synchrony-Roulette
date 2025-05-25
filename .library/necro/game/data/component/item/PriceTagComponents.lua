--- @meta

local PriceTagComponents = {}

--- Associates an entity with a purchase price that must be paid before it can be picked up or activated
--- @class Component.sale
--- @field priceTag Entity.ID # Link to the price tag entity. If not present, this entity is free.

--- Indicates the purchase price of the associated sale entity
--- @class Component.priceTag
--- @field active boolean # `= true` The current effective purchasability of the entity

--- Deletes the associated price tag when the sale entity is picked up
--- @class Component.saleRemoveOnCollect

--- Copies the price tag alongside its sale item
--- @class Component.priceTagCloneable

--- Deletes the associated price tag when the sale entity is despawned
--- @class Component.saleRemoveOnDespawn

--- Causes a sale entity to become temporarily free when the associated shopkeeper leaves the shop or dies
--- @class Component.priceTagShopkeeperProximity
--- @field default boolean # `= true` The value priceTag.active is set to when there’s no associated shopkeeper
--- @field shopkeeper Entity.ID # The associated shopkeeper

--- Requires a certain amount of currency to purchase an entity
--- @class Component.priceTagCostCurrency
--- @field currency string # `= currency.Type.GOLD` The currency with which the entity can be purchased
--- @field cost number # `= 0` The current purchase cost of the entity, which is the base cost multiplied with a level-specific factor

--- Multiply the tag's cost by (2 + depth / 2) on spawn
--- @class Component.priceTagDepthMultiplier
--- @field active boolean # `= true` 

--- Requires a certain amount of health to purchase an entity
--- @class Component.priceTagCostHealth
--- @field cost integer # `= 0` The amount of health drained when purchasing the entity
--- @field type Damage.Flag # `= damage.Type.BLOOD` The type of damage dealt by this price tag upon purchase
--- @field killerName localizedString # `= "Blood Debt"` Text to display in the run summary screen's "Killed by" entry

--- Applies sell price multipliers to this price tag, and ignore purchase price multipliers.
--- @class Component.priceTagUseSellMultiplier

--- Ignores purchase price multipliers for this price tag.
--- @class Component.priceTagIgnoreMultiplier

--- Multiplies the cost of this price tag after each successful transaction.
--- @class Component.priceTagMultiplyCostOnPurchase
--- @field multiplier integer # `= 2` 
--- @field cap integer # `= 9999999999` 

--- Allows shoplifters (Monk, Dove) to bypass this price tag, once per shop.
--- @class Component.priceTagShopliftable
--- @field allowFurtherPurchases boolean # `= false` By default, after shoplifting once, shoplifters can not buy any other item in the same shop. If this is true, they’re instead treated like normal characters after the first sale.

--- Allows the sold item to be picked up even if it is banned for the buyer.
--- @class Component.priceTagIgnoreItemBans

--- Changes the flyaway displayed when picking up the sold item.
--- @class Component.priceTagModifyFlyaway
--- @field format localizedString # `= "%s"` 

--- Marks this entity as a shopkeeper, disabling all associated price tags when it leaves its home or dies.
--- @class Component.shopkeeper

--- Generates transaction tiles near this entity on spawn, and associates them with this entity.
--- The behavior of transactions started with those tiles is determined by `transaction` components
--- on this entity (controlled by the `shopkeeperTransaction` event).
--- @class Component.secretShopkeeper
--- @field tileX integer # `= 0` 
--- @field tileY integer # `= 0` 
--- @field createShop boolean # `= true` 

--- Starts a transaction concerning a given item slot when this trap is triggered.
--- @class Component.trapTransaction
--- @field slot string # `= ""` 
--- @field shopkeeper Entity.ID # 
--- @field targetX integer # `= 0` 
--- @field targetY integer # `= 0` 

--- Transactions with this shopkeeper require the client to have an unbanned item in the relevant slot.
--- @class Component.transactionCheckItemBan
--- @field banMask integer # `= 0` 
--- @field errorFlyaway localizedString # `= 0` 

--- Transactions with this shopkeeper delete the item the client had in the relevant slot.
--- @class Component.transactionDeleteItem
--- @field errorFlyaway localizedString # `= "You have no item in that slot!"` 

--- Transactions with this shopkeeper give the client gold based on the `itemPrice` of the item
--- they had in the relevant slot.
--- @class Component.transactionSellItem
--- @field errorFlyaway localizedString # `= "I won't buy that!"` 

--- Transactions with this shopkeeper spawn a new item of the relevant slot.
--- @class Component.transactionSpawnItem
--- @field chanceType string # `= "secret"` 
--- @field collisionMask Collision.Type, collision.unmask(collision.Group.ITEM_PLACEMENT # `= collision.Type.PLAYER)` 
--- @field levelBonus integer # `= 0` 
--- @field errorFlyaway localizedString # `= 0` 

--- Transactions with this shopkeeper teleport the client to the position given by `trapTransaction.targetX/Y`.
--- @class Component.transactionTeleportClient

--- Plays a sound when a transaction with this shopkeeper is successful.
--- @class Component.transactionSound
--- @field sound string # `= ""` 

--- Plays a sound when a transaction with this shopkeeper fails for any reason.
--- @class Component.transactionErrorSound
--- @field sound string # `= "error"` 

--- Flashes a sound when a transaction with this shopkeeper is successful.
--- @class Component.transactionScreenFlash

--- Creates a flyaway when a transaction with this shopkeeper is successful.
--- @class Component.transactionFlyaway
--- @field text localizedString # `= "Success!"` 

--- Upon provocation, deletes transaction tiles associated with this shopkeeper.
--- @class Component.transactionAutoDespawnOnProvoke
--- @field shopkeeper Entity.ID # 

--- Lets this entity get one free item from each shop.
--- @class Component.shoplifter
--- @field stolenShopkeepers table # 

--- @class Entity
--- @field sale Component.sale
--- @field priceTag Component.priceTag
--- @field saleRemoveOnCollect Component.saleRemoveOnCollect
--- @field priceTagCloneable Component.priceTagCloneable
--- @field saleRemoveOnDespawn Component.saleRemoveOnDespawn
--- @field priceTagShopkeeperProximity Component.priceTagShopkeeperProximity
--- @field priceTagCostCurrency Component.priceTagCostCurrency
--- @field priceTagDepthMultiplier Component.priceTagDepthMultiplier
--- @field priceTagCostHealth Component.priceTagCostHealth
--- @field priceTagUseSellMultiplier Component.priceTagUseSellMultiplier
--- @field priceTagIgnoreMultiplier Component.priceTagIgnoreMultiplier
--- @field priceTagMultiplyCostOnPurchase Component.priceTagMultiplyCostOnPurchase
--- @field priceTagShopliftable Component.priceTagShopliftable
--- @field priceTagIgnoreItemBans Component.priceTagIgnoreItemBans
--- @field priceTagModifyFlyaway Component.priceTagModifyFlyaway
--- @field shopkeeper Component.shopkeeper
--- @field secretShopkeeper Component.secretShopkeeper
--- @field trapTransaction Component.trapTransaction
--- @field transactionCheckItemBan Component.transactionCheckItemBan
--- @field transactionDeleteItem Component.transactionDeleteItem
--- @field transactionSellItem Component.transactionSellItem
--- @field transactionSpawnItem Component.transactionSpawnItem
--- @field transactionTeleportClient Component.transactionTeleportClient
--- @field transactionSound Component.transactionSound
--- @field transactionErrorSound Component.transactionErrorSound
--- @field transactionScreenFlash Component.transactionScreenFlash
--- @field transactionFlyaway Component.transactionFlyaway
--- @field transactionAutoDespawnOnProvoke Component.transactionAutoDespawnOnProvoke
--- @field shoplifter Component.shoplifter

return PriceTagComponents
