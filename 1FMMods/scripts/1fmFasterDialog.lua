LUAGUI_NAME = "1fmFasterDialog"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up text boxes"

local lastProg = 0
local textSpeedup = false
local turbo = false

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
				textProg = 0x232E8F4 - offset
				textTrans = 0x22ECA44 - offset
				textSpeed = 0x234055C - offset
		else
			ConsolePrint("Steam version detected")
			textProg = 0x232DF74
			textTrans = 0x22EC0E4
			textSpeed = 0x233FBDC
		end
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

		lastProg = textProg
	end
end