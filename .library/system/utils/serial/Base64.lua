--- @meta

local Base64 = {}

function Base64.makeencoder(s62, s63, spad) end

function Base64.makedecoder(s62, s63, spad) end

function Base64.encode(str, encoder, usecaching) end

function Base64.decode(b64, decoder, usecaching) end

return Base64
