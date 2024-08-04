LUAGUI_NAME = "1fmInstantGummi"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Instantly arrive at gummi destination"

local canExecute = false
local posDebugString = 0x3EB158

local function importVars(file)
	if not pcall(require, file) then
		local errorString = "\n\n!!!!!!!! IMPORT ERROR !!!!!!!!\n\n"
		local msg = ""
		local slashIdx = string.find(file, "/")
		if slashIdx then
			msg = string.format("%s.lua missing, get it from the Github!", string.sub(file, slashIdx + 1, #file))
		else
			msg = string.format("%s.lua missing, get it from the Github!", file)
		ConsolePrint(string.format("%s%s%s", errorString, msg, errorString))
	end
end

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			importVars("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			importVars("EpicGamesJP")
		else
			importVars("SteamGlobal") -- Global and JP version addresses are shared
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		local selection = ReadInt(gummiSelect)
		local curDest = ReadInt(dest)
		if curDest >= 40 then
			WriteInt(gummiStart, selection)
		else

			deepJungleState = ReadByte(cutsceneFlagBase) < 16
			neverlandState = ReadByte(cutsceneFlagBase + 8) < 20

			WriteByte(worldWarpBase, deepJungleState and 0 or 14)
			WriteByte(worldWarpBase + 2, deepJungleState and 0 or 45)
			WriteByte(worldWarpBase2, neverlandState and 6 or 7)
			WriteByte(worldWarpBase2 + 2, neverlandState and 24 or 37)

			-- Replace HT and Atlantica with Monstro at first
			if ReadByte(monstro) < 2 and (selection == 10 or selection == 9) then
				selection = selection == 9 and 18 or 17
			end

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
			WriteInt(dest, selection)
			WriteInt(gummiStart, selection)
			WriteInt(normalDrive, 0)
		end
	end
end