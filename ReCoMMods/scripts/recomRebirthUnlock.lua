LUAGUI_NAME = "Unlock Reverse Rebirth"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Reverse Rebirth"

local offset = 0x4E4660
local button = 0x81F18B - offset
local gamecomplete = 0x877990 - offset

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Unlock New Game Plus Content - installed")
	end
end

function _OnFrame()
	if ReadByte(gamecomplete) < 3 then
		WriteByte(gamecomplete, 3)
	end
end
