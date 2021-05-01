local offset = 0x56450E

local canExecute = false

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		print("KH2 detected, running script")
		if ReadInt(0x2A5A056-offset) > 0 and ReadInt(0x2A59056-offset) == 0 then
			offset = 0x56550E
			print("Detected JP version. If this is incorrect, try reloading at a different time")
		else
			print("Detected GLOBAL version. If this is incorrect, try reloading at a different time")
		end
	else
		print("KH2 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		local input = ReadByte(0x71148B-offset) == 64
		local command = ReadByte(0x2A0DD7C-offset) == 0
		local dialog = ReadByte(0x2A139D0-offset) == 0
		if (input and command and dialog) then 
			WriteByte(0x2A5A056-offset, 0x1)
		else
			WriteByte(0x2A5A056-offset, 0)
		end
	end
end