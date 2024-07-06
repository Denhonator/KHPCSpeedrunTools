LUAGUI_NAME = "1fmBeepHack"
LUAGUI_AUTH = "deathofall84"
LUAGUI_DESC = "Removes low health beeping noise, works up to max health of 41"

local canExecute = false
local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 or ReadByte(posDebugString - 0x1020) == 0x58 then
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Epic Games Global version detected")
				beepHack = 0x26BD5C
			else
				ConsolePrint("Epic Games JP version detected")
				beepHack = 0x26BB9C
			end
		else
			posDebugString = 0x3EA318
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Steam Global version detected")
				beepHack = 0x26DECC
			else
				ConsolePrint("Steam JP version detected")
				beepHack = 0x26DC4C
			end
		end
		WriteByte(beepHack, 1)
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
end
