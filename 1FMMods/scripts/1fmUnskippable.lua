LUAGUI_NAME = "1fmUnskippable"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Makes unskippable cutscenes skippable"

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadInt(cutscene) > 0 and (ReadByte(world) == 4 or ReadByte(world) == 15) and ReadInt(summoning) == 0 then
			WriteByte(skippable, 1)
		end
	end
end
