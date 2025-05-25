--- @meta

local CommonEnemy = {}

function CommonEnemy.miniboss(entity) end

--- Floating: unaffected by tile effects, earthquake, and traps
function CommonEnemy.floating(entity) end

function CommonEnemy.stageDancer(entity) end

function CommonEnemy.massive(entity) end

function CommonEnemy.ignoreLiquids(entity) end

function CommonEnemy.phasing(entity) end

function CommonEnemy.itemUser(entity, item) end

function CommonEnemy.dropsOnDeath(entity, item) end

--- Transform into a headless skeleton at 1 heart
function CommonEnemy.beheadable(entity, type) end

function CommonEnemy.directionalShield(entity, defaultDirection) end

function CommonEnemy.armoredSkeletonShield(entity, type) end

--- Grab the player on attack
function CommonEnemy.grabber(entity, grabAI) end

--- Trample tiles and enemies until revealed
function CommonEnemy.trampler(entity, digStrength) end

function CommonEnemy.charger(entity) end

--- Unattackable until a player gets close
function CommonEnemy.hidden(entity, radius) end

--- Standard mimic
function CommonEnemy.mimic(entity, provokeRadius, animationRadius) end

function CommonEnemy.cratelike(entity, bypassDamage, soundPrefix, isContainer) end

--- Cannot move, even from knockback or fear (can still be teleported)
function CommonEnemy.immovable(entity) end

--- Generate animations for any zombie type
function CommonEnemy.zombieFrames(entity, up, left, down) end

function CommonEnemy.mage(entity, wand) end

function CommonEnemy.noActivationRadius(entity) end

function CommonEnemy.boss(entity, bossType) end

function CommonEnemy.lightSource(entity, innerRadius, outerRadius) end

function CommonEnemy.burrowing(entity) end

function CommonEnemy.spirit(entity) end

function CommonEnemy.defaultComponents(entity) end

function CommonEnemy.basicComponents(entity, x, y, z) end

return CommonEnemy
