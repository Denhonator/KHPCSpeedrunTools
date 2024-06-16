LUAGUI_NAME = "1fmHookShip"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Makes Hook Ship always appear when conditions are met"

local hookship = 0xED751E
local dest = 0x508280
local neverland = 0x2DEBBD7
local posDebugString = 0x3EB158
local posDebug1 = 0x232E6A0
local posDebug2 = 0x2538964
local ingummi = 0x5082AD

local debug1Value = 1
local offset = 0x0
local debugOffset = 0x0
local canExecute = false


function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("KH1 detected, running script")
		canExecute = true
		if ReadByte(posDebugString) ~= 0x58 and ReadByte(posDebugString-0x1020) == 0x58 then
			ConsolePrint("JP EG detected, setting offsets")
			offset = 0x1000
			debugOffset = 0x1020
		end
		hookship = hookship - offset
		dest = dest - offset
		neverland = neverland - offset
		posDebugString = posDebugString - debugOffset
		posDebug1 = posDebug1 - offset
		debug1Value = 2
		posDebug2 = posDebug2 - offset
		ingummi = ingummi - offset
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