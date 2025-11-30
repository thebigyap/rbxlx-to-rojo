local HttpService = game:GetService("HttpService")

local BASE_URL = "http://localhost:8080/save"

local function buildPath(obj)
	local parts = {}
	local current = obj

	while current and current ~= game do
		table.insert(parts, 1, current.Name)
		current = current.Parent
	end

	return table.concat(parts, "/")
end

local function exportScript(obj)
	local relPath = buildPath(obj)

	local ok, sourceOrErr = pcall(function()
		return obj.Source
	end)

	if not ok then
		warn("Cannot read Source for " .. relPath .. " (" .. obj.ClassName .. "): " .. tostring(sourceOrErr))
		return
	end

	local ext = ".lua"
	if obj:IsA("Script") then
		ext = ".server.lua"
	elseif obj:IsA("LocalScript") then
		ext = ".client.lua"
	end

	local payload = {
		path = relPath .. ext,
		className = obj.ClassName,
		source = sourceOrErr,
	}

	local json
	local okEncode, encodeErr = pcall(function()
		json = HttpService:JSONEncode(payload)
	end)

	if not okEncode then
		warn("Failed to encode " .. relPath .. ": " .. tostring(encodeErr))
		return
	end

	local success, postErr = pcall(function()
		HttpService:PostAsync(BASE_URL, json, Enum.HttpContentType.ApplicationJson)
	end)

	if not success then
		warn("Failed to send " .. relPath .. ": " .. tostring(postErr))
	else
		print("Exported", relPath .. ext)
	end
end

local function walk(obj)
	if obj:IsA("LuaSourceContainer") then
		exportScript(obj)
	end

	for _, child in ipairs(obj:GetChildren()) do
		walk(child)
	end
end

print("Starting export...")
walk(game)
print("Export complete.")
