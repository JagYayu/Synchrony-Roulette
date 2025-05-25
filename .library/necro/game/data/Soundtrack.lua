--- @meta

local Soundtrack = {}

--- @class Soundtrack.Song
--- @field type Soundtrack.TrackType The type of track to play on this level
--- @field zone? integer Zone of the track to play on this level (should be between 1 and 4, or 5 for AMPLIFIED)
--- @field floor? integer Floor number of the track to play on this level (should be between 1 and 3)
--- @field boss? Boss.Type Boss music to play on this level

Soundtrack.Variant = {
	DEFAULT = "",
	HOT = "h",
	COLD = "c",
	ALTERNATIVE = "a",
	ALTERNATIVE_2 = "b",
}

Soundtrack.Artist = {
	GIRLFRIEND_RECORDS = 5,
	DANNY_B = 1,
	CUSTOM = 10,
	A_RIVAL = 2,
	FAMILYJULES7X = 3,
	VIRT = 4,
	OC_REMIX = 6,
	CHIPZEL = 7,
	DANGANRONPA = 8,
	RANDOM = 9,
}

Soundtrack.Vocals = {
	NONE = "",
	SHOPKEEPER = "shopkeeper",
	MONSTROUS_SHOPKEEPER = "shopkeeper_m",
	NICOLAS_DAOUST = "shopkeeper_nd",
}

Soundtrack.TrackType = {
	ZONE = "zone",
	BOSS = "boss",
	LOBBY = "lobby",
	TRAINING = "training",
	TUTORIAL = "tutorial",
	CREDITS = "credits",
	MAIN_MENU = "main_menu",
}

Soundtrack.LayerType = {
	NONE = 0,
	MAIN = 1,
	SHOPKEEPER = 2,
	HOT = 4,
	COLD = 8,
	TENTACLE_DRUMS = 16,
	TENTACLE_HORNS = 32,
	TENTACLE_STRINGS = 64,
	TENTACLE_KEYTAR = 128,
	FORTISSIMOLE = 256,
	PHASE_2 = 512,
}

function Soundtrack.getDefaultArtists() end

function Soundtrack.getActiveArtist() end

function Soundtrack.setCharacterArtist(character, artist) end

function Soundtrack.getCharacterArtist(character) end

function Soundtrack.setDefaultArtist(artist) end

function Soundtrack.getDefaultArtist() end

function Soundtrack.isArtistAvailable(artist) end

function Soundtrack.setVocalist(vocal) end

function Soundtrack.getVocalist() end

function Soundtrack.isVocalistAvailable(vocal) end

function Soundtrack.setCustomMusicEnabled(enabled) end

function Soundtrack.isCustomMusicEnabled() end

function Soundtrack.playMenuMusic(transition) end

function Soundtrack.getTrack(params) end

return Soundtrack
