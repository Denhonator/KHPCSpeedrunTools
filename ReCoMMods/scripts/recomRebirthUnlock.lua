LUAGUI_NAME = "Unlock Reverse Rebirth"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Reverse Rebirth"

local canExecute = false

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Re:CoM detected")
		canExecute = true
		if ReadByte(0x7050E8) == 106 then
			require("EpicGamesGlobal")
		else if ReadByte(0x7050C8) == 106 then
			require("EpicGamesJP")
		else if ReadByte(0x7051E8) == 106 then
			require("SteamGlobal")
		else
			require("SteamJP")
		end
	end
end

function _OnFrame()
	if canExecute then
		if ReadByte(gamecomplete) < 3 then
			WriteByte(gamecomplete, 3)
		end
	end
end
