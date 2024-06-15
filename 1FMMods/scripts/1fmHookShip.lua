LUAGUI_NAME = "1fmHookShip"
LUAGUI_AUTH = "denhonator"
LUAGUI_DESC = "Makes Hook Ship always appear when conditions are met"

local offset = 0x3A2B86
local hookship = 0xED751E - offset
local dest = 0x508280 - offset
local neverland = 0x2DEBBD7 - offset
local posDebugString = 0x3EB158 - offset
local posDebug1 = 0x232E6A0 - offset
local posDebug2 = 0x2538964 - offset
local ingummi = 0x5082AD - offset

local canExecute = false

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		canExecute = true
		if ReadByte(posDebugString) ~= 0x58 and ReadByte(posDebugString-0x20) == 0x58 then
			posDebugString = posDebugString - 0x20
			ConsolePrint("JP detected, adjusting address")
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
			WriteByte(posDebug1, 1)
			WriteByte(posDebug2, 1)
			WriteString(posDebugString, "            Hook  ship  100%%               ")
		end
		
		if (ReadByte(neverland) ~= 2 or ReadByte(dest) ~= 13) and ReadByte(posDebug1) == 1 then
			WriteByte(posDebug1, 0)
			WriteByte(posDebug2, 0)
			WriteString(posDebugString, "X : %4.2f  Y : %4.2f  Z : %4.2f  Dir : %4.2f")
		end
	end
end