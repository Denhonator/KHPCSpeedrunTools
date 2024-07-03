LUAGUI_NAME = "Unlock Critical Mode"
LUAGUI_AUTH = "deathofall84 (original by KSX)"
LUAGUI_DESC = "Unlock Critical Mode"

function _OnInit()
	if GAME_ID == 0xE86A2A90 and ENGINE_TYPE == "BACKEND" then
		ConsolePrint("Dream Drop Distance deteceted")
		canExecute = true
		if ReadByte(0x8A9046) == 0x6A then
			ConsolePrint("Epic Games Version")
			unlock = 0xA72CF3
		else
			ConsolePrint("Steam Version")
			unlock = 0xA73473
		end
	end
end

function _OnFrame()
	if canExecute then
		if ReadByte(unlock) == 0 then
			WriteByte(unlock, 1)
		end
	end
end
