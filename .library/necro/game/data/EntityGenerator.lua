--- @meta

local EntityGenerator = {}

function EntityGenerator.merge(components, entity, mergeFunc, skipMissingComponents) end

function EntityGenerator.removeMappingComponents(entity) end

function EntityGenerator.removeNonHeritableComponents(entity) end

function EntityGenerator.variant(ev, suffix) end

function EntityGenerator.generateEnemy(data) end

function EntityGenerator.generateItem(data) end

function EntityGenerator.generatePlayer(data) end

return EntityGenerator
