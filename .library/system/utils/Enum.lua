--- @meta

local Enum = {}

--- @class Enumeration
--- @field extend fun(key:string,value:integer|nil):integer
--- @field data table<integer,table>
--- @field names table<integer,string>
--- @field keyList string[]
--- @field valueList integer[]
--- @field indices table<integer,integer>
--- @field builtInMin integer
--- @field builtInMax integer
--- @field prettyNames table<integer,string>

--- @class EnumerationBitmask: Enumeration
--- @field mask fun(v1:integer, v2:integer, ...):integer
--- @field unmask fun(v1:integer, v2:integer):integer
--- @field check fun(v1:integer, v2:integer):boolean
--- @field checkAll fun(v1:integer, v2:integer):boolean
--- @field inspect fun(v:integer):string

--- @return number
function Enum.data(data) end

--- @generic V
--- @param value? V
--- @return V
function Enum.entry(value, data) end

--- @generic V
--- @param value V
--- @return V
function Enum.literal(value, data) end

--- Iterates over the numeric values and data attributes of the specified enumeration, in order of increasing value.
function Enum.dataPairs(enumeration) end

--- Creates a sequential enumeration. Entries can be assigned arbitrary integer values.
--- @generic E
--- @param tbl E
--- @return E|Enumeration
function Enum.sequence(tbl) end

--- Creates a positive sequential enumeration. Entries can be assigned positive integer values only.
--- @generic E
--- @param tbl E
--- @return E|Enumeration
function Enum.positiveSequence(tbl) end

--- Creates a negative sequential enumeration. Entries can be assigned negative integer values only.
--- @generic E
--- @param tbl E
--- @return E|Enumeration
function Enum.negativeSequence(tbl) end

--- Creates a bitmask enumeration from the specified table. Entries should be numbered consecutively, starting from
--- 0 for a "NONE" value, or from 1 for the first bit value. Values are automatically converted to powers of 2.
--- Up to 32 non-zero entries are supported.
--- @generic E
--- @param tbl E
--- @return E|EnumerationBitmask
function Enum.bitmask(tbl) end

--- Creates a string enumeration from the specified table. The string keys are simply used as values directly.
--- @generic E
--- @param tbl E
--- @return E|Enumeration
function Enum.string(tbl) end

--- Creates a protocol enumeration. Built-in entries are assigned numeric values, while extended entries use the string
--- key as their value.
--- @generic E
--- @param tbl E
--- @return E|Enumeration
function Enum.protocol(tbl) end

--- @generic E
--- @param tbl E
--- @return E
function Enum.immutable(tbl) end

return Enum
