--- @meta

local ModWorkshop = {}

function ModWorkshop.isAutoMountEnabled() end

function ModWorkshop.isMounted(fileID) end

function ModWorkshop.getContentRoot(fileID) end

function ModWorkshop.isReady(fileID) end

function ModWorkshop.mount(fileID) end

function ModWorkshop.unmount(fileID) end

function ModWorkshop.listSubscriptions() end

function ModWorkshop.install(fileID) end

function ModWorkshop.installAll() end

function ModWorkshop.lookUpFileIDForName(name) end

function ModWorkshop.getModNameForFileID(fileID) end

function ModWorkshop.getImage(fileID, imageType) end

function ModWorkshop.getHomepageURL(fileID) end

function ModWorkshop.getWorkshopURL() end

function ModWorkshop.getUploader(fileID) end

function ModWorkshop.getDescription(fileID) end

function ModWorkshop.getActiveDownloads() end

function ModWorkshop.loadInstallPathCache() end

function ModWorkshop.saveInstallPathCache() end

function ModWorkshop.extract(fileID) end

return ModWorkshop
