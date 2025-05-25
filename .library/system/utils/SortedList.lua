--- @meta

local SortedList = {}

function SortedList.contains(list, value) end

function SortedList.insert(list, value) end

function SortedList.insertUnique(list, value) end

function SortedList.remove(list, value) end

function SortedList.containsOrdered(list, value, compare) end

--- @generic T
--- @param list T[]
--- @param value T
--- @param compare fun(l: T, r: T): boolean?
function SortedList.insertOrdered(list, value, compare) end

function SortedList.insertUniqueOrdered(list, value, compare) end

function SortedList.removeOrdered(list, value, compare) end

function SortedList.mergeListPair(list1, list2, comparator) end

function SortedList.mergeLists(lists, comparator) end

function SortedList.removeDuplicates(list) end

return SortedList
