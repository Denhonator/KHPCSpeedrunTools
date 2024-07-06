LUAGUI_NAME = "1fmUnskippable"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Makes unskippable cutscenes skippable"

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
			cutscene = 0x233F174 - offset
			world = 0x2340E4C - offset
			summoning = 0x2D6192C - offset
			skippable = 0x23987E4 - offset
		else
			ConsolePrint("Steam version detected")
			cutscene = 0x233E808
			world = 0x233FE94
			summoning = 0x2D60FAC
			skippable = 0x2382594
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadInt(cutscene) > 0 and (ReadByte(world) == 4 or ReadByte(world) == 15) and ReadInt(summoning) == 0 then
			WriteByte(skippable, 1)
		end
	end
end