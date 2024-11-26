LUAGUI_NAME = "Unlock Charcater Select"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Charcater Select"

function _OnInit()
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("Birth by Sleep not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteByte(unlock, 7)
	end
end