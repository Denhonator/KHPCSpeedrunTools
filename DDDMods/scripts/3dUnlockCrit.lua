LUAGUI_NAME = "Unlock Critical Mode"
LUAGUI_AUTH = "deathofall84 (original by KSX)"
LUAGUI_DESC = "Unlock Critical Mode"

local canExecute = false

function _OnInit()
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("Dream Drop Distance deteceted")
		require("VersionCheck")
		if ReadByte(EGSGlobalVersion) == 106 then
			importVars("EpicGamesGlobal")
		-- This version is not common or owned by a maintainer thus can not be checked
		-- elseif ReadByte(EGSJPVersion) == 106 then
		-- 	importVars("EpicGamesJP")
		elseif ReadByte(SteamGlobalVersion) == 106 then
			importVars("SteamGlobal")
		elseif ReadByte(SteamJPVersion) == 106 then
			importVars("SteamJP")
		else
			canExecute = false
			ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
		end
	else
		ConsolePrint("Dream Drop Distance not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadByte(unlock) == 0 then
			WriteByte(unlock, 1)
		end
	end
end
