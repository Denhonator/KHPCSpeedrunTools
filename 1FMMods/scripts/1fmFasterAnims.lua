LUAGUI_NAME = "1fmFasterAnims"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up animations during which you can't play"

local summonSpeedup = true
local speedMult = 2.0

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadFloat(soraHUD) < 1 and ReadInt(inCutscene) > 0
			and ReadInt(inCutscene) ~= 8  and ReadInt(skippable) ~= 1025
			and (ReadInt(summoning) == 0 or summonSpeedup)
			and not (
				ReadByte(world) == 6 and ReadByte(room) == 8
				and ReadInt(minitimer) >= 9000.0
			)
			and not (
				ReadByte(world) == 1 and ReadByte(room) == 2
				and (ReadByte(dialog) >= 1 and ReadByte(dialog) <= 5)
			) then
			WriteFloat(animSpeed, speedMult)
		else
			WriteFloat(animSpeed, 1.0)
		end
	end
end
