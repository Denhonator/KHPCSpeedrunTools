LUAGUI_NAME = "bbsSoftReset"
LUAGUI_AUTH = "deathofall84 (Credits to Topaz and KSX)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start (options)"

local offset = 0x60E334
local canExecute = false
softreset = 0x86321C - offset
location = 0x8150A0 - offset -- 3 seperate bytes for world, room, scene/spawn set all to 255 or 0xFF to reset
buttonCombo = 0x8F60DB0-offset

function _OnInit()
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == "BACKEND" then
		canExecute = true
	else
		canExecute = false
	end
end


function _OnFrame()
	local input = ReadInt(buttonCombo)
	if input == 3848 then
		WriteInt(location, 0xFFFFFF)
		WriteByte(softreset, 1)
	end
end
