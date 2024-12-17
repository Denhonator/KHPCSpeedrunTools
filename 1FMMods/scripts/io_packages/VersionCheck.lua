-- Current Versions are 1.0.0.2 (Steam) and 1.0.0.10 Epic Games Store
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
	EGSGlobal_1_0_0_8 = 0x46726E,
	EGSGlobal_1_0_0_9 = 0x46A7A2,
	EGSGlobal_1_0_0_10 = 0x46A822,
	EGSJP_1_0_0_8 = 0x46726E,
	EGSJP_1_0_0_9 = 0x4697A2,
	EGSJP_1_0_0_10 = 0x46A802,
	SteamGlobal_1_0_0_1 = 0x469872,
	SteamGlobal_1_0_0_2 = 0x4698D2,
	SteamJP_1_0_0_1 = 0x4697F2,
	SteamJP_1_0_0_2 = 0x469872,
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

canExecute = true
ConsolePrint("KH1 detected, running script")
for _, version_name in ipairs(versions) do
	if ReadByte(versions_table[version_name]) == 106 then
		importVars(version_name)
		canExecute = true
		-- Extra check for version overlaps - first 4 of string
		if ReadInt(posDebugString) == 540680280 then
			break
		end
	end
end

if not canExecute then
	ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
end
