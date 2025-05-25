--- @meta

local TextPool = {}

function TextPool.get(key) end

function TextPool.format(key, ...) end

function TextPool.register(text, key) end

function TextPool.registerTable(prefix, entries) end

return TextPool
