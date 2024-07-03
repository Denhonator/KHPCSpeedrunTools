LUAGUI_NAME = "bbsSoftReset"
LUAGUI_AUTH = "deathofall84 (Credits to Topaz and KSX)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start (options)"

local canExecute = false

function _OnInit()
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Birth by Sleep detected")
		canExecute = true
		if ReadByte(0x7262E4) == 0x6A or ReadByte(0x7252E4) == 0x6A then
			if ReadByte(0x7262E4) == 0x6A then
				ConsolePrint("Epic Games Global Version")
				offset = 0x0
			else
				ConsolePrint("Epic Games JP Version")
				offset = 0x1000
			end
			softreset = 0x86749C - offset
			location = 0x819120 - offset
			input = 0x8F65030 - offset
			title_skip_1 = 0x42BB59
			title_skip_2 = 0x3EE25F
			title_skip_3 = 0x3EE241
		else
			softreset = 0x865D1C
			input = 0x8F638B0
			location = 0x817120
			title_skip_1 = 0x42C319
			title_skip_2 = 0x3EE59F
			title_skip_3 = 0x3EE581
			ConsolePrint("Steam Version")
		end
	else
		ConsolePrint("Birth by Sleep not detected, not running script")
	end
end


function _OnFrame()
	if canExecute then
		WriteByte(title_skip_1, 0x73)
		WriteByte(title_skip_2, 0x73)
		WriteByte(title_skip_3, 0x73)
		if ReadInt(input) == 3848 then
			WriteInt(location, 0xFFFFFF)
			WriteByte(softreset, 1)
		end
	end
end
