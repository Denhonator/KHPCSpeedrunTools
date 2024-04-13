LUAGUI_NAME = "dddSoftReset"
LUAGUI_AUTH = "deathofall84 (original by denhonator)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

local offset = 0x770E4A

function _OnInit()
end

function _OnFrame()
	local input = ReadInt(0x9E6C08-offset)
	if (input == 0x0F08) then 
		WriteByte(0xAC5EB8-offset, 0x01)
	end
end
