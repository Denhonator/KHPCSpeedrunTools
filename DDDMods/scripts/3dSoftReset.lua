LUAGUI_NAME = "dddSoftReset"
LUAGUI_AUTH = "deathofall84 (original by denhonator)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start"

function _OnInit()
	if GAME_ID == 0xE86A2A90 and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
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
