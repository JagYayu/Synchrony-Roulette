--- @meta

local Localization = {}

function Localization.loadLanguage(languageData) end

function Localization.getLoadedLanguageID() end

function Localization.get(key, default) end

function Localization.textToKey(text) end

function Localization.getFormatter(key) end

function Localization.format(key, default, ...) end

return Localization
