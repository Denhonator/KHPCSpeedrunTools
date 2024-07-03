LUAGUI_NAME = "Unlock Charcater Select"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Charcater Select"

local canExecute = false

function _OnInit()
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Birth by Sleep detected")
		canExecute = true
		if ReadByte(0x7262E4) == 0x6A or ReadByte(0x7252E4) == 0x6A then
			if ReadByte(0x7262E4) == 0x6A then
				ConsolePrint("Epic Games Global Version")
				unlock = 0x10FB2DF9
			else
				ConsolePrint("Epic Games JP Version")
				unlock = 0x10FB1DF9
			end
		else
			ConsolePrint("Steam Version")
			unlock = 0x10FB1679
		end
	else
		ConsolePrint("Birth by Sleep not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteByte(unlock, 7)
	end
end