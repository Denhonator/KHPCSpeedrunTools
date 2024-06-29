LUAGUI_NAME = "recomSoftReset"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

local canExecute = false

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Re:CoM detected")
		canExecute = true
		if ReadByte(0x4E6C80) == 255 or ReadByte(0x4E6AC0) == 255 then
			reset = 0xAC3E00
			input = 0xC7D594
			kbinput = 0x822178
			if ReadByte(0x4E6C80) == 255 then
				copyright_skip_1 = 0x3A2FD9
				copyright_skip_2 = 0x3A30D0
			else
				copyright_skip_1 = 0x3A2E19
				copyright_skip_2 = 0x3A2F10
			end
			ConsolePrint("Epic Games Version")
		elseif ReadByte(0x4E7040) == 255 or ReadByte(0x4E6DC0) == 255 then
			reset = 0xAC4474
			input = 0xC1DC20
			kbinput = 0x8223E8
			if ReadByte(0x4E7040) == 255 then
				copyright_skip_1 = 0x3A3459
				copyright_skip_2 = 0x3A3555
			else
				copyright_skip_1 = 0x3A31D9
				copyright_skip_2 = 0x3A32D5
			end
			ConsolePrint("Steam Version")
		end
	else
		ConsolePrint("Re:CoM not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteByte(copyright_skip_1, 0x73)
		WriteByte(copyright_skip_2, 0x73)
		if ReadInt(input) == 3848 or ReadInt(kbinput) == 0x0F080F08 then
			WriteByte(reset, 5)
		end
	end
end
