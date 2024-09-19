LUAGUI_NAME = "2fmAutoSave"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Hold attack to combo"

local canExecute = false

function _OnInit()
	if GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
        canExecute = true
		require("VersionCheck")
		if ReadByte(EGSGlobalVersion) == 106 then
			importVars("EpicGamesGlobal")
		elseif ReadByte(EGSJPVersion) == 106 then
			importVars("EpicGamesJP")
		elseif ReadByte(SteamGlobalVersion) == 106 then
			importVars("SteamGlobal")
		elseif ReadByte(SteamJPVersion) == 106 then
			importVars("SteamJP")
		else
			canExecute = false
			ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
		end
	end
end

function _OnFrame()
	if canExecute then
		local input = ReadInt(inputAddress) == 134217732
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
