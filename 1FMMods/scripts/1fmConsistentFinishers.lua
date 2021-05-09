local offset = 0x3A0606
local gravBreak = 0x3EA148 - offset
local zantek = 0x42D478 - offset
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
		WriteFloat(zantek, 1.0)
	end
end