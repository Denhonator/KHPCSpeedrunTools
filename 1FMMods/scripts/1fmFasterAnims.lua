LUAGUI_NAME = "1fmFasterAnims"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up animations during which you can't play"

local summonSpeedup = true
local speedMult = 2.0

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
				soraHUD = 0x2812E1C - offset
				animCutscene = 0x237CE60 - offset
				skippable = 0x23987E4 - offset
				summoning = 0x2D6192C - offset
				world = 0x2340E4C - offset
				room = 0x2340E44 - offset
				minitimer = 0x232E984 - offset
				dialog = 0x299C488 - offset
				animSpeed = 0x234054C - offset
		else
			ConsolePrint("Steam version detected")
			soraHUD = 0x281249C
			animCutscene = 0x23AB2D0
			skippable = 0x2382594
			summoning = 0x2D60FAC
			world = 0x233FE94
			room = 0x233FE8C
			minitimer = 0x232E000
			dialog = 0x299BB08
			animSpeed = 0x233FBCC
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadFloat(soraHUD) < 1 and animCutscene > 0 and animCutscene ~= 8 
			and skippable ~= 1025 and (summoning == 0 or summonSpeedup)
			and not (world == 6 and room == 8 and minitimer >= 9000.0)
			and not (world == 1 and room == 2 and (dialog >= 1 and dialog <= 5)) then
			WriteFloat(animSpeed, speedMult)
		else
			WriteFloat(animSpeed, 1.0)
		end
	end
end