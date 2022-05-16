LUAGUI_NAME = "1fm4By3"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Changes aspect ratio. Visit display settings to apply"

local offset = 0x3A0606
local height = 0x3B1534 - offset

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		canExecute = true
		if ReadFloat(height) == 0 and ReadFloat(height-0x20) > 1 then
			height = height - 0x20
			ConsolePrint("JP detected, adjusting address")
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteFloat(height, 12.0) -- Sets aspect ratio to 16:12 = 4:3
	end
end