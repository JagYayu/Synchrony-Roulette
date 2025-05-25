--- @meta

local Rectangle = {}

--- @class Rectangle
--- @field [1] number X-coordinate of the rectangle's top left corner
--- @field [2] number Y-coordinate of the rectangle's top left corner
--- @field [3] number Width of the rectangle, growing to the right
--- @field [4] number Height of the rectangle, growing downwards

--- @class Rectangle
--- @field [1] number X-coordinate of the rectangle's top left corner
--- @field [2] number Y-coordinate of the rectangle's top left corner
--- @field [3] number Width of the rectangle, growing to the right
--- @field [4] number Height of the rectangle, growing downwards
function Rectangle.copy(rect) end

function Rectangle.intersection(a, b) end

function Rectangle.union(a, b) end

function Rectangle.contains(rect, x, y) end

function Rectangle.expand(rect, left, up, right, down) end

function Rectangle.resizeAroundCenter(rect, width, height) end

function Rectangle.scale(rect, scaleX, scaleY, centerX, centerY) end

function Rectangle.scaleAroundCenter(rect, scaleX, scaleY) end

function Rectangle.lerp(rect1, rect2, factor) end

function Rectangle.outset(rect, outset) end

function Rectangle.inset(rect, inset) end

return Rectangle
