--- @meta

local Currency = {}

Currency.Type = {
	GOLD = "gold",
	DIAMOND = "diamond",
}

function Currency.getItemForAmount(currencyType, amount) end

function Currency.isShared(currencyType) end

function Currency.setShared(currencyType, value) end

function Currency.hasComponent(entity, currencyType) end

function Currency.getComponent(entity, currencyType) end

function Currency.create(currencyType, x, y, amount) end

function Currency.get(entity, currencyType) end

function Currency.add(entity, currencyType, amount, item) end

function Currency.collect(entity, currencyType, amount) end

function Currency.subtract(entity, currencyType, amount, item) end

function Currency.set(entity, currencyType, amount, item) end

return Currency
