--- @meta

local CustomMusic = {}

function CustomMusic.createPlaylist(name) end

--- @param playlist string
--- @return table?
function CustomMusic.readMetadata(playlist) end

function CustomMusic.writeMetadata(playlist, metadata) end

function CustomMusic.isPlaylist(playlist) end

function CustomMusic.hasCustomBeatmaps(modName) end

function CustomMusic.clearCache() end

function CustomMusic.reload(playlist) end

function CustomMusic.unloadAll() end

function CustomMusic.listPlaylists() end

function CustomMusic.createAndEdit(name) end

function CustomMusic.edit(playlist) end

function CustomMusic.isLocked() end

function CustomMusic.isAnyPlaylistLoaded() end

return CustomMusic
