LUAGUI_NAME = "Unlock Reverse Rebirth"
LUAGUI_AUTH = "KSX (edited by deathofall84)"
LUAGUI_DESC = "Unlock Reverse Rebirth"

function _OnInit()
	if GAME_ID == 0x9E3134F5 and ENGINE_TYPE == "BACKEND" then
		if ReadByte(0x4E6C80) == 255 or ReadByte(0x4E6AC0) == 255 then
			gamecomplete = 0x87AA90
			ConsolePrint("Epic Version")
		elseif ReadByte(0x4E7040) == 255 or ReadByte(0x4E6DC0) == 255 then
			gamecomplete = 0x87B190
			ConsolePrint("Steam Version")
		end
		ConsolePrint("Unlock New Game Plus Content - installed")
	end
end

function _OnFrame()
	if ReadByte(gamecomplete) < 3 then
		WriteByte(gamecomplete, 3)
	end
end
