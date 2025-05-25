--- @meta

local Frame = {}

--- itemPickup < mergeItemStacks for courage-duping
--- fieldOfView < updateRevealed < aggro < actability for aggro timing
--- itemPickup < fieldOfView for vision on pickup
--- itemPickup < tileEffects for tile protection items
--- itemPickup < enforceSlotCapacity for swapping off bags
--- provoke < convertObjects so that provokableConversions get processed
--- provoke < tileEffects for beetles shedding on the opposite element sink immediately
Frame.frameSelector = {
}

return Frame
