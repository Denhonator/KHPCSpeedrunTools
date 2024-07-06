LUAGUI_NAME = "1fm4By3"
LUAGUI_AUTH = "denhonator (edited by deathofall84)"
LUAGUI_DESC = "Changes aspect ratio. Visit display settings to apply"

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
				vars.height = vars.height - 0x80
			end
		end
	else
		ConsolePrint("KH1 not detected, not running script")
	end
end

function _OnFrame()
	if canExecute then
		WriteFloat(vars.height, 12.0) -- Sets aspect ratio to 16:12 = 4:3
	end
end