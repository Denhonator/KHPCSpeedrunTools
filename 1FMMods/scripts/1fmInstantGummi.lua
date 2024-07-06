LUAGUI_NAME = "1fmInstantGummi"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Instantly arrive at gummi destination"

local canExecute = false
local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			vars = require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			vars = require("EpicGamesJP")
		elseif ReadByte(posDebugString - 0xE40) == 0x58 then
			vars = require("SteamGlobal") -- Global and JP equal
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		selection = ReadInt(vars.gummiSelect)
		curDest = ReadInt(vars.dest)
		if curDest >= 40 then
			WriteInt(vars.gummiStart, selection)
		else
			
			deepJungleState = ReadByte(vars.cutsceneFlagBase) < 16
			neverlandState = ReadByte(vars.cutsceneFlagBase + 8) < 20

			WriteByte(vars.worldWarpBase, deepJungleState and 0 or 14)
			WriteByte(vars.worldWarpBase + 2, deepJungleState and 0 or 45)
			WriteByte(vars.worldWarpBase2, neverlandState and 6 or 7)
			WriteByte(vars.worldWarpBase2 + 2, neverlandState and 24 or 37)
			
			-- Change warp to Hollow Bastion
			if selection == 25 then 
				selection = 15
				WriteInt(vars.gummiSelect, selection)
			end

			-- Change warp to Agrabah
			if selection == 21 then
				selection = 8
				WriteInt(vars.gummiSelect, selection)
			end
			
			selection = selection > 20 and 0 or selection
			WriteInt(vars.dest, selection)
			WriteInt(vars.gummiStart, selection)
			WriteInt(vars.normalDrive, 0)
		end
	end
end