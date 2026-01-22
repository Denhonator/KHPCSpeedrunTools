LUAGUI_NAME = "3dOvercast"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Changes all forecasts to overcast"

function _OnInit()
	if GAME_ID == 0xE86A2A90 and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("Dream Drop Distance not detected, not running script")
	end
end

function _OnFrame()
	for i = 0, 20 do
		WriteByte(forecast + i * 8, 6)
	end
end
