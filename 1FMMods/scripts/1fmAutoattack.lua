function _OnInit()

end

function _OnFrame()
	local attackInput = (ReadByte(0x233D035-0x3A0606)//2//2//2//2//2//2)%2 == 1
	local menu = ReadInt(0x232A600-0x3A0606) == 1
	local attackCommand = ReadByte(0x52558C-0x3A0606) == 0
	local autofireState = (attackInput and attackCommand and not menu)  and 1 or 0
	WriteInt(0x23D0600-0x3A0606, autofireState)
	WriteInt(0x232A444-0x3A0606, autofireState)
end