LUAGUI_NAME = "Unlock Critical Mode"
LUAGUI_AUTH = "deathofall84 (original by KSX)"
LUAGUI_DESC = "Unlock Critical Mode"

function _OnInit()
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("Dream Drop Distance not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadByte(unlock) == 0 then
			WriteByte(unlock, 1)
		end
	end
end
