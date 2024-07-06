LUAGUI_NAME = "1fmConsistentFinishers"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "30% chance finishers are now 100%"

local canExecute = false
local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 or ReadByte(posDebugString - 0x1020) == 0x58 then
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Epic Games Global version detected")
				zantHack = 0x2A4B08
				gravBreak = 0x3ED378
				zantValue = 48100
			else
				ConsolePrint("Epic Games JP version detected")
				zantHack = 0x2A4948
				gravBreak = 0x3EC358
				zantValue = 44140
			end
		else
			posDebugString = 0x3EA318
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Steam Global version detected")
				zantHack = 0x2A6C98
				gravBreak = 0x3EC538
				zantValue = 35620
			else
				ConsolePrint("Steam JP version detected")
				zantHack = 0x2A6A18
				gravBreak = 0x3EC4B8
				zantValue = 36132
			end			
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadShort(zantHack) ~= zantValue then
			WriteFloat(gravBreak, -1.0)
			WriteShort(zantHack, zantValue) -- 88 offset from original value
		end
	end
end