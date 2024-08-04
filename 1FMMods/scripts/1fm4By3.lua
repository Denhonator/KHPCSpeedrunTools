LUAGUI_NAME = "1fm4By3"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Changes aspect ratio. Visit display settings to apply"

local canExecute = false
local posDebugString = 0x3EB158

local function importVars(file)
	if not pcall(require, file) then
		local errorString = "\n\n!!!!!!!! IMPORT ERROR !!!!!!!!\n\n"
		local msg = ""
		local slashIdx = string.find(file, "/")
		if slashIdx then
			msg = string.format("%s.lua missing, get it from the Github!", string.sub(file, slashIdx + 1, #file))
		else
			msg = string.format("%s.lua missing, get it from the Github!", file)
		ConsolePrint(string.format("%s%s%s", errorString, msg, errorString))
	end
end

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			importVars("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			importVars("EpicGamesJP")
		else
			importVars("SteamGlobal") -- Global and JP version addresses are shared
			if ReadByte(posDebugString - 0xE40) ~= 0x58 then -- Steam JP specific changes
				height = height - 0x80
			end
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteFloat(height, 12.0) -- Sets aspect ratio to 16:12 = 4:3
	end
end