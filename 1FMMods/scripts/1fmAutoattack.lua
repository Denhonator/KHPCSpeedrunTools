local cooldown = 0

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		print("KH1 detected, running script")
	else
		print("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if not canExecute then
		goto done
	end

	local swapped = ReadByte(0x22D6C7E - 0x3A0606)
	local attackInput = (ReadByte(0x233D035-0x3A0606)//(64-(32*swapped)))%2 == 1
	local menu = ReadInt(0x232A600-0x3A0606) == 1
	local dialog = ReadInt(0x2998188-0x3A0606) == 0
	if menu or dialog then
		cooldown = 20
	elseif cooldown > 0 then
		cooldown = cooldown - 1
	end
	local attackCommand = ReadByte(0x52558C-0x3A0606) == 0
	local autofireState = (attackInput and attackCommand and cooldown == 0)  and 1 or 0
	WriteInt(0x23D0600-0x3A0606, autofireState)
	WriteInt(0x232A444-0x3A0606, autofireState)
	
	::done::
end