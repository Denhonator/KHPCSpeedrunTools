LUAGUI_NAME = "recomSoftReset"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

local offset = 0x4E4660
local reset = 0xAC0C94 - offset
local input = 0xC1A490 - offset
local kbinput = 0x81F188 - offset

local canExecute = false

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("RE:CoM detected, running script")
		canExecute = true
	else
		ConsolePrint("RE:CoM not detected, not running script")
	end
end

function _OnFrame()
	if canExecute and ReadInt(input)==3848 or ReadInt(kbinput)==0x0F080F08 then
		WriteByte(reset, 5)
	end
end