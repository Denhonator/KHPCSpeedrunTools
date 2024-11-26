LUAGUI_NAME = "1fmBeepHack"
LUAGUI_AUTH = "deathofall84"
LUAGUI_DESC = "Removes low health beeping noise, works up to max health of 41"

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
		if canExecute then
			WriteByte(beepHack, 1)
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
end

