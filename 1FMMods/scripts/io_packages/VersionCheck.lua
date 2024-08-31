-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
EGSGlobalVersion = 0x46A822
EGSJPVersion = 0x46A802
SteamGlobalVersion = 0x4698D2
SteamJPVersion = 0x469872

function importVars(file)
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
