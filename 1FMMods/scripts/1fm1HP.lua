LUAGUI_NAME = "1fm1HP"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Forces Sora's max HP to 1 and removes beeping noise"

local offset = 0x3A2B86
local maxHP = 0x2DE9CE6 - offset
local beepHack = 0x26BD5C - offset

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		if ReadByte(beepHack) == 9 then
			WriteByte(beepHack, 1)
		end
		canExecute = true
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteByte(maxHP, 1)
	end
end