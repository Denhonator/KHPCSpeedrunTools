-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 (Epic Games Store)
-- Global and JP versions currently match
versions = {
	"EGSGlobal_1_0_0_8",
	"EGSGlobal_1_0_0_9",
	"EGSGlobal_1_0_0_10",
	"EGSJP_1_0_0_8",
	"EGSJP_1_0_0_9",
	"EGSJP_1_0_0_10",
	"SteamGlobal_1_0_0_1",
	"SteamGlobal_1_0_0_2",
	"SteamJP_1_0_0_1",
	"SteamJP_1_0_0_2"
}
versions_table = {
	EGSGlobal_1_0_0_8 = 0x660E43,
	EGSGlobal_1_0_0_9 = 0x660E43,
	EGSGlobal_1_0_0_10 = 0x660E44,
	EGSJP_1_0_0_8 = 0x660E43,
	EGSJP_1_0_0_9 = 0x660E43,
	EGSJP_1_0_0_10 = 0x660E44,
	SteamGlobal_1_0_0_1 = 0x660EF3,
	SteamGlobal_1_0_0_2 = 0x660EF3,
	SteamJP_1_0_0_1 = 0x660E74,
	SteamJP_1_0_0_2 = 0x660E74,
}

version = nil
canExecute = false

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

for _, version_name in ipairs(versions) do
	if ReadByte(versions_table[version_name]) == 106 then
		version = version_name
	end
end

if version then
	importVars(version)
	canExecute = true
else
	ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
end
