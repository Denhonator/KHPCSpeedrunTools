LUAGUI_NAME = "2fmAutoSave"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Hold attack to combo"

local canExecute = false

local function importVars(file)
	if not pcall(require, file) then
		local errorString = "\n\n!!!!!!!! IMPORT ERROR !!!!!!!!\n\n"
		local msg = ""
		local slashIdx = string.find(file, "/")
		if slashIdx then
			msg = string.format("%s.lua missing, get it from the Github!", string.sub(file, slashIdx + 1, #file))
		else
			msg = string.format("%s.lua missing, get it from the Github!", file)
		end
		ConsolePrint(string.format("%s%s%s", errorString, msg, errorString))
	end
end

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
        canExecute = true
		if ReadByte(0x660E04) == 106 or ReadByte(0x660DC4) == 106 then --EGS
			importVars("EpicGamesGlobal") -- Global and JP version addresses are shared
		elseif ReadByte(0x660E74) == 106 then -- Steam Global
			importVars("SteamGlobal")
		elseif ReadByte(0x65FDF4) == 106 then -- Steam JP
			importVars("SteamJP")
		end
	end
end

function _OnFrame()
	if canExecute then
		local input = ReadShort(inputAddress) == 16384
		local command = ReadByte(commandMenuItem) == 0
		local dialog = ReadByte(inDialogue) == 0
		local inCombat = ReadByte(btlTyp) & 3 > 0

		if input and command and dialog and inCombat then
			WriteByte(autoAttack, 1)
		else
			WriteByte(autoAttack, 0)
		end
	end
end
