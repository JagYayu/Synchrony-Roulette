--- @meta

local TransformationMatrix = {}

function TransformationMatrix.new(matrix) end

function TransformationMatrix.translation(x, y) end

function TransformationMatrix.scale(x, y) end

function TransformationMatrix.rotation(angle) end

--- @param matrix table
function TransformationMatrix.inverse(matrix) end

return TransformationMatrix
