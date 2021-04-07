function _OnInit()

end

function _OnFrame()
	local input = ReadInt(0x29F79B0-0x56450E)
	if (input == 247042) then 
		WriteByte(0xAB741A-0x56450E, 0x1)
		WriteInt(0x750310-0x56450E, 0x00000001)
	end
end