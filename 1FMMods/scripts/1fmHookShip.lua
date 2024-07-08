LUAGUI_NAME = "1fmHookShip"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Makes Hook Ship always appear when conditions are met"

local canExecute = false
local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			vars = require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			posDebugString = posDebugString - 0x1020
			vars = require("EpicGamesJP")
		else
			posDebugString = posDebugString - 0xE40
			if ReadByte(posDebugString) ~= 0x58 then
				posDebugString = posDebugString - 0x80 -- JP String
			end
			vars = require("SteamGlobal") -- Global and JP equal
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadByte(vars.hookship) == 1 and ReadByte(vars.dest) == 13 and ReadByte(vars.neverland) == 2 then
			WriteByte(vars.hookship, 0)
			WriteString(posDebugString, "            Hook  ship  100%%!              ")
		end
		
		if ReadByte(vars.dest) == 13 and ReadByte(vars.neverland) == 2 and ReadByte(vars.posDebug1) == 0 and ReadInt(vars.ingummi) == 0 then
			WriteByte(vars.posDebug1, vars.debug1Value)
			WriteByte(vars.posDebug2, 1)
			WriteString(posDebugString, "            Hook  ship  100%%               ")
		end
		
		if (ReadByte(vars.neverland) ~= 2 or ReadByte(vars.dest) ~= 13) and ReadByte(vars.posDebug1) == vars.debug1Value then
			WriteByte(vars.posDebug1, 0)
			WriteByte(vars.posDebug2, 0)
			WriteString(posDebugString, "X : %4.2f  Y : %4.2f  Z : %4.2f  Dir : %4.2f")
		end
	end
end
