--- @meta

local ModDLC = {}

function ModDLC.registerDLC(modName, available) end

function ModDLC.registerBundle(modName, available, autoLoad) end

function ModDLC.registerMetadata(modName, metadata) end

function ModDLC.isRegistered(modName) end

function ModDLC.isDLCMod(modName) end

function ModDLC.isBundledMod(modName) end

function ModDLC.isAvailable(modName) end

function ModDLC.getMetadata(modName, key) end

function ModDLC.getAllDLCs() end

function ModDLC.getUnavailableDLCs() end

function ModDLC.isAutoLoadable(modName) end

return ModDLC
