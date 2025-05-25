--- @meta

local NetworkModDownload = {}

function NetworkModDownload.reset() end

function NetworkModDownload.isDisconnectOnClose() end

function NetworkModDownload.isEscapeBlocked() end

function NetworkModDownload.close() end

function NetworkModDownload.isMatching(modName) end

function NetworkModDownload.getLocalVersion(modName) end

function NetworkModDownload.getTargetVersion(modName) end

function NetworkModDownload.hasPendingDownload(modName) end

function NetworkModDownload.hasMismatches() end

function NetworkModDownload.isFailed(modName) end

function NetworkModDownload.getMismatchVersions(modName) end

function NetworkModDownload.download(modName) end

function NetworkModDownload.downloadAll() end

function NetworkModDownload.listMods() end

function NetworkModDownload.update() end

return NetworkModDownload
