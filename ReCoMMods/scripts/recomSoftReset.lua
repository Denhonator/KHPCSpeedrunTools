LUAGUI_NAME = "recomSoftReset"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

local canExecute = false

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Re:CoM detected")
		canExecute = true
		if ReadByte(0x7050E8) == 106 then
			require("EpicGamesGlobal")
		else if ReadByte(0x7050C8) == 106 then
			require("EpicGamesJP")
		else if ReadByte(0x7051E8) == 106 then
			require("SteamGlobal")
		else
			require("SteamJP")
		end
	else
		ConsolePrint("Re:CoM not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteByte(copyright_skip_1, 115)
		WriteByte(copyright_skip_2, 115)
		if ReadInt(input) == 3848 or ReadInt(kbinput) == 252186376 then
			WriteByte(reset, 5)
		end
	end
end
