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
		local input = ReadInt(0x29F89B0-offset)
		if (input == 247042) then 
			WriteByte(0xAB841A-offset, 0x1)
			WriteInt(0x751310-offset, 0x00000001)
		end
	end
end