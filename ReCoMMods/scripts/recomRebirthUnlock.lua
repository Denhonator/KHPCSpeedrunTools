LUAGUI_NAME = "recomRebirthUnlock"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Reverse Rebirth"

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("Re:Chain of Memories not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadByte(gamecomplete) < 3 then
			WriteByte(gamecomplete, 3)
		end
	end
end
