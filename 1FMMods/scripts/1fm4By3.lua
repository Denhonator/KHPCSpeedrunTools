LUAGUI_NAME = "1fm4By3"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Changes aspect ratio. Visit display settings to apply"

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteFloat(height, 12.0) -- Sets aspect ratio to 16:12 = 4:3
	end
end
