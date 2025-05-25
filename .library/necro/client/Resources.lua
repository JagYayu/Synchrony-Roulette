--- @meta

local Resources = {}

function Resources.resetLog() end

function Resources.clear() end

function Resources.getName(resourceID) end

function Resources.getVersion(resourceID) end

function Resources.hasData(resourceID) end

function Resources.getData(resourceID) end

function Resources.getResourceChangeLog() end

function Resources.getResourceIDs() end

function Resources.getDownloadProgress() end

function Resources.getUploadProgress() end

function Resources.upload(resourceID, name, data, partialUpdatePath) end

function Resources.uploadIfChanged(resourceID, name, data) end

function Resources.getResourceVersionMap() end

function Resources.hasAtLeastVersions(resourceVersionMap) end

function Resources.allTransfersDone() end

function Resources.isResourceListReady() end

return Resources
