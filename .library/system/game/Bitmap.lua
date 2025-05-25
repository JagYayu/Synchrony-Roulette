--- @meta

local Bitmap = {}

function Bitmap.load(filename) end

--- @param width integer
--- @param height integer
--- @return Bitmap
function Bitmap.new(width, height) end

--- @param bm Bitmap
--- @param rect Rectangle
--- @return Bitmap
function Bitmap.crop(bm, rect) end

--- @return Bitmap
function Bitmap.copy(bm) end

--- [nodoc] Unsupported.
function Bitmap.imageToPNG(imageDataString) end

return Bitmap
