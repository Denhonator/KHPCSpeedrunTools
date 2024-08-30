LUAGUI_NAME = "1fm4By3"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Changes aspect ratio. Visit display settings to apply"

local canExecute = false

local function importVars(file)
	if not pcall(require, file) then
		local errorString = "\n\n!!!!!!!! IMPORT ERROR !!!!!!!!\n\n"
		local msg = ""
		local slashIdx = string.find(file, "/")
		if slashIdx then
			msg = string.format("%s.lua missing, get it from the Github!", string.sub(file, slashIdx + 1, #file))
		else
			msg = string.format("%s.lua missing, get it from the Github!", file)
		end
		ConsolePrint(string.format("%s%s%s", errorString, msg, errorString))
	end
end

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		importVars("VersionCheck")
		if ReadByte(EGSGlobalVersion) == 106 then
			importVars("EpicGamesGlobal")
		elseif ReadByte(EGSJPVersion) == 106 then
			importVars("EpicGamesJP")
		elseif ReadByte(SteamGlobalVersion) == 106 then
			importVars("SteamGlobal")
		elseif ReadByte(SteamJPVersion) == 106 then
			importVars("SteamJP")
		else
			ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
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
