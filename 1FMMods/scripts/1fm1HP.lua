LUAGUI_NAME = "1fm1HP"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Forces Sora's max HP to 1 and removes beeping noise"

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		require("VersionCheck")
		if canExecute then
			WriteByte(beepHack, 1)
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteByte(maxHP, 1)
	end
end
