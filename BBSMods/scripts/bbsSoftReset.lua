LUAGUI_NAME = "bbsSoftReset"
LUAGUI_AUTH = "deathofall84 (Credits to Topaz and KSX)"
LUAGUI_DESC = "Soft reset with shoulder buttons + start (options)"

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
		WriteByte(titleSkip1, 115)
		WriteByte(titleSkip2, 115)
		WriteByte(titleSkip3, 115)
		if ReadInt(input) == 3848 then
			WriteInt(location, 16777215)
			WriteByte(softreset, 1)
		end
	end
end
