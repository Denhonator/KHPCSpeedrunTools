canExecute = false

file_names = {
	"custom_settings",
	"cheat_settings",
	"settings"
}

function importSettings(file)
	local slashIdx = string.find(file, "/")
	if not pcall(require, file) then
		local errorString = "\n\n!!!!!!!! IMPORT ERROR !!!!!!!!\n\n"
		local msg = ""
		msg_part_1 = string.format("%s.lua missing, get it from the Github!", file)
		msg_part_2 = "\nMissing file is from the io_packages folder."
		msg = string.format("%s%s", msg_part_1, msg_part_2)
		ConsolePrint(string.format("%s%s%s", errorString, msg, errorString))
	else
		-- Extra check for version overlaps - first 4 of string
		if ReadByte(beepHack) == 9 then
			ConsolePrint(string.format("Running with %s!", file))
			return true
		end
	end
	return false
end

canExecute = true
ConsolePrint("KH1 detected, running script")
for _, file_name in ipairs(file_names) do
	if importSettings(file_name) then
		canExecute = true
		break
	end
end

if not canExecute then
	ConsolePrint("\n\n!!!!!!!! ERROR !!!!!!!!\n\nSettings file not found, ensure that one of settings.lua, cheat_settings.lua, or custom_settings.lua are in the io_packages folder.")
end
