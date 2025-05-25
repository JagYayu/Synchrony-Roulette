--- @meta

local Color = {}

--- @alias Color integer

Color.TRANSPARENT = 0x00000000
Color.BLACK = 0xFF000000
Color.WHITE = 0xFFFFFFFF
Color.RED = 0xFF0000FF
Color.GREEN = 0xFF00FF00
Color.BLUE = 0xFFFF0000
Color.CYAN = 0xFFFFFF00
Color.MAGENTA = 0xFFFF00FF
Color.YELLOW = 0xFF00FFFF

--- @return Color
function Color.rgba(r, g, b, a) end

--- @return Color
function Color.opacity(a) end

--- @return Color
function Color.gray(value) end

function Color.rgb(r, g, b) end

function Color.getR(c) end

function Color.getG(c) end

function Color.getB(c) end

function Color.getA(c) end

function Color.setR(c, r) end

function Color.setG(c, g) end

function Color.setB(c, b) end

function Color.setA(c, a) end

--- @return integer r
--- @return integer g
--- @return integer b
--- @return integer a
function Color.getRGBA(c) end

function Color.getRGBANormalized(c) end

function Color.getTable(c) end

--- @return Color
function Color.fade(c, factor) end

function Color.darken(c, factor) end

function Color.hsv(h, s, v, a) end

function Color.toHSV(c) end

function Color.fromTable(table) end

return Color
