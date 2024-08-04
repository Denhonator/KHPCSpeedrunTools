LUAGUI_NAME = "1fm0Volume"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Volume 1 mutes the audio channel"

local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			require("EpicGamesJP")
		else
			require("SteamGlobal") -- Global and JP version addresses are shared
			if ReadByte(posDebugString - 0xE40) ~= 0x58 then -- Steam JP specific changes
				volumeZero = volumeZero - 0x80
			end
		end
		WriteFloat(volumeZero, 0)
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
end
