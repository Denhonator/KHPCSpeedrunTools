LUAGUI_NAME = "1fmFasterAnims"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up animations during which you can't play"

local sceneSpeedup = true
local summonSpeedup = true
local speedMult = 2.0

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		require("VersionCheck")
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function any(array, value)
	for _, val in pairs(array) do
		if val == value then return true end
	end
	return false
end

function inTimedEvent()
	return ReadInt(minitimer) > 0 and any({6, 11}, ReadByte(world))
end

function inSummoning()
	return ReadInt(summoning) == 0 or summonSpeedup
end

function inScene()
	return (ReadFloat(soraHUD) < 1 and ReadInt(inCutscene) > 0 and ReadInt(inCutscene) ~= 8  and ReadInt(skippable) ~= 1025) or sceneSpeedup
end

function inDIBoatSide()
	return ReadByte(world) == 1 and ReadByte(room) == 2 and (ReadByte(dialog) >= 1 and ReadByte(dialog) <= 5)
end

function _OnFrame()
	if canExecute then
		if inScene() and inSummoning() and not inTimedEvent() and not inDIBoatSide() then
			WriteFloat(animSpeed, speedMult)
		else
			WriteFloat(animSpeed, 1.0)
		end
	end
end
