--[[ 
	Template based on the ComputerCraft Package Tool Installer
	OrigAuthor: PentagonLP
]]

-- Read arguments
args = {...}

--[[ Stores a file in a desired location
	@param String filepath: Filepath where to create file (if file already exists, it gets overwritten)
	@param String content: Content to store in file
--]]
local function storeFile(filepath,content)
	writefile = fs.open(filepath,"w")
	writefile.write(content)
	writefile.close()
end

-- HTTP FETCH FUNCTIONS --
--[[ Gets result of HTTP URL
	@param String url: The desired URL
	@return Table|boolean result|error: The result of the request; If the URL is not reachable, an error is printed in the terminal and boolean false is returned
--]]
local function gethttpresult(url)
	if not http.checkURL(url) then
		print("ERROR: Url '" .. url .. "' is blocked in config. Unable to fetch data.")
		return false
	end
	result = http.get(url)
	if result == nil then
		print("ERROR: Unable to reach '" .. url .. "'")
		return false
	end
	return result
end

--[[ Download file HTTP URL
	@param String filepath: Filepath where to create file (if file already exists, it gets overwritten)
	@param String url: The desired URL
	@return nil|boolean nil|error: nil; If the URL is not reachable, an error is printed in the terminal and boolean false is returned
--]]
local function downloadfile(filepath,url)
	local result = gethttpresult(url)
	if result == false or result == nil then 
		return false
	end
	storeFile(filepath,result.readAll())
end

-- MAIN PROGRAMM --
if (args[1]=="install") or (args[1]==nil) then
	print("[Installer] Well, hello there!")
	print("[Installer] Installing 'template.package'...")
	if downloadfile("/example.lua","{example.lua}")==false then
		return false
	end
elseif args[1]=="update" then
	print("[Installer] Updating 'template.package'...")
	if downloadfile("/example.lua","{example.lua}")==false then
		return false
	end
elseif args[1]=="remove" then
	print("[Installer] Uninstalling 'template.package'...")
	fs.delete("/example.lua")
	print("[Installer] So long, and thanks for all the fish!")
else
	print("[Installer] Invalid argument: " .. args[1])
end