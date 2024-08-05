LUAGUI_NAME = "dddSoftReset"
LUAGUI_AUTH = "deathofall84 (original by denhonator)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

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
	if GAME_ID == 0xE86A2A90 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Dream Drop Distance deteceted")
		canExecute = true
		if ReadByte(0x8A9046) == 106 then
			importVars("EpicGamesGlobal") -- JP has not been checked or found
		else
			importVars("SteamGlobal") -- Global and JP version addresses are shared
		end
	end
end

function _OnFrame()
	if canExecute then
		if ReadInt(input) == 3848 then
			WriteByte(reset, 1)
		end
		WriteByte(copyright_skip, 2)
	end
end
