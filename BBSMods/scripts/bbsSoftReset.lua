LUAGUI_NAME = "bbsSoftReset"
LUAGUI_AUTH = "deathofall84 (Credits to Topaz and KSX)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start (options)"

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
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("Birth by Sleep detected")
		if ReadByte(0x7262E4) == 106 then
			importVars("EpicGamesGlobal")
		elseif ReadByte(0x7252E4) == 106 then
			importVars("EpicGamesJP")
		else
			importVars("SteamGlobal") -- Global and JP version addresses are shared
		end
	else
		ConsolePrint("Birth by Sleep not detected, not running script")
	end
end


function _OnFrame()
	if canExecute then
		WriteByte(titleSkip1, 115)
		WriteByte(titleSkip2, 115)
		WriteByte(titleSkip3, 115)
		if ReadInt(input) == 3848 then
			WriteInt(location, 16777215)
			WriteByte(softreset, 1)
		end
	end
end
