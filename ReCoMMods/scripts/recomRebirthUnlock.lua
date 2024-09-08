LUAGUI_NAME = "Unlock Reverse Rebirth"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Reverse Rebirth"

local canExecute = false

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("Re:CoM detected")
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
		ConsolePrint("Re:Chain of Memories not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadByte(gamecomplete) < 3 then
			WriteByte(gamecomplete, 3)
		end
	end
end
