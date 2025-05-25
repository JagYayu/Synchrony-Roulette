local RouletteGame = require "Roulette.Game"
local RouletteMenu = {}
local RouletteUtility = require "Roulette.Utility"

local Color = require "system.utils.Color"
local ECS = require "system.game.Entities"
local FileIO = require "system.game.FileIO"
local GFX = require "system.gfx.GFX"
local Menu = require "necro.menu.Menu"
local SettingsStorage = require "necro.config.SettingsStorage"
local Sound = require "necro.audio.Sound"
local SystemInput = require "system.game.Input"
local TextFormat = require "necro.config.i18n.TextFormat"
local TextPool = require "necro.config.i18n.TextPool"
local Theme = require "necro.config.Theme"
local Translation = require "necro.config.i18n.Translation"
local UI = require "necro.render.UI"
local Utilities = require "system.utils.Utilities"

local getLTxt = TextPool.get

L.prefix("")

RouletteMenu.Mode2TextKey = {
	[RouletteGame.FreeMode] = "mod.Roulette.guide.standard",
	[RouletteGame.RogueMode] = "mod.Roulette.guide.rogue",
	[RouletteGame.RogueModeSeeded] = "mod.Roulette.guide.rogue",
}

local function getScaleFactor()
	return math.min(tonumber(SettingsStorage.get "display.scaleFactor") or 1, 2)
end

