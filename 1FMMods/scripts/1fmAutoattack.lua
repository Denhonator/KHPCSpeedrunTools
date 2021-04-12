local cooldown = 0

function _OnInit()

end

function _OnFrame()
	local attackInput = (ReadByte(0x233D035-0x3A0606)//2//2//2//2//2//2)%2 == 1
	local menu = ReadInt(0x232A600-0x3A0606) == 1
	local dialog = ReadInt(0x2863958-0x3A0606) > 0
	if menu or dialog then
		cooldown = 20
	elseif cooldown > 0 then
		cooldown = cooldown - 1
	end
	local attackCommand = ReadByte(0x52558C-0x3A0606) == 0
	local autofireState = (attackInput and attackCommand and cooldown == 0)  and 1 or 0
	WriteInt(0x23D0600-0x3A0606, autofireState)
	WriteInt(0x232A444-0x3A0606, autofireState)
end