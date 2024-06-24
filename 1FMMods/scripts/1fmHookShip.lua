LUAGUI_NAME = "1fmHookShip"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Makes Hook Ship always appear when conditions are met"

local posDebugString = 0x3EB158
local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 or ReadByte(posDebugString - 0x1020) == 0x58 then
			ConsolePrint("Epic Games detected")
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Global version detected")
				offset = 0x0
				debug1Value = 1
			elseif ReadByte(posDebugString - 0x1020) == 0x58 then
				ConsolePrint("JP version detected")
				posDebugString = posDebugString - 0x1020
				offset = 0x1000
				debug1Value = 2
			end
			hookship = 0xED751E - offset
			dest = 0x508280 - offset
			neverland = 0x2DEBBD7 - offset
			posDebug1 = 0x232E6A0 - offset
			posDebug2 = 0x2538964 - offset
			ingummi = 0x5082AD - offset
		else
			ConsolePrint("Steam detected")
			posDebugString = 0x3EA318
			if ReadByte(posDebugString) == 0x58 then
				ConsolePrint("Global version detected")
			elseif ReadByte(posDebugString - 0x80) == 0x58 then
				ConsolePrint("JP version detected")
				posDebugString = posDebugString - 0x80
			end
			dest = 0x507580
			hookship = 0xED6A1E
			neverland = 0x2DEB257
			posDebug1 = 0x232DD20
			posDebug2 = 0x2537E40
			ingummi = 0x5075AD
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