LUAGUI_NAME = "1fm0Volume"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Volume 1 mutes the audio channel"

local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 or ReadByte(posDebugString - 0x1020) == 0x58 then
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Epic Games Global version detected")
				WriteFloat(0x3D9B24, 0)
			else
				ConsolePrint("Epic Games JP version detected")
				WriteFloat(0x3D8B04, 0)
			end
		else
			posDebugString = 0x3EA318
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Steam Global version detected")
				WriteFloat(0x3D8AF4, 0)
			else
				ConsolePrint("Steam JP version detected")
				WriteFloat(0x3D8A74, 0)
			end
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end
