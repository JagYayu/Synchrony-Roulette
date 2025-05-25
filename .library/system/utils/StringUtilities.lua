--- @meta

local StringUtilities = {}

function StringUtilities.equalsIgnoreCase(str1, str2) end

function StringUtilities.compareIgnoreCase(str1, str2) end

function StringUtilities.split(str, delimiter) end

function StringUtilities.separateCamelCase(str, separator) end

--- Iterates over all matches of a pattern within a string, similar to `string.gmatch`, but also returns the index of
--- each encountered match as the first return value.
--- @param str string
--- @param pattern string
--- @return fun():integer,string,...
function StringUtilities.iterateMatches(str, pattern) end

function StringUtilities.leftPad(str, length, character, abbrev) end

function StringUtilities.rightPad(str, length, character, abbrev) end

function StringUtilities.capitalizeFirst(str) end

function StringUtilities.titleCase(str) end

function StringUtilities.startsWith(str, startStr) end

function StringUtilities.endsWith(str, endStr) end

function StringUtilities.removePrefix(str, prefix) end

function StringUtilities.interpolate(str, parameters) end

function StringUtilities.toUnicode(text, forceCopy) end

function StringUtilities.fromUnicode(text) end

function StringUtilities.parseQueryString(queryString) end

function StringUtilities.buildQueryString(base, args, ampersand) end

function StringUtilities.compareVersions(v1, v2) end

function StringUtilities.initialism(str, length) end

function StringUtilities.didYouMean(bad, goods) end

return StringUtilities
