LUAGUI_NAME = "1fmEarlySkip"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Allows skipping cutscenes faster"

local lastInput = 0
local lastFade = 0
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
	nowInput = ReadInt(0x233D034-0x3A0606)
	if canExecute and ReadInt(0x233AE74-0x3A0606)==1 then
		local curFade = math.min(ReadInt(0x233C450-0x3A0606)+20, 128)
		if curFade-30 > 0 and lastFade < curFade then
			WriteInt(0x233C49C-0x3A0606, 0) --white screen off
			WriteInt(0x233C450-0x3A0606, curFade) --canskip
			WriteInt(0x233C454-0x3A0606, curFade) --canskip
			WriteInt(0x233C458-0x3A0606, curFade) --canskip
			WriteInt(0x233C45C-0x3A0606, curFade) --canskip
			WriteInt(0x233C5B8-0x3A0606, 0) --canskip
			WriteInt(0x233CAA0-0x3A0606, 0) --canskip
			WriteInt(0x233CAA4-0x3A0606, 0) --canskip
		end
		lastFade = curFade
	end
	lastInput = nowInput
end