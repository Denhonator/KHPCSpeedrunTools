LUAGUI_NAME = "dddSoftReset"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

local offset = 0x770EFA

function _OnInit()
end

function _OnFrame()
	local input = ReadInt(0x354E16-offset)
	if (input == 0x0F08) then 
		WriteByte(0x354FBE-offset, 0x01)
	end
end