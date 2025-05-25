--- @meta

local ItemPickup = {}

--- @enum ItemPickup.Result
ItemPickup.Result = {
	FAILURE = -1,
	NONE = 0,
	SUCCESS = 1,
}

function ItemPickup.tryCollect(item, holder, silent, count) end

function ItemPickup.playPickupEffects(item, holder, count) end

function ItemPickup.noisyGrant(itemName, holder) end

return ItemPickup
