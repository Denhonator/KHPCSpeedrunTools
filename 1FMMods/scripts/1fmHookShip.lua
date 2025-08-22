LUAGUI_NAME = "1fmHookShip"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Makes Hook Ship always appear when conditions are met"

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		dest_check = ReadByte(dest) == 13 and ReadByte(neverland) == 2
		if ReadByte(hookship) == 1 and dest_check then
			WriteByte(hookship, 0)
			WriteString(posDebugString, "            Hook  ship  100%%!              ")
		end

		if dest_check and ReadByte(posDebug1) == 0 and ReadInt(inGummi) == 0 then
			WriteByte(posDebug1, debug1Value)
			WriteByte(posDebug2, 1)
			WriteString(posDebugString, "            Hook  ship  100%%               ")
		end

		if not dest_check and ReadByte(posDebug1) == debug1Value then
			WriteByte(posDebug1, 0)
			WriteByte(posDebug2, 0)
			WriteString(posDebugString, "X : %4.2f  Y : %4.2f  Z : %4.2f  Dir : %4.2f")
		end
	end
end

