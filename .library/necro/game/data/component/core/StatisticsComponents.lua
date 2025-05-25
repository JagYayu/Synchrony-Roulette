--- @meta

local StatisticsComponents = {}

--- @class Component.statisticIncreaseOnDeath
--- @field stat string # `= ""` 
--- @field receiver Statistics.Receiver # `= statistics.Receiver.ENTITY` 

--- @class Component.statisticIncreaseOnKill
--- @field stat string # `= ""` 
--- @field receiver Statistics.Receiver # `= statistics.Receiver.ENTITY` 
--- @field damageFlags integer # `= 0` 
--- @field targetComponent string # `= "killable"` 

--- @class Component.statisticIncreaseOnMultiKill
--- @field stat string # `= ""` 
--- @field receiver Statistics.Receiver # `= statistics.Receiver.ENTITY` 
--- @field damageFlags integer # `= 0` 
--- @field threshold integer # `= 0` 
--- @field targetComponent string # `= "killable"` 
--- @field turnID integer # `= -1` 
--- @field killCount integer # `= 0` 

--- @class Component.statisticIncreaseOnElectricityMultiKill
--- @field stat string # `= ""` 
--- @field receiver Statistics.Receiver # `= statistics.Receiver.ENTITY` 
--- @field threshold integer # `= 0` 

--- @class Component.statisticMaximizeToHeartContainers
--- @field stat string # `= ""` 
--- @field receiver Statistics.Receiver # `= statistics.Receiver.ENTITY` 
--- @field healthPerContainer integer # `= 1` 

--- @class Component.statisticMaximizeToCurrencyCount
--- @field stat string # `= ""` 
--- @field receiver Statistics.Receiver # `= statistics.Receiver.ENTITY` 
--- @field currencyType string # `= currency.Type.GOLD` 

--- @class Component.statisticIncreaseOnSnipe
--- @field stat string # `= ""` 
--- @field receiver Statistics.Receiver # `= statistics.Receiver.ENTITY` 

--- @class Component.statisticKillMarkerFriendlyFire

--- @class Component.statisticKillMarkerMostlyHarmless

--- @class Component.statisticDamageSnipeMarker

--- @class Entity
--- @field statisticIncreaseOnDeath Component.statisticIncreaseOnDeath
--- @field statisticIncreaseOnKill Component.statisticIncreaseOnKill
--- @field statisticIncreaseOnMultiKill Component.statisticIncreaseOnMultiKill
--- @field statisticIncreaseOnElectricityMultiKill Component.statisticIncreaseOnElectricityMultiKill
--- @field statisticMaximizeToHeartContainers Component.statisticMaximizeToHeartContainers
--- @field statisticMaximizeToCurrencyCount Component.statisticMaximizeToCurrencyCount
--- @field statisticIncreaseOnSnipe Component.statisticIncreaseOnSnipe
--- @field statisticKillMarkerFriendlyFire Component.statisticKillMarkerFriendlyFire
--- @field statisticKillMarkerMostlyHarmless Component.statisticKillMarkerMostlyHarmless
--- @field statisticDamageSnipeMarker Component.statisticDamageSnipeMarker

return StatisticsComponents
