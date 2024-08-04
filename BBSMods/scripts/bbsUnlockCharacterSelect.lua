LUAGUI_NAME = "Unlock Charcater Select"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Charcater Select"

local canExecute = false

function _OnInit()
	if GAME_ID == 0xBED4B944 and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("Birth by Sleep detected")
		if ReadByte(0x7262E4) == 106 then
			require("EpicGamesGlobal")
		elseif ReadByte(0x7252E4) == 106 then
			require("EpicGamesJP")
		else
			require("SteamGlobal") -- Global and JP version addresses are shared
		end
	else
		ConsolePrint("Birth by Sleep not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteByte(unlock, 7)
	end
end