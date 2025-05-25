--- @meta

local SpellTargeting = {}

function SpellTargeting.tileIterator(ev) end

function SpellTargeting.attackableTargets(ev, flags) end

--- @param ev any
--- @param component any
--- @return fun():Entity
function SpellTargeting.targetsWithComponent(ev, component) end

function SpellTargeting.entityIterator(ev) end

return SpellTargeting
