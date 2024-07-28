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
			require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			posDebugString = posDebugString - 0x1020
			require("EpicGamesJP")
		else
			posDebugString = posDebugString - 0xE40
			if ReadByte(posDebugString) ~= 0x58 then -- Steam JP specific changes
				posDebugString = posDebugString - 0x80
			end
			require("SteamGlobal") -- Global and JP equal
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadByte(hookship) == 1 and ReadByte(dest) == 13 and ReadByte(neverland) == 2 then
			WriteByte(hookship, 0)
			WriteString(posDebugString, "            Hook  ship  100%%!              ")
		end

		if ReadByte(dest) == 13 and ReadByte(neverland) == 2 and ReadByte(posDebug1) == 0 and ReadInt(ingummi) == 0 then
			WriteByte(posDebug1, debug1Value)
			WriteByte(posDebug2, 1)
			WriteString(posDebugString, "            Hook  ship  100%%               ")
		end

		if (ReadByte(neverland) ~= 2 or ReadByte(dest) ~= 13) and ReadByte(posDebug1) == debug1Value then
			WriteByte(posDebug1, 0)
			WriteByte(posDebug2, 0)
			WriteString(posDebugString, "X : %4.2f  Y : %4.2f  Z : %4.2f  Dir : %4.2f")
		end
	end
end
