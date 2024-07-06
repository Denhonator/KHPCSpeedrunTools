LUAGUI_NAME = "1fmBeepHack"
LUAGUI_AUTH = "deathofall84"
LUAGUI_DESC = "Removes low health beeping noise, works up to max health of 41"

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
		else
			vars = require("SteamGlobal") -- Global and JP equal
			if ReadByte(posDebugString - 0xE40) ~= 0x58 then
				vars.beepHack = vars.beepHack - 0x280
			end
		end
		WriteByte(vars.beepHack, 1)
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
end
