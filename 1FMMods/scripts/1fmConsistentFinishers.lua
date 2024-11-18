LUAGUI_NAME = "1fmConsistentFinishers"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "30% chance finishers are now 100%"

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadShort(zantHack) ~= zantValue then
			WriteFloat(gravBreak, -1.0)
			WriteShort(zantHack, zantValue) -- 88 offset from original value
		end
	end
end
