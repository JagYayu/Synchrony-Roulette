--- @meta

local Translation = {}

Translation.Language = {
	BUILT_IN = "",
	ALL = "all",
	ENGLISH = "en_US",
	GERMAN = "de_DE",
	SPANISH = "es_ES",
	FRENCH = "fr_FR",
	ITALIAN = "it_IT",
	JAPANESE = "ja_JP",
	KOREAN = "ko_KR",
	PORUGUESE = "pt_BR",
	RUSSIAN = "ru_RU",
	SIMPLIFIED_CHINESE = "zh_CN",
	TRADITIONAL_CHINESE = "zh_TW",
}

function Translation.reload() end

function Translation.list() end

--- @return fun(strings: table<string, string>)
function Translation.generator() end

function Translation.setSessionTranslation(languageID) end

function Translation.getSessionTranslation() end

function Translation.getIsoCode(languageID) end

function Translation.getDisplayName(languageID) end

function Translation.getLanguageName(languageID) end

function Translation.getAuthor(languageID) end

function Translation.getInternationalFont(variant) end

function Translation.isPixelFontEnabled() end

function Translation.isCJKFontEnabled() end

function Translation.getPreferredFont(languageID) end

function Translation.openDirectory() end

return Translation
