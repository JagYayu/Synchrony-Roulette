--- @meta

local RemoteSettings = {}

function RemoteSettings.hasPermissions() end

function RemoteSettings.upload() end

function RemoteSettings.reset() end

function RemoteSettings.setLocalOverrideValue(key, value) end

function RemoteSettings.getLocalOverrideValue(key) end

function RemoteSettings.resetLocalOverrideValue(key) end

function RemoteSettings.isLocallyOverridden(key) end

function RemoteSettings.isRemotelyOverridden(key) end

return RemoteSettings
