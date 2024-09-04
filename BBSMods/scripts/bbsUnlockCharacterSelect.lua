LUAGUI_NAME = "Unlock Charcater Select"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Charcater Select"

local canExecute = false

function _OnInit()
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("Birth by Sleep detected")
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
	else
		ConsolePrint("Birth by Sleep not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteByte(unlock, 7)
	end
end