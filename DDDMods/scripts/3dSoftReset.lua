LUAGUI_NAME = "dddSoftReset"
LUAGUI_AUTH = "deathofall84 (original by denhonator)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

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
		if ReadInt(input) == 3848 then
			WriteByte(reset, 1)
		end
		WriteByte(copyright_skip, 2)
	end
end
