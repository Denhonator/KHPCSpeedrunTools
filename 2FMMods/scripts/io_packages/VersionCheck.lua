-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
-- Global and JP versions currently match
EGSGlobalVersion = 0x660E44
EGSJPVersion = 0x660E44
SteamGlobalVersion = 0x660EF4
SteamJPVersion = 0x660E74

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
