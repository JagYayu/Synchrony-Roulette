--- @meta

local Utilities = {}

--- Same as `string.lower`, but caches the result, improving performance when used repeatedly for the same string.
--- @param text string
--- @return string
function Utilities.toLowercaseCache(text) end

--- Fully copies a table. This is slower, but more generic, than the other copy functions in this module.
--- @param tbl table
--- @return table
function Utilities.deepCopy(tbl) end

--- Copies a table. Nested sub-tables are not copied.
--- @param tbl table
--- @return table
function Utilities.shallowCopy(tbl) end

--- Fully copies a table. Doesn’t work on tables that contain functions or metatables.
--- @generic T
--- @param value T
--- @return T
function Utilities.fastCopy(value) end

--- Copies a list. This is even faster than `fastCopy`, but *only* works on lists.
--- @generic T
--- @param tbl T[]
--- @return T[]
function Utilities.arrayCopy(tbl) end

--- Reverses a list in-place.
--- @generic T
--- @param tbl T[]
--- @return T[] tbl `tbl`, after having reversed it.
function Utilities.reverse(tbl) end

--- Protects a table from being modified.
--- @param tbl table
--- @return table tbl
function Utilities.readOnlyTable(tbl) end

--- @param tbl1 table
--- @param tbl2 table
--- @return boolean result true if the two tables contain the same values.
function Utilities.deepEquals(tbl1, tbl2) end

--- @generic T
--- @param tbl1 T[]
--- @param tbl2 T[]
--- @return boolean result true if the two lists contain the same values.
function Utilities.arrayEquals(tbl1, tbl2) end

--- @generic T
--- @param tbl T[]
--- @param value T
--- @return number|nil index the index of the first occurence of `value` in `tbl`, or `nil` if `value` isn’t found.
function Utilities.arrayFind(tbl, value) end

--- Removes the first occurence of a value from a list.
--- @generic T
--- @param tbl T[]
--- @param value T
--- @return number|nil index the index of the occurence of `value` that was removed, or `nil` if `value` isn’t found.
function Utilities.arrayRemove(tbl, value) end

--- @param object any
--- @return string str A human-readable string representation of `object`.
function Utilities.inspect(object) end

--- Appends a list at the end of another list.
--- @generic T
--- @param tbl1 T[] This will be modified in-place.
--- @param tbl2 T[]
--- @return T[] result `tbl1`, after having appended `tbl2` to it.
function Utilities.concatArrays(tbl1, tbl2) end

--- Creates a new list by concatenating two existing lists.
--- @generic T
--- @param tbl1 table T[]
--- @param tbl2 table T[]
--- @return T[] tbl A list of all values in `tbl1`, followed by all values in `tbl2`.
function Utilities.copyConcatArrays(tbl1, tbl2) end

--- Removes values that match a given condition from a list.
--- @generic T
--- @param tbl T[]
--- @param func fun(value:T):boolean? A function to call on each value in `tbl` to decide whether to remove it.
--- @return T[] tbl `tbl`, after having removed entries from it.
function Utilities.removeIf(tbl, func) end

--- Like removeIf, but passing an extra argument to the filter function.
--- @generic T
--- @generic TArg
--- @param tbl T[]
--- @param func fun(value:T,arg:TArg):boolean A function to call on each value in `tbl` to decide whether to remove it.
--- @param arg TArg
--- @return T[] tbl `tbl`, after having removed entries from it.
function Utilities.removeIfArg(tbl, func, arg) end

--- Applies a function to each element in a list and returns the results, omitting nil results.
--- @generic T Input type
--- @generic R Output type
--- @param tbl T[] List of values to apply the function to. Order will be preserved.
--- @param func fun(value:T):R Transformation function to apply to each element
--- @return R[]
function Utilities.map(tbl, func) end

--- Removes key-value pairs that match a given condition from a table.
--- @param tbl table
--- @param func function A function to call on each key-value pair in `tbl` to decide whether to remove it.
--- @return table tbl `tbl`.
function Utilities.tableRemoveIf(tbl, func) end

--- Removes duplicate entries in a list.
--- @generic T
--- @param tbl T[]
--- @return T[] tbl `tbl`, after having removed duplicates from it.
function Utilities.removeDuplicates(tbl) end

--- Returns the index of the first element in `tbl` that is >= `value`.
--- @param tbl number[]
--- @param value number
--- @return number
function Utilities.lowerBound(tbl, value) end

--- Returns the index of the first element in `tbl` that is >= `value`, using a custom comparator.
--- @param tbl number[]
--- @param value number
--- @return number
function Utilities.lowerBoundOrdered(tbl, value, compare) end

--- @param lowLimit number
--- @param value number
--- @param upLimit number
--- @return number
function Utilities.clamp(lowLimit, value, upLimit) end

--- [nodoc] Convenience function to make a cache... but the only reason to make a cache is for performance,
--- and this has worse performance than handling the cache manually.
function Utilities.cacheTable(func, tbl) end

