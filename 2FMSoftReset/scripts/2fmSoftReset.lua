function _OnInit()

end

function _OnFrame()
	local input = ReadInt(0x29F89B0-0x56450E)
	if (input == 247042) then 
		WriteByte(0xAB841A-0x56450E, 0x1)
		WriteInt(0x751310-0x56450E, 0x00000001)
	end
end