LUAGUI_NAME = "dddSoftReset"
LUAGUI_AUTH = "deathofall84 (original by denhonator)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

local canExecute = false

function _OnInit()
	if GAME_ID == 0xE86A2A90 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Dream Drop Distance deteceted")
		canExecute = true
		if ReadByte(0x8A9046) == 0x6A then
			ConsolePrint("Epic Games Version")
			reset = 0xAC9058
			copyright_skip = 0xA99630
			input = 0x14DDD52C
		else
			ConsolePrint("Steam Version")
			reset = 0xAC97D8
			copyright_skip = 0xA99DB0
			input = 0x14DB97D0
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