--- Copies entries from `src` to `dest.
--- @param dest table
--- @param src table
--- @return table dest `dest`, after having merged `src` into it.
function Utilities.mergeTables(dest, src) end

--- Copies entries from `src` to `dest`.
--- @param dest table
--- @param src table
--- @param maxDepth? number Sub-tables deeper than this many levels deep are not merged.
--- @return table dest `dest`, after having merged `src` into it.
function Utilities.mergeTablesRecursive(dest, src, maxDepth) end

--- Copies entries from `src` to `dest`, prioritizing existing entries in `dest`.
--- Intended for merging a shared "default" table from `src` into a table literal passed in in `dest`.
--- Example: `utils.mergeDefaults(ui.Font.SYSTEM, {size = 32})`
--- @param src table Map-style table, entries of which will be copied to `dest` if not already present there
--- @param dest table Map-style table, modified in-place to fill any missing keys with corresponding values from `src`
--- @return table dest `dest`, after having merged `src` into it.
function Utilities.mergeDefaults(src, dest) end

--- [nodoc]
function Utilities.createGaplessTable(tbl) end

--- Returns a list of the table’s key-value pairs.
--- Example: { b = 42, a = 51, c = 12 } => {{"b", 42}, {"a", 51}, {"c", 12}}
--- @param tbl table
--- @return any[]
function Utilities.flatten(tbl) end

--- Returns the table’s keys as a list.
--- Example: { b = 42, a = 51, c = 12 } => {"b", "a", "c"}
--- @param tbl table
--- @return any[]
function Utilities.getKeyList(tbl) end

--- Returns the table’s values as a list.
--- Example: { b = 42, a = 51, c = 12 } => {42, 51, 12}
--- @param tbl table
--- @return any[]
function Utilities.getValueList(tbl) end

--- Returns the list of values in the specified table, ordered by their respective keys.
--- Allows mixed key types, sorting them via `compareAny`.
--- Example: { b = 42, a = 51, c = 12 } => {51, 42, 12}
--- @param tbl table Key-value table to obtain ordered entries from
--- @return any[] result List of entries, ordered by their key
function Utilities.getOrderedValueList(tbl) end

--- Returns the keys and values of the table as two separate lists.
--- Example: { b = 42, a = 12, c = 51 } => {"b", "a", "c"}, {42, 12, 51}
--- @param tbl table
--- @return any[] keys List of keys.
--- @return any[] values List of values.
function Utilities.getKeyValueLists(tbl) end

--- @param value1 any
--- @param value2 any
--- @return boolean lessThan true if `value1` < `value2`.
function Utilities.compareAny(value1, value2) end

--- Returns an iterator over the table’s key-value pairs, sorted by keys.
--- @generic T: table, K, V
--- @param tbl T
--- @return fun(table: table<K, V>, index?: K):K, V
--- @return T
function Utilities.sortedPairs(tbl) end

--- Same as table.sort, but returns the sorted list.
--- @generic T
--- @param tbl T[]
--- @return T[] tbl `tbl`, after having sorted it.
function Utilities.sort(tbl, compare) end

--- Converts a list to a set.
--- Example: {"a", "b", "c"} => { a = true, b = true, c = true }
--- @param list any[]
--- @return table
function Utilities.listToSet(list) end

--- Same as `Utils.listToSet`, but caches the result, improving performance when used repeatedly for the same list.
--- @param list any[]
--- @return table
function Utilities.listToSetCached(list) end

--- Clears the cache used by `Utils.listToSetCached`.
function Utilities.clearListToSetCache() end

--- @param targetTable table
--- @param keyPath any[]
--- @param value any
--- @return boolean Whether the operation succeeded.
function Utilities.setKeyAtPath(targetTable, keyPath, value) end

--- @param targetTable table
--- @param keyPath any[]
--- @return any
function Utilities.getKeyAtPath(targetTable, keyPath) end

--- @param v1 number
--- @param v2 number
--- @param factor number Expected to be between 0 and 1
--- @return number result A number between v1 and v2, getting linearly closer to v2 when factor is higher.
function Utilities.lerp(v1, v2, factor) end

--- @param edge number
--- @param x number
--- @return number result 1 if edge <= x, 0 otherwise.
function Utilities.step(edge, x) end

--- @param x number
--- @return number sign 1 if x > 0, -1 if x < 0, 0 if x == 0.
function Utilities.sign(x) end

--- @param x number
--- @return number rounded x rounded towards 0.
function Utilities.truncate(x) end

--- @param dx number
--- @param dy number
--- @return number distance The L1 norm of (dx, dy): |dx| + |dy|.
function Utilities.distanceL1(dx, dy) end

--- @param dx number
--- @param dy number
--- @return number distance The square of the L2 norm of (dx, dy): dx² + dy².
function Utilities.squareDistance(dx, dy) end

--- Exact floored square root function without any floating point weirdness (hopefully).
--- @param value number
--- @return number
function Utilities.floorSquareRoot(value) end

--- @param valueOrFunction any
--- @param default any
--- @return any
function Utilities.eval(valueOrFunction, default) end

return Utilities
