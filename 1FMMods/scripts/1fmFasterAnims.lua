LUAGUI_NAME = "1fmFasterAnims"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up animations during which you can't play"

local summonSpeedup = true
local speedMult = 2.0

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
		end
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
		if ReadFloat(soraHUD) < 1 and ReadInt(inCutscene) > 0
			and ReadInt(inCutscene) ~= 8  and ReadInt(skippable) ~= 1025
			and (ReadInt(summoning) == 0 or summonSpeedup)
			and not (
				ReadByte(world) == 6 and ReadByte(room) == 8
				and ReadInt(minitimer) >= 9000.0
			)
			and not (
				ReadByte(world) == 1 and ReadByte(room) == 2
				and (ReadByte(dialog) >= 1 and ReadByte(dialog) <= 5)
			) then
			WriteFloat(animSpeed, speedMult)
		else
			WriteFloat(animSpeed, 1.0)
		end
	end
end