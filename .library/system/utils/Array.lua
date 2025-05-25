--- @meta

local Array = {}

Array.Type = {
	INT8 = 1,
	INT16 = 2,
	INT32 = 3,
	UINT8 = 4,
	UINT16 = 5,
	UINT32 = 6,
	FLOAT = 7,
	DOUBLE = 8,
}

function Array.isArray(arr) end

function Array.new(arrayType, size) end

function Array.fromString(arrayType, str) end

function Array.getArrayByID(arrayType, arrayID) end

function Array.getByteSizeByType(arrayType) end

function Array.copy(sourceArray, destArray, sourceOffset, destOffset, count) end

return Array
