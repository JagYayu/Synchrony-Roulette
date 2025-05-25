--- @meta

local SwipeComponents = {}

--- Changes the frameY of swipes created by this weapon depending on the holder’s grooveChain.
--- @class Component.weaponGrooveChainSwipeRow
--- @field maxGroove integer # `= 3` 

--- Creates a swipe on the tile where this spell is cast.
--- @class Component.spellcastCoreSwipe
--- @field type string # `= ""` 
--- @field data table # 

--- Creates a swipe on the tile where this spell is redirected.
--- @class Component.spellcastRedirectSwipe
--- @field type string # `= ""` 
--- @field data table # 

--- Overrides the swipe tiles when redirecting this spell, which is required for some swipes to work properly.
--- @class Component.spellcastRedirectOverrideSwipeTiles

--- Creates a swipe on each tile within this spell’s range.
--- @class Component.spellcastMultiSwipe
--- @field type string # `= ""` 
--- @field skipCoreTile boolean # `= false` 
--- @field useCastDirection boolean # `= true` 

--- Creates a swipe on the tile of each valid target of this spell.
--- @class Component.spellcastSwipeTargets
--- @field type string # `= ""` 
--- @field attackFlags Attack.Flag # `= attack.Flag.CHARACTER` 

--- Creates a swipe whenever this entity moves.
--- @class Component.moveSwipe
--- @field texture string # `= "ext/particles/jump_dirt.png"` 
--- @field width integer # `= 24` 
--- @field height integer # `= 24` 
--- @field duration number # `= 1/3` 
--- @field numFrames integer # `= 5` 
--- @field offsetY integer # `= -2` 

--- @class Entity
--- @field weaponGrooveChainSwipeRow Component.weaponGrooveChainSwipeRow
--- @field spellcastCoreSwipe Component.spellcastCoreSwipe
--- @field spellcastRedirectSwipe Component.spellcastRedirectSwipe
--- @field spellcastRedirectOverrideSwipeTiles Component.spellcastRedirectOverrideSwipeTiles
--- @field spellcastMultiSwipe Component.spellcastMultiSwipe
--- @field spellcastSwipeTargets Component.spellcastSwipeTargets
--- @field moveSwipe Component.moveSwipe

return SwipeComponents
