LUAGUI_NAME = "1fm1HP"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Forces Sora's max HP to 1 and removes beeping noise"

local canExecute = false
local beepHack = 0x0
local maxHP = 0x0
local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 or ReadByte(posDebugString - 0x1020) == 0x58 then
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Epic Games Global version detected")
				beepHack = 0x26BD5C
				maxHP = 0x2DE9CE6
			else
				ConsolePrint("Epic Games JP version detected")
				beepHack = 0x26BB9C
				maxHP = 0x2DE8CE6
			end
		else
			posDebugString = 0x3EA318
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Steam Global version detected")
				beepHack = 0x26DECC
			else
				ConsolePrint("Steam JP version detected")
				beepHack = 0x26DC4C
			end
			maxHP = 0x2DE9366
		end
		WriteByte(beepHack, 1)
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteByte(maxHP, 1)
	end
end