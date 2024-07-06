LUAGUI_NAME = "1fmFasterAnims"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Speeds up animations during which you can't play"

local summonSpeedup = true
local speedMult = 2.0

local canExecute = false
local posDebugString = 0x3EB158

function _OnInit()
	if GAME_ID == 0xAF71841E and ENGINE_TYPE == "BACKEND" then
		canExecute = true
		ConsolePrint("KH1 detected, running script")
		if ReadByte(posDebugString) == 0x58 then
			vars = require("EpicGamesGlobal")
		elseif ReadByte(posDebugString - 0x1020) == 0x58 then
			vars = require("EpicGamesJP")
		elseif ReadByte(posDebugString - 0xE40) == 0x58 then
			vars = require("SteamGlobal") -- Global and JP equal
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		if ReadFloat(vars.soraHUD) < 1 and ReadInt(vars.animCutscene) > 0
			and ReadInt(vars.animCutscene) ~= 8  and ReadInt(vars.skippable) ~= 1025
			and (ReadInt(vars.summoning) == 0 or summonSpeedup)
			and not (
				ReadByte(vars.world) == 6 and ReadByte(vars.room) == 8
				and ReadInt(vars.minitimer) >= 9000.0
			)
			and not (
				ReadByte(vars.world) == 1 and ReadByte(vars.room) == 2
				and (ReadByte(vars.dialog) >= 1 and ReadByte(vars.dialog) <= 5)
			) then
			WriteFloat(vars.animSpeed, speedMult)
		else
			WriteFloat(vars.animSpeed, 1.0)
		end
	end
end