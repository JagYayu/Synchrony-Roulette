--- @meta

local LJBuffer = {}

--- @alias LJBuffer.Serializable table|number|boolean|string|nil

--- Serializes the specified list of objects, which can later be extracted individually.
--- `nil` entries cannot be encoded and signify the end of the input array.
--- 
--- @param values LJBuffer.Serializable[] List of values to serialize
--- @return string str The encoded representation of all input values
function LJBuffer.multipartEncode(values) end

--- Generates a function for deserializing the contents of the specified string encoded by `multipartEncode`.
--- Once the end is reached, `nil` is returned.
--- 
--- @param str string Data to be deserialized
--- @return fun():LJBuffer.Serializable decoder Iterator function yielding data parts in order of serialization
function LJBuffer.multipartDecode(str) end

--- Post-processes a serialized LuaJIT buffer string to yield an equivalent deterministic string.
--- 
--- @param str string The serialized data to be determinized
--- @return string str Deterministic and unique string representing the same object
function LJBuffer.determinize(str) end

--- Checks if the specified value is safely encodable by LJBuffer, and encodes it if possible.
--- 
--- Distinguishes between unsafe encodable values (metatables, but no invalid types) by returning `nil`, and
--- unencodable values (invalid types, cycles) by returning `false`.
--- 
--- @param value table|number|boolean|string|nil The value to be encoded
--- @return boolean? encodable true if safely encodable, false on encoding errors, nil on metatables
--- @return string? str Value encoded as a string, or nil if encoding failed
function LJBuffer.safeEncode(value) end

return LJBuffer
