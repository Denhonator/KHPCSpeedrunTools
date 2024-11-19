LUAGUI_NAME = "1fmFasterDialog"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up text boxes"

local lastProg = 0
local textSpeedup = false
local turbo = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteFloat(textTrans, 0) --finishes box transitions
		if ReadShort(textProg) > lastProg and lastProg > 0 and textSpeedup then --1 frame turbo
			WriteFloat(textSpeed, 100.0)
			turbo = true
		elseif turbo then
			WriteFloat(textSpeed, 1.0)
		end
		lastProg = ReadShort(textProg)
	end
end
