LUAGUI_NAME = "1fmUnskippable"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Makes unskippable cutscenes skippable"

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
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
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadInt(cutscene) > 0 and (ReadByte(world) == 4 or ReadByte(world) == 15) and ReadInt(summoning) == 0 then
			WriteByte(skippable, 1)
		end
	end
end
