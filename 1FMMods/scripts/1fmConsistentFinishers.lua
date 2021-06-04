local offset = 0x3A0606
local gravBreak = 0x3EA148 - offset
local zantekHack = 0x2A2654 - offset

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		print("KH1 detected, running script")
		canExecute = true
	else
		print("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteFloat(gravBreak, -1.0)
		if ReadByte(zantekHack+4) == 0x1C then
			WriteByte(zantekHack+4, 0x74)
		end
	end
end