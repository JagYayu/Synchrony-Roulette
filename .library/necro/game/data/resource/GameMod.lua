--- @meta

local GameMod = {}

function GameMod.getModDisplayName(modName) end

function GameMod.listAvailableAssetMods() end

function GameMod.listLoadedAssetMods() end

function GameMod.getAssetModName(name) end

function GameMod.getAssetModPath(name) end

function GameMod.getModGridMenuEntry() end

function GameMod.isModLoaded(name) end

function GameMod.isModAvailable(name) end

function GameMod.isModdedSession() end

return GameMod
