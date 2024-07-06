LUAGUI_NAME = "1fmUnskippable"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Makes unskippable cutscenes skippable"

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
		if ReadInt(vars.cutscene) > 0 and (ReadByte(vars.world) == 4 or ReadByte(vars.world) == 15) and ReadInt(vars.summoning) == 0 then
			WriteByte(vars.skippable, 1)
		end
	end
end