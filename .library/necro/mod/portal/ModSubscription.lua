--- @meta

local ModSubscription = {}

function ModSubscription.isAutoInstallEnabled() end

function ModSubscription.isAutoUpdateEnabled() end

function ModSubscription.isAutoUninstallEnabled() end

function ModSubscription.isReady() end

function ModSubscription.subscribe(modName) end

function ModSubscription.unsubscribe(modName) end

function ModSubscription.isSubscribed(modName) end

function ModSubscription.updateSubscriptions(force) end

function ModSubscription.fireSubscriptionEvent(modName, state, version) end

return ModSubscription
