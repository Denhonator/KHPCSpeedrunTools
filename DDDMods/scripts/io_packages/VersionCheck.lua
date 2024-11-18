-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
EGSGlobalVersion = 0x8A90A6
-- This version is not common or owned by a maintainer thus can not be checked
-- EGSJPVersion = 0x8A90A6
SteamGlobalVersion = 0x8A9103
SteamJPVersion = 0x8A90A3

function importVars(file)
	local slashIdx = string.find(file, "/")
	if not pcall(require, file) then
		local errorString = "\n\n!!!!!!!! IMPORT ERROR !!!!!!!!\n\n"
		local msg = ""
		if slashIdx then
			msg = string.format("%s.lua missing, get it from the Github!", string.sub(file, slashIdx + 1, #file))
		else
			msg = string.format("%s.lua missing, get it from the Github!", file)
		end
		ConsolePrint(string.format("%s%s%s", errorString, msg, errorString))
	else
		if slashIdx then
			ConsolePrint(string.format("Running with %s!", string.sub(file, slashIdx + 1, #file)))
		else
			ConsolePrint(string.format("Running with %s!", file))
		end
	end
end

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