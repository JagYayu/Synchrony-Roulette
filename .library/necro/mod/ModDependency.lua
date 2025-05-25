--- @meta

local ModDependency = {}

function ModDependency.getDependees(modName) end

function ModDependency.hasDependees(modName) end

function ModDependency.getDependencies(modName) end

function ModDependency.getRemoteDependencies(modName) end

function ModDependency.loadDependencies(dependee, package) end

function ModDependency.downloadDependencies(dependee, callback) end

function ModDependency.unloadUnneededDependencies() end

function ModDependency.markAuto(modName) end

function ModDependency.unmarkAuto(modName) end

function ModDependency.isMarkedAuto(modName) end

return ModDependency
