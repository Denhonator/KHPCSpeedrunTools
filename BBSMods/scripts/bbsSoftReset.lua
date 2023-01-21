LUAGUI_NAME = "bbsSoftReset"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

local offset = 0x60E334

function _OnInit()
end

function _OnFrame()
	local input = ReadInt(0x20EA64-offset)
	if (input == 0x0F08) then 
		WriteByte(0x254EE8-offset, 0x01)
	end
end