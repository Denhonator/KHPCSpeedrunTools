local lastProg = 0
local textSpeedup = false
local turbo = false

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if not canExecute then
		goto done
	end

	local textProg = ReadShort(0x232A5F4-0x3A0606)
	
	WriteFloat(0x22E8744-0x3A0606, 0) --finishes box transitions

	if textProg > lastProg and lastProg > 0 and textSpeedup then --1 frame turbo
		WriteFloat(0x233C25C-0x3A0606, 100.0)
		turbo = true
	elseif turbo then
		WriteFloat(0x233c25c-0x3A0606, 1.0)
	end

	lastProg = textProg
	
	::done::
end