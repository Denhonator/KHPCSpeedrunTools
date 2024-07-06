LUAGUI_NAME = "1fmAutoattack"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Hold attack to combo"

local cooldown = 0
local canExecute = false
local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 or ReadByte(posDebugString - 0x1020) == 0x58 then
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Epic Games Global version detected")
				offset = 0x0
			else
				ConsolePrint("Epic Games JP version detected")
				offset = 0x1000
			end
			swapped = 0x22DAF7E - offset
			menu = 0x232E900 - offset
			dialog = 0x299C488 - offset
			attackCommand = 0x52960C - offset
			attInp = 0x2341335 - offset
			fireState1 = 0x23D4900 - offset
			fireState2 = 0x232E744 - offset
		else
			ConsolePrint("Steam version detected")
			swapped = 0x22DA5EE
			menu = 0x232DFA0
			dialog = 0x299BB08
			attackCommand = 0x52890C
			attInp = 0x23407B5
			fireState1 = 0x23D3F80
			fireState2 = 0x232DDC4
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		attackInput = (ReadByte(attInp)//(64-(32*ReadByte(swapped))))%2 == 1
		if ReadInt(menu) == 1 or ReadInt(dialog) == 0 then
			cooldown = 20
		elseif cooldown > 0 then
			cooldown = cooldown - 1
		end
		autofireState = (attackInput and ReadByte(attackCommand) and cooldown == 0) and 1 or 0
		WriteInt(fireState1, autofireState)
		WriteInt(fireState2, autofireState)
	end
end