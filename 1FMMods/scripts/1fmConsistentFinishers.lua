LUAGUI_NAME = "1fmConsistentFinishers"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "30% chance finishers are now 100%"

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if zantValue == 0 then
			zantValue = ReadShort(zantHack) + 78
		end
		if ReadShort(zantHack) ~= zantValue then
			WriteFloat(gravBreak, -1.0)
			WriteShort(zantHack, zantValue)
		end
	end
end
