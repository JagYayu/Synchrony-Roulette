--- @meta

local KeyRebinder = {}

function KeyRebinder.open(callback, label, subLabel, allowMultiKeys) end

function KeyRebinder.close(key) end

function KeyRebinder.isOpen() end

function KeyRebinder.setContext(contextID) end

function KeyRebinder.getContext() end

function KeyRebinder.setFilter(filter) end

return KeyRebinder
