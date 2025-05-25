--- @meta

local AssetCollector = {}

AssetCollector.Type = {
	TILESET_ZONE_1 = 1,
	TILESET_ZONE_2 = 2,
	TILESET_ZONE_3_HOT = 3,
	TILESET_ZONE_3_COLD = 4,
	TILESET_ZONE_4 = 5,
	TILESET_ZONE_5 = 6,
	TILESET_BOSS = 7,
	SPRITE = 8,
	HEAD_SPRITE = 9,
	CLONE_SPRITE = 10,
	FOLLOWER_SPRITE = 11,
	ARTWORK = 12,
	VARIANT_SPRITE = 13,
	ATTACHMENT = 14,
	SWIPE = 15,
	PARTICLE = 16,
	SPELL = 17,
	SOUND = 18,
	VOICE = 19,
	BEATMAP = 20,
	SONG = 21,
	VOCALS = 22,
	VOCALS_2 = 23,
	VOCALS_DAOUST = 24,
	XML = 25,
	OTHER = 26,
}

AssetCollector.Category = {
	PLAYER_CHARACTER = 1,
	ITEM = 2,
	ENEMY = 3,
	OBJECT = 4,
	TILE = 5,
	VISUAL_EFFECT = 6,
	HUD = 7,
	UI = 8,
	IMAGE = 9,
	SOUND = 10,
	MUSIC = 11,
	BEATMAP = 12,
	OTHER = 13,
}

function AssetCollector.list() end

return AssetCollector
