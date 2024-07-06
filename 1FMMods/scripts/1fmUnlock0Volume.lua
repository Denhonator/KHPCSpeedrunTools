LUAGUI_NAME = "1fm0Volume"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Volume 1 mutes the audio channel"

local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			vars = require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			vars = require("EpicGamesJP")
		else
			vars = require("SteamGlobal") -- Global and JP equal
			if ReadByte(posDebugString - 0xE40) ~= 0x58 then
				vars.volumeZero = vars.volumeZero - 0x80
			end
		end
		WriteFloat(vars.volumeZero, 0)
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end
