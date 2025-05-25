--- @meta

local ScreenShakeComponents = {}

--- @class Component.screenShakeEffect
--- @field duration number # `= 0` 
--- @field intensity integer # `= 0` 
--- @field range integer # `= 0` 
--- @field active boolean # `= false` 

--- @class Component.screenShakeRequireFocus

--- @class Component.screenShakeStandalone
--- @field expiryTurnID integer # `= -1` 

--- @class Component.screenShakeOnWalk
--- @field duration number # `= 0.25` 
--- @field intensity number # `= 10` 
--- @field range number # `= 16` 

--- @class Component.screenShakeOnAttack

--- @class Component.screenShakeOnHit

--- @class Component.screenShakeOnDig

--- @class Entity
--- @field screenShakeEffect Component.screenShakeEffect
--- @field screenShakeRequireFocus Component.screenShakeRequireFocus
--- @field screenShakeStandalone Component.screenShakeStandalone
--- @field screenShakeOnWalk Component.screenShakeOnWalk
--- @field screenShakeOnAttack Component.screenShakeOnAttack
--- @field screenShakeOnHit Component.screenShakeOnHit
--- @field screenShakeOnDig Component.screenShakeOnDig

return ScreenShakeComponents
