--- @meta

local ItemStorage = {}

function ItemStorage.getItemOrPrototype(item) end

function ItemStorage.store(item, container) end

function ItemStorage.insertAtIndex(item, container, index) end

function ItemStorage.getAtIndex(container, itemIndex) end

function ItemStorage.getItemCount(container) end

--- @return Entity[]
function ItemStorage.getItems(container) end

function ItemStorage.dropIndex(container, itemIndex, x, y) end

function ItemStorage.deleteIndex(container, itemIndex) end

function ItemStorage.replaceIndex(container, itemIndex, replacement) end

function ItemStorage.dropItem(item, x, y) end

function ItemStorage.applyUpgrades(item, player) end

function ItemStorage.clear(container) end

function ItemStorage.getDefaultDropOffsets() end

function ItemStorage.scatter(container, x, y, offsets, collisionMask, tweenType) end

return ItemStorage
