LUAGUI_NAME = "Unlock Reverse Rebirth"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Reverse Rebirth"

local canExecute = false

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Re:CoM detected")
		canExecute = true
		epic_gl = ReadByte(0x3A2FD9)
		epic_jp = ReadByte(0x3A2E19)
		if epic_gl == 117 or epic_gl == 115 or epic_jp == 117 or epic_jp == 115 then
			gamecomplete = 0x87AA90
			ConsolePrint("Epic Version")
		else
			gamecomplete = 0x87B190
			ConsolePrint("Steam Version")
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
