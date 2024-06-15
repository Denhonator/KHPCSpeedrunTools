LUAGUI_NAME = "1fmAutoattack"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Hold attack to combo"

local offset = 0x3A2B86
local cooldown = 0
local canExecute = false
local swapped = 0x22DAF7E - offset
local menu = 0x232E900 - offset
local dialog = 0x299C488 - offset
local attackCommand = 0x52988C - offset

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

	local attackInput = (ReadByte(0x2341335-offset)//(64-(32*ReadByte(swapped))))%2 == 1
	if ReadInt(menu) == 1 or ReadInt(dialog) == 0 then
		cooldown = 20
	elseif cooldown > 0 then
		cooldown = cooldown - 1
	end
	local autofireState = (attackInput and ReadByte(attackCommand) and cooldown == 0) and 1 or 0
	WriteInt(0x23D4900-offset, autofireState)
	WriteInt(0x232E744-offset, autofireState)
	
	::done::
end