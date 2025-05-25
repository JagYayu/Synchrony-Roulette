--- @meta

local ItemStash = {}

function ItemStash.get(holder) end

function ItemStash.getOrCreate(holder) end

function ItemStash.store(item, holder) end

function ItemStash.storeBannedItems(holder, banTarget, banMask) end

function ItemStash.extractAllItems(holder, banMask) end

function ItemStash.transferHealth(args) end

return ItemStash
