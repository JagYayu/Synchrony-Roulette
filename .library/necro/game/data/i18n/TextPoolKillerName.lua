--- @meta

local TextPoolKillerName = {}

TextPoolKillerName.ID = {
	--- No kill data available (legacy leaderboard entry)
	NO_DATA = 0,
	--- No death occurred (victory)
	SURVIVED = 1,
	--- Kill string not mapped in lookup table, need to peek replay data
	OUT_OF_RANGE = 2,
}

TextPoolKillerName.internal = {
}

function TextPoolKillerName.getIDForName(killerName, entityTypeName) end

function TextPoolKillerName.getNameForID(killerID) end

function TextPoolKillerName.internal.makeCompositeID(entityTypeID, componentID) end

function TextPoolKillerName.internal.splitCompositeID(compositeID) end

function TextPoolKillerName.internal.getComponentCount() end

function TextPoolKillerName.internal.getEntityTypeCount() end

return TextPoolKillerName
