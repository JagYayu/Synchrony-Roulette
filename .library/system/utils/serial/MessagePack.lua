--- @meta

local MessagePack = {}

MessagePack.packers = {
}

function MessagePack.packers.array(buffer, tbl, n) end

function MessagePack.packers.integer(buffer, n) end

function MessagePack.packers.number(buffer, n) end

function MessagePack.packers._string(buffer, str) end

function MessagePack.packers._table(buffer, tbl) end

function MessagePack.packers.binary(buffer, str) end

function MessagePack.packers.boolean(buffer, bool) end

function MessagePack.packers.double(buffer, n) end

function MessagePack.packers.ext(buffer, tag, data) end

function MessagePack.packers.fixext1(buffer, tag, data) end

function MessagePack.packers.fixext16(buffer, tag, data) end

function MessagePack.packers.fixext2(buffer, tag, data) end

function MessagePack.packers.fixext4(buffer, tag, data) end

function MessagePack.packers.fixext8(buffer, tag, data) end

function MessagePack.packers.float(buffer, n) end

function MessagePack.packers.map(buffer, tbl, n) end

MessagePack.packers["nil"] = function(buffer) end

function MessagePack.packers.signed(buffer, n) end

function MessagePack.packers.string(buffer, str) end

function MessagePack.packers.string_compat(buffer, str) end

function MessagePack.packers.table(buffer, tbl) end

function MessagePack.packers.unsigned(buffer, n) end

return MessagePack
