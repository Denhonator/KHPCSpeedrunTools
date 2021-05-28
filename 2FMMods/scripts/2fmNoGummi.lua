local offset = 0x56450E
local TT = 0x9AB064 - offset

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
		for i=0, 10 do
			if ReadByte(TT+(i*4)+3) == 2 then
				WriteByte(TT+(i*4)+3, 1)
			end
		end
	end
end