local getTutorialEntries
do
	local tagHandlers = {
		H = function(args)
			args.entry.font = UI.Font.MEDIUM
			args.entry.height = getScaleFactor() * 2
			args.entry.text = args.entry.text .. TextFormat.color(args.info, Theme.Color.HIGHLIGHT)
		end,
		Img = function(args)
			local texture = "mods/Roulette/gfx/menu/" .. args.info
			local _, h = GFX.getImageSize(texture)
			local scale = getScaleFactor() / 4
			args.entry.height = h * scale
			args.entry.text = args.entry.text .. TextFormat.icon(texture, scale)
			args.entry.y = math.max(args.entry.y or 0, h * scale / 2)
		end,
		L = function(args)
			args.localizationID = (tonumber(args.localizationID) or 0) + 1
			local localizedText = TextPool.get(("mod.Roulette.tutorial.%s.%s"):format(args.filename, args.localizationID))
			args.entry.text = args.entry.text .. (localizedText or args.info)
		end,
		T = function(args)
			args.entry.text = args.entry.text .. args.info
		end,
		h = function(args)
			args.entry.text = args.entry.text .. TextFormat.color(args.info, Theme.Color.SELECTION)
		end,
	}

	getTutorialEntries = function(filename)
		local entries = {}

		local data = FileIO.readFileToString(("mods/Roulette/data/%s.txt"):format(filename))
		if not data then
			return entries
		end

		local handlerArgs = { filename = filename }
		for line in data:gmatch("([^\n]*)\n?") do
			local entry = { text = "" }
			handlerArgs.entry = entry

			for tag, info in line:gmatch("%[(%w+)%](.-)%[/%1%]") do
				if tagHandlers[tag] then
					handlerArgs.tag = tag
					handlerArgs.info = info
					tagHandlers[tag](handlerArgs, info, entry)
				end
			end

			entries[#entries + 1] = entry
		end

		return entries
	end
end

function RouletteMenu.applyTutorialMenu(menu, filename)
	menu.entries = {}
	menu.directionalConfirmation = false
	menu.fixedHeight = true
	menu.fixedWidth = true
	menu.footerSize = 32
	menu.mouseControl = false
	menu.padding = false
	menu.width = Menu.getScreenWidth() * .8
	menu.height = Menu.getScreenHeight() * .8

	local entries = menu.entries

	local selectionEntry
	local heightDiff = math.floor(menu.height / 2) - 32

	local function scrollAbsolute(y)
		selectionEntry.y = y
		local scrollHeight = Menu.getCurrent().scrollHeight
		if scrollHeight then
			selectionEntry.y = Utilities.clamp(heightDiff, selectionEntry.y, scrollHeight - heightDiff)
		end
	end

	local function scrollRelative(dy)
		return scrollAbsolute(selectionEntry.y + dy)
	end

	function menu.touchScrollCallback(_, dy)
		scrollRelative(dy)
	end

	function menu.tickCallback(_, _)
		scrollRelative(64 * -SystemInput.scrollY())
	end

	selectionEntry = {
		selected = true,
		y = heightDiff,
		action = function()
			Menu.close()
		end,
		upAction = function()
			if scrollRelative(-96) then
				menu.playSelectionSound(-1)
			end
		end,
		downAction = function()
			if scrollRelative(96) then
				menu.playSelectionSound(1)
			end
		end
	}
	entries[#entries + 1] = selectionEntry

	local maxWidth = math.floor(menu.width * .5) * 2 - 128
	local offsetX = math.floor(maxWidth * 0.5)

	local scale = getScaleFactor()
	local y = 25
	for i, entry in ipairs(getTutorialEntries(filename)) do
		local alignX = 0
		local alignY = 0

		local text = tostring(entry.text)
		text = menu.Roulette_i18n and L(text, menu.Roulette_i18n .. i) or text

		local font = Utilities.mergeDefaults(entry.font or UI.Font.SMALL, { wordWrap = true })
		local fontSize = font.size * 2

		local offsetY = tonumber(entry.y) or 0
		local offsetHeight = tonumber(entry.height) or 0

		y = y + offsetHeight
		entries[#entries + 1] = {
			selectableIf = false,
			label = text,
			font = font,
			fontSize = fontSize,
			action = RouletteUtility.emptyFunction,
			x = offsetX * (alignX - 0.5) * 2 - 10,
			y = y + offsetY - offsetHeight,
			maxWidth = maxWidth,
			alignX = alignX,
			alignY = alignY,
		}

		local boundingBox = UI.measureText {
			font = font,
			size = fontSize,
			text = entry.text,
			maxWidth = maxWidth,
		}
		y = y + boundingBox.height + 4 * scale
	end

	return menu
end

RouletteMenu.TutorialStandard = "Roulette_StandardModeTutorial"

RouletteMenu.Language2StandardTutorialFile = {
	[Translation.Language.BUILT_IN] = "guide_standard",
	[Translation.Language.SIMPLIFIED_CHINESE] = "guide_standard_zh_cn",
	[Translation.Language.TRADITIONAL_CHINESE] = "guide_standard_zh_tw",
}

event.menu.add("standardModeTutorial", RouletteMenu.TutorialStandard, function(ev)
	ev.menu = RouletteMenu.applyTutorialMenu({
		Roulette_i18n = "guide.standard.",
		label = getLTxt "mod.Roulette.guide" .. ":" .. getLTxt "mod.Roulette.guide.standard",
	}, ev.Roulette_filename or RouletteMenu.Language2StandardTutorialFile[Translation.getSessionTranslation()] or RouletteMenu.Language2StandardTutorialFile[Translation.Language.BUILT_IN])
end)

RouletteMenu.TutorialRogue = "Roulette_RogueModeGuide"

RouletteMenu.Language2RogueTutorialFile = {
	[Translation.Language.BUILT_IN] = "guide_rogue",
	[Translation.Language.SIMPLIFIED_CHINESE] = "guide_rogue_zh_cn",
	[Translation.Language.TRADITIONAL_CHINESE] = "guide_rogue_zh_tw",
}

event.menu.add("rogueModeTutorial", RouletteMenu.TutorialRogue, function(ev)
	ev.menu = RouletteMenu.applyTutorialMenu({
		Roulette_i18n = "guide.rogue.",
		label = getLTxt "mod.Roulette.guide" .. ":" .. getLTxt "mod.Roulette.guide.rogue",
	}, ev.Roulette_filename or RouletteMenu.Language2RogueTutorialFile[Translation.getSessionTranslation()] or RouletteMenu.Language2RogueTutorialFile[Translation.Language.BUILT_IN])
end)

RouletteMenu.Manual = "Roulette_Manual"

event.menu.add("manual", RouletteMenu.Manual, function(ev)
	ev.menu = {
		label = ev.arg.label,
		entries = {},
		fixedWidth = true,
		fixedHeight = true,
		width = Menu.getScreenWidth() * .75,
		height = Menu.getScreenHeight() * .9,
		renderCallback = function()
			--
		end,
	}

	if not ev.arg then
		return
	end
	local categories = ev.arg.categories
	if type(categories) ~= "table" then
		return
	end

	local categoryWithPrototypeList = {}
	for _, category in ipairs(categories) do
		local prototypes = {}
		for _, prototype in ECS.prototypesWithComponents(category.components) do
			categoryWithPrototypeList.prototypeCount = (categoryWithPrototypeList.prototypeCount or 0) + 1
			prototypes[#prototypes + 1] = prototype
		end

		if category.compare then
			table.sort(prototypes, category.compare)
		end

		categoryWithPrototypeList[#categoryWithPrototypeList + 1] = {
			category = category,
			prototypes = prototypes,
		}
	end

	local entries = ev.menu.entries

	local currentID = 0

	local entrySize = 32
	local entryPadding = 12
	local entriesWidth = ev.menu.width / 2 - entryPadding * 2
	local entriesX = 72
	local entriesCountX = math.floor(entriesWidth / 2 / entrySize)

	for entryIndex, entry in ipairs(categoryWithPrototypeList) do
		local minID = currentID
		local maxID = minID + #entry.prototypes
		local x = entriesX

		for i, prototype in ipairs(entry.prototypes) do
			currentID = currentID + 1
			local id = currentID

			local function genDirAct(v)
				return v > 0 and function()
					if id == maxID then
						Menu.selectByID(maxID + 1)
					elseif id + v > maxID then
						Menu.selectByID(maxID)
					else
						Menu.selectByID(math.min(id + v, categoryWithPrototypeList.prototypeCount))
					end
					Sound.playUI "UISelectDown"
				end or v < 0 and function()
					if id == minID then
						Menu.selectByID(minID - 1)
					elseif id + v < minID then
						Menu.selectByID(minID)
					else
						Menu.selectByID(math.max(0, id + v))
					end
					Sound.playUI "UISelectUp"
				end
			end

			local icon
			if prototype.sprite then
				local sprite = prototype.sprite

				local w = sprite.width
				local h = sprite.height
				local s
				if w > h then
					s = entrySize / w
					w = entrySize
					h = h * s
				else
					s = entrySize / h
					h = entrySize
					w = w * s
				end

				local iconData = {
					image = sprite.texture,
					imageRect = { sprite.textureShiftX, sprite.textureShiftY, sprite.width, sprite.height },
					width = w,
					height = h,
					color = Color.WHITE,
				}

				icon = function()
					iconData.color = Color.hsv(0, 0, (Menu.getSelectedID() == id) and 1 or .5)
					return iconData
				end
			end

			entries[#entries + 1] = {
				id = id,
				x = x - ev.menu.width / 2,
				y = (entryIndex - 1 + math.floor(i / entriesCountX)) * 64,
				label = not icon and prototype.name or nil,
				icon = icon,
				action = RouletteUtility.emptyFunction,
				upAction = genDirAct(-10),
				downAction = genDirAct(10),
				rightAction = genDirAct(1),
				leftAction = genDirAct(-1),
			}

			x = x + 64
			if x > entriesCountX then
				--
			end
		end
	end
end)

RouletteMenu.Guide = "Roulette_Guide"

event.menu.add("guide", RouletteMenu.Guide, function(ev)
	local arg = type(ev.arg) == "table" and ev.arg or {}

	local entries = {}

	local mode = RouletteGame.isAnyModeActive()
	local function modeSuffix(s, ...)
		for i = 1, 9 do
			if select(i, ...) == mode then
				return s .. " " .. getLTxt "mod.Roulette.guideCurrentMode"
			end
		end
		return s
	end

	entries[#entries + 1] = {
		label = modeSuffix(getLTxt "mod.Roulette.guide.standard", RouletteGame.FreeMode),
		action = function()
			Menu.open(RouletteMenu.TutorialStandard)
		end,
	}
	entries[#entries + 1] = {
		label = modeSuffix(getLTxt "mod.Roulette.guide.rogue", RouletteGame.RogueMode, RouletteGame.RogueModeSeeded),
		action = function()
			Menu.open(RouletteMenu.TutorialRogue)
		end,
	}

	entries[#entries + 1] = { height = 0 }

	local function addManualEntry(label, categories)
		entries[#entries + 1] = { label = label }
		entries[#entries].action = function()
			Menu.open(RouletteMenu.Manual, {
				label = label,
				categories = categories,
			})
		end
	end
	-- addManualEntry(getLTxt "mod.Roulette.guide.manualItem", {
	-- 	{
	-- 		key = "base",
	-- 		name = "Base Items",
	-- 		components = { "Roulette_categoryBaseItem" },
	-- 	},
	-- 	{
	-- 		key = "rogue",
	-- 		name = "All Zone Mode Items",
	-- 		components = { "Roulette_categoryRogueItem" },
	-- 	},
	-- 	{
	-- 		key = "armor",
	-- 		name = "Armors",
	-- 		components = { "Roulette_categoryArmor" },
	-- 	},
	-- 	{
	-- 		key = "ring",
	-- 		name = "Rings",
	-- 		components = { "Roulette_categoryRing" },
	-- 	},
	-- 	{
	-- 		key = "charm",
	-- 		name = "Charms",
	-- 		components = { "Roulette_categoryCharm" },
	-- 	},
	-- })
	-- entries[#entries + 1] = {
	-- 	label = "怪物手册",
	-- 	action = function()
	-- 		Menu.open(RouletteMenu.Manual)
	-- 	end,
	-- }

	entries[#entries + 1] = { height = 0 }
	entries[#entries + 1] = {
		label = L("Back", "menu.customizeMenu.back"),
		action = Menu.close,
		sound = "UIBack",
	}

	ev.menu = {
		label = getLTxt "mod.Roulette.guide",
		entries = entries,
	}
end)

event.menu.add("rogueModePauseMenu", {
	key = "pause",
	sequence = 10,
}, function(ev)
	if ev.menu and ev.menu.entries and RouletteGame.isAnyModeActive() then
		table.insert(ev.menu.entries, 5, {
			label = getLTxt "mod.Roulette.guideRoulette",
			action = function()
				Menu.open(RouletteMenu.Guide)
			end,
		})
	end
end)

return RouletteMenu
