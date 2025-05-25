--- @meta

local BitUtilities = {}

function BitUtilities.genRange(offset, size) end

function BitUtilities.setRange(bitset, offset, size, value) end

function BitUtilities.getRange(bitset, offset, size) end

function BitUtilities.setSignedRange(bitset, offset, size, value) end

function BitUtilities.getSignedRange(bitset, offset, size) end

function BitUtilities.setBool(bitset, offset, boolValue) end

function BitUtilities.test(bitset, offset) end

function BitUtilities.set(bitset, offset, value) end

function BitUtilities.get(bitset, offset) end

return BitUtilities
