LUAGUI_NAME = "1fmInstantGummi"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Instantly arrive at gummi destination"

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
			gummiStart = 0x507C90 - offset
			gummiSelect = 0x507D7C - offset
			gummiDest = 0x508280 - offset
			worldWarpBase = 0x50F9FA - offset
			worldWarpBase2 = 0x50FA6A - offset
			normalDrive = 0x268A1EC - offset
			cutsceneFlagBase = 0x2DEB1E5 - offset
		else
			ConsolePrint("Steam version detected")
			gummiStart = 0x506F90
			gummiSelect = 0x50707C
			gummiDest = 0x507580
			worldWarpBase = 0x50ABBA
			worldWarpBase2 = 0x50AC2A
			normalDrive = 0x268986C
			cutsceneFlagBase = 0x2DEA865
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		selection = ReadInt(gummiSelect)
		curDest = ReadInt(gummiDest)
		if curDest >= 40 then
			WriteInt(gummiStart, selection)
		else
			
			deepJungleState = ReadByte(cutsceneFlagBase) < 16
			neverlandState = ReadByte(cutsceneFlagBase + 8) < 20

			WriteByte(worldWarpBase, deepJungleState and 0 or 14)
			WriteByte(worldWarpBase + 2, deepJungleState and 0 or 45)
			WriteByte(worldWarpBase2, neverlandState and 6 or 7)
			WriteByte(worldWarpBase2 + 2, neverlandState and 24 or 37)
			
			-- Change warp to Hollow Bastion
			if selection == 25 then 
				selection = 15
				WriteInt(gummiSelect, selection)
			end

			-- Change warp to Agrabah
			if selection == 21 then
				selection = 8
				WriteInt(gummiSelect, selection)
			end
			
			selection = selection > 20 and 0 or selection
			WriteInt(gummiDest, selection)
			WriteInt(gummiStart, selection)
			WriteInt(normalDrive, 0)
		end
	end
end