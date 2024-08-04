LUAGUI_NAME = "1fmAutoattack"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Hold attack to combo"

local cooldown = 0
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
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		attackInput = (ReadByte(attInp) // (64 - (32 * ReadByte(swapped)))) % 2 == 1
		if ReadInt(menu) == 1 or ReadInt(dialog) == 0 then
			cooldown = 20
		elseif cooldown > 0 then
			cooldown = cooldown - 1
		end
		autofireState = (attackInput and ReadByte(attackCommand) and cooldown == 0) and 1 or 0
		WriteInt(fireState1, autofireState)
		WriteInt(fireState2, autofireState)
	end
end