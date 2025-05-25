--- @meta

local PriceTag = {}

function PriceTag.add(saleEntity, priceTagEntity) end

function PriceTag.remove(saleEntity) end

--- @param buyer Entity
--- @param priceTagEntity Entity
--- @return { effectiveCost: number, affordable: boolean, multiplier: number, buyer: Entity, price: Entity, coupon: boolean? }
function PriceTag.check(buyer, priceTagEntity) end

function PriceTag.getEffectiveCost(buyer, priceTagEntity) end

function PriceTag.pay(buyer, priceTagEntity) end

function PriceTag.getDepthMultiplier() end

return PriceTag
