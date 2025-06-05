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
			msg_part_1 = string.format("%s.lua missing, get it from the Github!", string.sub(file, slashIdx + 1, #file))
			msg_part_2 = "\nMissing file is from the Rando folder inside io_packages."
			msg = string.format("%s%s", msg_part_1, msg_part_2)
		else
			msg_part_1 = string.format("%s.lua missing, get it from the Github!", file)
			msg_part_2 = "\nMissing file is from the io_packages folder."
			msg = string.format("%s%s", msg_part_1, msg_part_2)
		end
		ConsolePrint(string.format("%s%s%s", errorString, msg, errorString))
	else
		-- Extra check for version overlaps - first 4 of string
		if ReadByte(beepHack) == 9 then
			if slashIdx then
				ConsolePrint(string.format("Running with %s!", string.sub(file, slashIdx + 1, #file)))
			else
				ConsolePrint(string.format("Running with %s!", file))
			end
			return true
		end
	end
	return false
end

canExecute = true
ConsolePrint("KH1 detected, running script")
for _, version_name in ipairs(versions) do
	if ReadByte(versions_table[version_name]) == 106 then
		if importVars(version_name) then
			canExecute = true
			break
		end
	end
end

if not canExecute then
	ConsolePrint("\n\n!!!!!!!! VERSION ERROR !!!!!!!!\n\nVersion check failed, check variable file version numbers against game version")
end
