-- Preprocessor plug-in for sumneko's Lua Language Server (https://github.com/sumneko/lua-language-server)

local enumTypes = {
	string = "string|integer",
	immutable = "any",
}

local function capitalizeFirst(name)
	return name:sub(1, 1):upper() .. name:sub(2)
end

local componentDefaults = {
	table = "{}",
	bool = "false",
	string = '""',
}

local fieldTypeMapping = {
	bool = "boolean",
	int = "integer",
	int8 = "integer",
	int16 = "integer",
	int32 = "integer",
	int64 = "integer",
	float = "number",
	entityID = "Entity.ID",
	string = "string",
	localizableString = "string",
	table = "table",
	variant = "any",
}

local function parseComponents(text, diffs)
	local componentModuleAlias = text:match('local%s+([a-zA-Z]*)%s*=%s*require%s*%(?"necro%.game%.data%.Components"')
	if not componentModuleAlias then
		return
	end

	local components = {}
	for regIndex, regContent in text:gmatch("()" .. componentModuleAlias .. "%.%s*register%s*%(?(%b{})") do
		for index, componentName, fieldPrefix, fieldStr in regContent:gmatch("()([a-zA-Z_][a-zA-Z0-9_]*)(%s*=%s*{)(.-)},") do
			local fieldIndexOffset = regIndex + index + #componentName + #fieldPrefix
			local fields = {}
			for fieldIndex, mutability, fieldType, fieldName, default
				in fieldStr:gmatch('()([a-z]*)%.([a-zA-Z0-9]*)%("([a-zA-Z0-9_]*)",?%s*(.-)%),')
			do
				if default == "" then
					default = componentDefaults[fieldType] or "0"
				end
				default = default:gsub("[\n\t]+", "\t"):gsub("\t}", "}")

				if fieldType == "enum" then
					fieldType, default = default:match("(.*),%s*(.*)")
					fieldType = fieldType and (fieldType:sub(1, 1):upper() .. fieldType:sub(2)) or "integer"
					default = default or "0"
				else
					fieldType = fieldTypeMapping[fieldType] or "any"
				end

				fields[#fields + 1] = {
					type = fieldType,
					name = fieldName,
					default = default,
					mutability = mutability,
					-- TODO comment support
					--comment = getCommentAt(comments, fieldIndexOffset + fieldIndex),
				}
			end
			components[#components + 1] = {
				name = componentName,
				fields = fields,
				--comment = getCommentAt(comments, index),
			}
		end
	end

	if #components > 0 then
		local output = {"\n"}
		for _, component in ipairs(components) do
			output[#output + 1] = string.format("---@class Component.%s", component.name)
			for _, field in ipairs(component.fields) do
				output[#output + 1] = string.format("---@field %s %s", field.name, field.type)
			end
			output[#output + 1] = ""
		end
		output[#output + 1] = "---@class Entity"
		for _, component in ipairs(components) do
			output[#output + 1] = string.format("---@field %s Component.%s", component.name, component.name)
		end
		output[#output + 1] = ""

		diffs[#diffs + 1] = {
			start = #text,
			finish = #text - 1,
			text = table.concat(output, "\n"),
		}
	end
end

function OnSetText(uri, text)
	if text:sub(1, 8) == "---@meta" or uri:match("core/jit/vmdef%.lua$") then
		return
	end

	local diffs = {}

	-- Limit scope of global variables to local
    for globalPos in text:gmatch("\n()([%w_]*)%s*=") do
        diffs[#diffs + 1] = {
            start  = globalPos,
            finish = globalPos - 1,
            text   = "local ",
        }
    end

	-- Parse components
	parseComponents(text, diffs)

	-- Generate aliases and completion suggestions for enumerations
	for initPos, moduleName, enumName, enumType, enumBody in text:gmatch("\n()([%w]*)%.([%w]*)%s*=%s*[Ee]num%.([%w]*)%s*(%b{})") do
		local comments = {}
		local members = {}

		-- Detect comments above each key within the enum body
		for commentPos, comment in enumBody:gmatch("\n%s*()%-%-%-?%s*([^\n]*)") do
			-- Skip TODO comments
			if comment:sub(1, 4) ~= "TODO" then
				comments[#comments + 1] = {commentPos, comment}
			end
		end

		-- Detect enum key definitions
		for keyPos, key in enumBody:gmatch("\n%s*()([%w_]*)%s*=") do
			-- Workaround to avoid picking up enum data (TODO - clean this up!)
			if key == key:upper() then
				local prefix = (#members == 0 and ">" or " ")
				while comments[1] and comments[1][1] < keyPos do
					-- Insert all comments preceding this key
					members[#members + 1] = string.format("--- %s", table.remove(comments, 1)[2])
				end
				members[#members + 1] = string.format("---|%s`%s.%s.%s`", prefix, moduleName, enumName, key)
			end
		end

		diffs[#diffs + 1] = {
            start  = initPos,
            finish = initPos - 1,
            text   = string.format("---@alias %s.%s %s\n%s\n\n", capitalizeFirst(moduleName), enumName,
				enumTypes[enumType] or "integer", table.concat(members, "\n")),
        }
	end

    return diffs
end
